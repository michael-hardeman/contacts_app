
with AUnit.Assertions; use AUnit.Assertions;
pragma Elaborate_All (AUnit);
pragma Elaborate_All (AUnit.Assertions);

with Contacts_App.Database;
with Authorization.Test_Utilities.Common; use Authorization.Test_Utilities.Common;


package body Authorization.Credentials.Tests is

   ---------------
   -- Constants --
   ---------------
   Driver : Contacts_App.Database.Database_Driver;

   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Contacts_App.Database.Connect (Driver   => Driver,
                                     Database => ,
                                     Log      => )
      Register_Routine (T, Test_Placeholder'Access, "Placeholder");
   end Register_Tests;

   ----------------------
   -- Test_Placeholder --
   ----------------------
   procedure Test_Placeholder (Test : in out Test_Cases.Test_Case'Class) is
   begin
      Assert_Booleans_Equal (True, True);
   end;

end;
