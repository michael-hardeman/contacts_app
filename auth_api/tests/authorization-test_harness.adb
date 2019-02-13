
with AUnit.Run;
with AUnit.Reporter.Text;
pragma Elaborate_All (AUnit);
pragma Elaborate_All (AUnit.Run);
pragma Elaborate_All (AUnit.Reporter);
pragma Elaborate_All (AUnit.Reporter.Text);

with Authorization.Test_Suite;

procedure Authorization.Test_Harness is

   procedure Run_Authorization_Test is new AUnit.Run.Test_Runner (Authorization.Test_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Reporter.Set_Use_ANSI_Colors (True);

   Run_Authorization_Test (Reporter);
end;
