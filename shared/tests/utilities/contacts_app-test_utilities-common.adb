with Ada.Strings.Unbounded;

package body Contacts_App.Test_Utilities.Common is
   function Stream_Element_Array_Image (Item : in Stream_Element_Array) return String is
      use Ada.Strings.Unbounded;

      Output : Unbounded_String;
   begin
      Append (Output, "[ ");
      for I in Item'Range loop
         Append (Output, Item (I)'Image);
         if I /= Item'Last then Append (Output, ", "); end if;
      end loop;
      Append (Output, " ]");

      return To_String (Output);
   end;
end;
