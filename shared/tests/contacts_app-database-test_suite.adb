with Contacts_App.Database.Tests;

package body Contacts_App.Database.Test_Suite is

   Result : aliased AUnit.Test_Suites.Test_Suite;

   Database_Test_Case : aliased Contacts_App.Database.Tests.TC;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
   begin
      AUnit.Test_Suites.Add_Test (Result'Access, Database_Test_Case'Access);
      return Result'Access;
   end Suite;

end;
