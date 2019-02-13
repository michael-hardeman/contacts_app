
with GNATCOLL.JSON; use GNATCOLL.JSON;
with GNAT.SHA256;

package body Authorization.Credentials is

   ----------
   -- Salt --
   ----------
   function Salt (Item : in String) return String is (Item & "contacts_app");
   
   -----------
   -- Parse --
   -----------
   -- The implementation is wrapped for error handling.
   function Parse (Binary_Data : in  Stream_Element_Array) return Credential_Model
   is
      function Implementation (Binary_Data : in  Stream_Element_Array) return Credential_Model
      is
         Data : UTF8_String (1 .. Binary_Data'Length);
         for Data'Address use Binary_Data'Address;
      
         Parsed   : JSON_Value  := Read (Data);
         Username : UTF8_String := Get (Val => Parsed, Field => "username");
         Password : UTF8_String := Get (Val => Parsed, Field => "password");
         Hashed   : String      := GNAT.SHA256.Digest (Salt (Password));
      begin
         return Credential_Model'(Username_Length => Username'Length,
                                  Password_Length => Hashed'Length,
                                  Username        => Username,
                                  Password        => Hashed);
      end;
   begin
      return Implementation (Binary_Data);
   exception
      when others => raise Parsing_Error;
   end;

end;
