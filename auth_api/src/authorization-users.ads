with Authorization.Credentials;

package Authorization.Users is

   type User_Model (Name_Length        : Positive;
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

   function Get_By_ID (ID : in Natural) return User_Model;
   function Get_By_Credentials (Creds : in Credentials.Credential_Model) return User_Model;

   User_Not_Found : Exception;
end;
