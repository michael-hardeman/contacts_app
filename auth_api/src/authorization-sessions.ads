with Ada.Calendar;

with Contacts_App.Database;
with Authorization.Credentials;

package Authorization.Sessions is

   type Session_Model (Token_Length : Natural) is record
      User_ID : Integer;
      Token   : String (1 .. Token_Length);
      Updated : Ada.Calendar.Time;
   end record;
   
   INVALID_TIME : constant Ada.Calendar.Time := Ada.Calendar.Time_Of(Year    => 1901,
                                                                     Month   => 1,
                                                                     Day     => 1,
                                                                     Seconds => 0.0);
   
   NO_SESSION : constant Session_Model := Session_Model'(Token_Length => Positive'First, 
                                                         User_ID      => Natural'First, 
                                                         Token        => (1 .. 1 => ASCII.NUL), 
                                                         Updated      => INVALID_TIME);
   
   function Get_By_User_ID   (User_ID : in Natural)                      return Session_Model;
   function Create           (User_ID : in Natural)                      return Session_Model;
   function Create_Or_Revive (Creds   : in Credentials.Credential_Model) return Session_Model;
   function Serialize        (Session : in Session_Model)                return String;
   
   Invalid_Credentials : exception;
end;

