with Authorization.Tests;

package body Authorization.Test_Suite is

  Result : aliased AUnit.Test_Suites.Test_Suite;

  Authorization_Test_Case : aliased Authorization.Tests.TC;

  function Suite return AUnit.Test_Suites.Access_Test_Suite is
  begin
    AUnit.Test_Suites.Add_Test (Result'Access, Authorization_Test_Case'Access);
    return Result'Access;
  end Suite;

end;
