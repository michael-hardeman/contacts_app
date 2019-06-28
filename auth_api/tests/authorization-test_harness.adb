
with AUnit.Run;
with AUnit.Reporter.Text;

with Authorization.Credentials.Test_Suite;
with Authorization.Users.Test_Suite;

procedure Authorization.Test_Harness is

   procedure Run_Credentials_Tests
      is new AUnit.Run.Test_Runner (Authorization.Credentials.Test_Suite.Suite);

   procedure Run_Users_Tests
      is new AUnit.Run.Test_Runner (Authorization.Users.Test_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Reporter.Set_Use_ANSI_Colors (True);

   Run_Credentials_Tests (Reporter);
   Run_Users_Tests (Reporter);
end;
