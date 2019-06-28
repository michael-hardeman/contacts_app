
with AUnit; use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

with Contacts_App.Database.In_Memory; use Contacts_App.Database.In_Memory;

package Authorization.Users.Tests is

   type TC is new Test_Cases.Test_Case with record
      Driver : Database_Driver;
   end record;

   function Name (T : TC) return Message_String is (Aunit.Format ("Authorization.Users"));

   overriding procedure Register_Tests (Test : in out TC);
   overriding procedure Set_Up_Case    (Test : in out TC);
   overriding procedure Tear_Down_Case (Test : in out TC);

   procedure Test_Get_By_ID          (Test : in out Test_Cases.Test_Case'Class);
   procedure Test_Get_By_Credentials (Test : in out Test_Cases.Test_Case'Class);
end;

