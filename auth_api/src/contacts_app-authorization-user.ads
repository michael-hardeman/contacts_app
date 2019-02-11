with Contacts_App.Models.Credentials;

package Contacts_App.Models.User is

   type User_State (Name_Length        : Positive;
                    Password_Length    : Positive;
                    Given_Name_Length  : Positive;
                    Family_Name_Length : Positive)
   is record
      ID          : Natural;
      Name        : String (1 .. Name_Length);
      Password    : String (1 .. Password_Length);
      Given_Name  : String (1 .. Given_Name_Length);
      Family_Name : String (1 .. Family_Name_Length);
   end record;

   function Get_By_ID (ID : in Natural) return User_State;
   function Get_By_Credentials (Credentials : in Models.Credentials.Credentials_State) return User_State;

   User_Not_Found : Exception;
end;
