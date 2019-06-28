
with AUnit.Assertions; use AUnit.Assertions;

with Ada.Streams; use Ada.Streams;
with AdaBase; use AdaBase;

with Contacts_App.Test_Utilities.Common; use Contacts_App.Test_Utilities.Common;

package body Authorization.Users.Tests is
   
   Driver : Database_Driver;

   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (Test : in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test, Test_Get_By_ID'Access,          "Ensure Get_By_ID returns the correct user when given a correct ID");
      Register_Routine (Test, Test_Get_By_Credentials'Access, "Ensure Get_By_Credentials returns the correct user when given correct credentials");
   end;
   
   -----------------
   -- Set_Up_Case --
   -----------------
   procedure Set_Up_Case (Test : in out TC) is
      Ignore : AdaBase.Affected_Rows;
   begin
      Connect (Test.Driver);
      Ignore := Test.Driver.Execute (
         "CREATE TABLE users ("                 & ASCII.LF &
         "  id          SERIAL       NOT NULL," & ASCII.LF &
         "  name        VARCHAR(128) NOT NULL," & ASCII.LF &
         "  password    VARCHAR(64)  NOT NULL," & ASCII.LF &
         "  given_name  VARCHAR(128) NOT NULL," & ASCII.LF &
         "  family_name VARCHAR(128) NOT NULL," & ASCII.LF &
         "PRIMARY KEY(id),"                     & ASCII.LF &
         "UNIQUE (name));");
      Ignore := Test.Driver.Execute (
         "INSERT INTO users (id, name, given_name, family_name, password) VALUES"                                        & ASCII.LF &
         "  (1, 'user1', 'Preston',   'Poplar',    '3f49249ce0265561d5d0b66f99218bd15a0158f7c21cefae409d1d2b7f05c877')," & ASCII.LF &
         "  (2, 'user2', 'Dimple',    'Defranco',  '3f49249ce0265561d5d0b66f99218bd15a0158f7c21cefae409d1d2b7f05c877')," & ASCII.LF &
         "  (3, 'user3', 'Marcelino', 'Mansfield', '3f49249ce0265561d5d0b66f99218bd15a0158f7c21cefae409d1d2b7f05c877');");
   end;
   
   --------------------
   -- Tear_Down_Case --
   --------------------
   procedure Tear_Down_Case (Test : in out TC) is
   begin
      Disconnect (Test.Driver);
   end;

   --------------------
   -- Test_Get_By_ID --
   --------------------
   procedure Test_Get_By_ID (Test : in out Test_Cases.Test_Case'Class) is
      User : User_Model := Get_By_ID (ID => 2);
   begin
      Assert_Naturals_Equal (2, User.ID);
      Assert_Strings_Equal  ("user2", User.Name);
      Assert_Strings_Equal  ("Dimple", User.Given_Name);
      Assert_Strings_Equal  ("Defranco", User.Family_Name);
      Assert_Strings_Equal  ("3f49249ce0265561d5d0b66f99218bd15a0158f7c21cefae409d1d2b7f05c877", User.Password);
   end;

   -----------------------------
   -- Test_Get_By_Credentials --
   -----------------------------
   procedure Test_Get_By_Credentials (Test : in out Test_Cases.Test_Case'Class) is
    
   begin
      null;
   end;
end;
