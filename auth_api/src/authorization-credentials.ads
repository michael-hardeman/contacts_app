with Ada.Streams; use Ada.Streams;

package Authorization.Credentials is
   
   type Credential_Model (
      Username_Length : Positive; 
      Password_Length : Positive) 
   is record
      Username : String (1 .. Username_Length);
      Password : String (1 .. Password_Length);
   end record;
   
   function Parse (Binary_Data : in Stream_Element_Array) return Credential_Model;

   Parsing_Error : exception;
   
end;
