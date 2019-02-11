with Ada.Calendar;

with Contacts_App.Database;
with Contacts_App.Authorization.Credentials;

package Contacts_App.Authorization.Session is

   type Session_State (Token_Length : Natural) is record
      User_ID : Integer;
      Token   : String (1 .. Token_Length);
      Updated : Ada.Calendar.Time;
   end record;
   
   No_Session_Updated : constant Ada.Calendar.Time := Ada.Calendar.Time_Of(Year    => 1901,
                                                                           Month   => 1,
                                                                           Day     => 1,
                                                                           Seconds => 0.0);
   
   No_Session : constant Session_State := Session_State'(Token_Length => Positive'First, 
                                                         User_ID      => Natural'First, 
                                                         Token        => (1 .. 1 => ASCII.NUL), 
                                                         Updated      => No_Session_Updated);
   
   function Get_By_User_ID   (User_ID     : in Natural)                                     return Session_State;
   function Create           (User_ID     : in Natural)                                     return Session_State;
   function Create_Or_Revive (Credentials : in Authorization.Credentials.Credentials_State) return Session_State;
   function Serialize        (Session     : in Session_State)                               return String;
   
   Invalid_Credentials : exception;
end;

