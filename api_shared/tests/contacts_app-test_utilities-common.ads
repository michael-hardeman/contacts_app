package Contacts_App.Test_Utilities.Common is

  ----------------------------
  -- Generic Instantiations --
  ----------------------------
  function String_Image (Item : in String) return String is (Item);
  
  procedure Assert_Booleans_Equal    is new Assert_Definite_Equal   (Boolean,  "=", Boolean'Image);
  procedure Assert_Naturals_Equal    is new Assert_Definite_Equal   (Natural,  "=", Natural'Image);
  procedure Assert_Positives_Equal   is new Assert_Definite_Equal   (Positive, "=", Positive'Image);
  procedure Assert_Strings_Equal     is new Assert_Indefinite_Equal (String,   "=", String_Image);

end;
