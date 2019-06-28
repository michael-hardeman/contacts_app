with Authorization.Users.Tests;

package body Authorization.Users.Test_Suite is

   Result : aliased AUnit.Test_Suites.Test_Suite;

   Users_Test_Case : aliased Authorization.Users.Tests.TC;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
   begin
      AUnit.Test_Suites.Add_Test (Result'Access, Users_Test_Case'Access);
      return Result'Access;
   end Suite;

end;
