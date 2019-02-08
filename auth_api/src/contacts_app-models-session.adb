with Ada.Text_IO;
with Ada.Calendar.Arithmetic;

with GNATCOLL.JSON;
with AdaID.Generate;
with AdaBase.Results.Sets;
with Contacts_App.Models.User;

package body Contacts_App.Models.Session is

   use AdaBase;
   
   --------------------
   -- Get_By_User_ID --
   --------------------
   function Get_By_User_ID (User_ID : in Natural) return Session_State is
      Statement : Database.Statement_Type := Database.Driver.Prepare_Select (Tables     => "sessions", 
                                                                             Columns    => "*",
                                                                             Conditions => "user_id = :user_id");
   begin
      Statement.Assign ("user_id", User_ID'Image);
      
      if not Statement.Execute       then raise Database_Error; end if;
      if 0 = Statement.Rows_Returned then return No_Session;    end if;
      
      declare
         Row     : Results.Sets.Datarow := Statement.Fetch_Next;
         Token   : String               := Row.Column ("token").As_String;
         ID      : Natural              := Natural (Row.Column ("user_id").As_Byte4);
         Updated : Ada.Calendar.Time    := Row.Column ("updated").As_Time;
      begin
         return Session_State'(Token_Length => Token'Length,
                               User_ID      => ID,
                               Token        => Token,
                               Updated      => Updated);
      end;
   end;
   
   ------------
   -- Create --
   ------------
   function Create (User_ID : in Natural) return Session_State is
      
      function Generate_Token return String is
         Token : AdaID.UUID;
      begin
         AdaID.Generate.Random (Token);
         return AdaID.To_String (Token);
      end;
      
      Statement : Database.Statement_Type := Database.Driver.Prepare(SQL => "INSERT INTO sessions (user_id, token) VALUES (:user_id, :token)");
      Token     : String := Generate_Token;
   begin
      Statement.Assign ("user_id", User_ID'Image);
      Statement.Assign ("token", Token);
      
      if not Statement.Execute then
         Database.Driver.Rollback;
         raise Database_Error; 
      end if;
      Database.Driver.Commit;
      return Session_State'(Token_Length => Token'Length, 
                            User_ID      => User_ID, 
                            Token        => Token, 
                            Updated      => Ada.Calendar.Clock);
   end;
   
   -----------------------
   -- Delete_By_User_ID --
   -----------------------
   procedure Delete_By_User_ID (User_ID : in Natural) is
      Statement : Database.Statement_Type := Database.Driver.Prepare(SQL => "DELETE FROM sessions WHERE user_id = :user_id");
   begin
      Statement.Assign ("user_id", User_ID'Image);
      
      if not Statement.Execute then
         Database.Driver.Rollback;
         raise Database_Error; 
      end if;
      Database.Driver.Commit;
   end;
   
   ----------------
   -- Is_Expired --
   ----------------
   function Is_Expired (Session : in Session_State) return Boolean is
      use Ada.Calendar;
      use Ada.Calendar.Arithmetic;
      
      THIRTY_MINUTES : constant Duration := 60.0 * 30.0;
        
      Days         : Day_Count;
      Seconds      : Duration;
      Leap_Seconds : Leap_Seconds_Count;
   begin
      Difference (Clock, Session.Updated, Days, Seconds, Leap_Seconds);
      return (Days = 0 and then Seconds + Duration (Leap_Seconds) < THIRTY_MINUTES);
   end;
   
   ----------------------
   -- Update_Timestamp --
   ----------------------
   procedure Update_Timestamp (Session : in out Session_State) is
      Statement : Database.Statement_Type := Database.Driver.Prepare(SQL => "UPDATE sessions SET updated = CURRENT_TIMESTAMP WHERE user_id = :user_id");
   begin
      Statement.Assign ("user_id", Session.User_ID'Image);
      
      if not Statement.Execute then
         Database.Driver.Rollback;
         raise Database_Error; 
      end if;
      Database.Driver.Commit;
      Session.Updated := Ada.Calendar.Clock;
   end;
      
   ----------------------
   -- Create_Or_Revive --
   ----------------------
   function Create_Or_Revive (Credentials : in Models.Credentials.Credentials_State) return Session_State
   is
      User    : Models.User.User_State := Models.User.Get_By_Credentials (Credentials);
      Session : Session_State          := Get_By_User_ID (User.ID);
   begin
      if Session /= No_Session then
         if not Is_Expired (Session) then 
            Update_Timestamp (Session);
            return Session;   
         end if;
         Delete_By_User_ID (User.ID);
      end if;
      return Create (User.ID);
   end;
   
   ---------------
   -- Serialize --
   ---------------
   function Serialize (Session : in Session_State) return String is
      use GNATCOLL.JSON;
      
      Output : JSON_Value := Create_Object;
   begin
      Output.Set_Field ("token", Session.Token);
      return Write (Output);
   end;

end;
