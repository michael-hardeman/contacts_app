with Authorization.Tests;

package body Authorization.Credentials.Test_Suite is

   Result : aliased AUnit.Test_Suites.Test_Suite;

   Credentials_Test_Case : aliased Authorization.Credentials.Tests.TC;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
   begin
      AUnit.Test_Suites.Add_Test (Result'Access, Credentials_Test_Case'Access);
      return Result'Access;
   end Suite;

end;
