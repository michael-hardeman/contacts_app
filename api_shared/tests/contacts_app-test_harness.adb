
with AUnit.Run;
with AUnit.Reporter.Text;
pragma Elaborate_All (AUnit);
pragma Elaborate_All (AUnit.Run);
pragma Elaborate_All (AUnit.Reporter);
pragma Elaborate_All (AUnit.Reporter.Text);

with Contacts_App.Database.Test_Suite;

procedure Contacts_App.Test_Harness is

   procedure Run_Contacts_App_Test
      is new AUnit.Run.Test_Runner (Contacts_App.Test_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Reporter.Set_Use_ANSI_Colors (True);

   Run_Contacts_App_Test (Reporter);
end;
