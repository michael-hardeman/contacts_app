
with AUnit.Assertions; use AUnit.Assertions;
pragma Elaborate_All (AUnit);
pragma Elaborate_All (AUnit.Assertions);

with Ada.Streams; use Ada.Streams;

with Contacts_App.Database;
with Authorization.Test_Utilities.Common; use Authorization.Test_Utilities.Common;


package body Authorization.Credentials.Tests is

   ---------------
   -- Constants --
   ---------------
   Driver : Contacts_App.Database.Database_Driver;

   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Parse_Empty'Access,     "Ensure parsing empty data raises a Parsing_Error");
      Register_Routine (T, Test_Parse_Invalid'Access,   "Ensure parsing invalid json raises a Parsing_Error");
      Register_Routine (T, Test_Parse_Incorrect'Access, "Ensure parsing valid but incorrect data raises a Parsing_Error");
      Register_Routine (T, Test_Parse_Valid'Access,     "Ensure parsing valid data returns valid credentials");
   end Register_Tests;

   -----------------------------
   -- To_Stream_Element_Array --
   -----------------------------
   function To_Stream_Element_Array (Item : in String) return Stream_Element_Array is
      Output : Stream_Element_Array (0 .. Stream_Element_Offset (Item'Last - 1)) := (others => 0);
      Stream_Offset : Stream_Element_Offset := 0;
   begin
      for I in Item'Range loop 
         Output (Stream_Offset) := Stream_Element (Character'Pos (Item (I))); 
         Stream_Offset := Stream_Offset + 1;
      end loop;
      return Output;
   end;

   ----------------------
   -- Test_Parse_Empty --
   ----------------------
   procedure Test_Parse_Empty (Test : in out Test_Cases.Test_Case'Class) is
      EMPTY_INPUT : constant Stream_Element_Array (1 .. 0) := (others => 0);
   begin
      declare
         Credentials : Credential_Model := Parse (EMPTY_INPUT);
      begin
         Assert_Booleans_Equal (True, False);
      end;
   exception
      when Parsing_Error => Assert_Booleans_Equal (True, True);
      when others => Assert_Booleans_Equal (True, False);
   end;

   ------------------------
   -- Test_Parse_Invalid --
   ------------------------
   procedure Test_Parse_Invalid (Test : in out Test_Cases.Test_Case'Class) is
      INVALID_INPUT : constant Stream_Element_Array := To_Stream_Element_Array ("this will fail");
   begin
      declare
         Credentials : Credential_Model := Parse (INVALID_INPUT);
      begin
         Assert_Booleans_Equal (True, False);
      end;
   exception
      when Parsing_Error => Assert_Booleans_Equal (True, True);
      when others => Assert_Booleans_Equal (True, False);
   end;

   --------------------------
   -- Test_Parse_Incorrect --
   --------------------------
   procedure Test_Parse_Incorrect (Test : in out Test_Cases.Test_Case'Class) is
      INCORRECT_INPUT : constant Stream_Element_Array := To_Stream_Element_Array ("{""foo"":""bar""}");
   begin
      declare
         Credentials : Credential_Model := Parse (INCORRECT_INPUT);
      begin
         Assert_Booleans_Equal (True, False);
      end;
   exception
      when Parsing_Error => Assert_Booleans_Equal (True, True);
      when others => Assert_Booleans_Equal (True, False);
   end;

   ----------------------
   -- Test_Parse_Valid --
   ----------------------
   procedure Test_Parse_Valid (Test : in out Test_Cases.Test_Case'Class) is
      EXPECTED_USERNAME : constant String := "foo";
      INPUT_PASSWORD    : constant String := "bar";
      EXPECTED_PASSWORD : constant String := "e8759e101f625d71001406b9828b918d875c00f182d9d5d77ef01c7550f4729c";
      VALID_INPUT       : constant Stream_Element_Array := To_Stream_Element_Array ("{""username"":""" & EXPECTED_USERNAME & """,""password"":""" & INPUT_PASSWORD & """}");
      Credentials       : Credential_Model := Parse (VALID_INPUT);
   begin
      Assert_Strings_Equal (Credentials.Username, EXPECTED_USERNAME);
      Assert_Strings_Equal (Credentials.Password, EXPECTED_PASSWORD);
   end;
end;
