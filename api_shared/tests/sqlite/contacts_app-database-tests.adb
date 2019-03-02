
with AUnit.Assertions; use AUnit.Assertions;
pragma Elaborate_All (AUnit);
pragma Elaborate_All (AUnit.Assertions);

package body Contacts_App.Database.Tests is

   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Connect_Empty'Access, "Ensure Connect_Empty creates a temp file with and empty SQLITE database and connects");
      Register_Routine (T, Test_Connect'Access,       "Ensure Connect connects to the default SQLITE database file");
      Register_Routine (T, Test_Disconnect'Access,    "Ensure Disconnect disconnects from the connected database");
   end Register_Tests;

   ------------------------
   -- Test Connect Empty --
   ------------------------
   procedure Test_Connect_Empty (Test : in out Test_Cases.Test_Case'Class) is
      
      function Read_Stream_Element_Array (Path : in String) return Stream_Element_Array is
         Output : Stream_Element_Array (1 .. Ada.Directories.Size (Path)) := (others => 0);
         File   : Stream_IO.File_Type;
      begin
         Open (File, Path);
         Output'Read (Stream (File));
         Close (File);
      end;

   begin
      Connect_Empty;
      Assert_Booleans_Equal (Driver.Trait_Connected, True);
      Assert_Stream_Element_Arrays_Equal (Read_Stream_Element_Array (Temp_File), EMPTY_DATABASE);
   end;

end;
