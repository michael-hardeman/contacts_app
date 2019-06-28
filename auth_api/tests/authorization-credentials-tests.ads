
with AUnit; use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Authorization.Credentials.Tests is

   type TC is new Test_Cases.Test_Case with null record;

   function Name (T : TC) return Message_String is (Aunit.Format ("Authorization.Credentials"));

   overriding procedure Register_Tests (T : in out TC);

   procedure Test_Parse_Empty     (Test : in out Test_Cases.Test_Case'Class);
   procedure Test_Parse_Invalid   (Test : in out Test_Cases.Test_Case'Class);
   procedure Test_Parse_Incorrect (Test : in out Test_Cases.Test_Case'Class);
   procedure Test_Parse_Valid     (Test : in out Test_Cases.Test_Case'Class);
end;

