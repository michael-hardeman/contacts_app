with Ada.Streams; use Ada.Streams;

package Contacts_App.Test_Utilities.Common is

  ----------------------------
  -- Generic Instantiations --
  ----------------------------
  function String_Image (Item : in String) return String is (Item);
  function Stream_Element_Array_Image (Item : in Stream_Element_Array) return String; 
  
  procedure Assert_Booleans_Equal    is new Assert_Definite_Equal   (Boolean,  "=", Boolean'Image);
  procedure Assert_Naturals_Equal    is new Assert_Definite_Equal   (Natural,  "=", Natural'Image);
  procedure Assert_Positives_Equal   is new Assert_Definite_Equal   (Positive, "=", Positive'Image);
  procedure Assert_Strings_Equal     is new Assert_Indefinite_Equal (String,   "=", String_Image);
  procedure Assert_Stream_Element_Arrays_Equal is new Assert_Indefinite_Equal (Stream_Element_Array, "=", Stream_Element_Array_Image);

end;

