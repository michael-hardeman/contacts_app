
with AUnit.Assertions; use AUnit.Assertions;
with Ada.Directories; use Ada.Directories;
with Ada.Streams; use Ada.Streams;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Contacts_App.Test_Utilities.Common; use Contacts_App.Test_Utilities.Common;

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
         Output : Stream_Element_Array (1 .. Stream_Element_Offset (Size (Path))) := (others => 0);
         File   : Stream_IO.File_Type;
      begin
         Open (File, Out_File, Path);
         Stream_Element_Array'Read (Stream (File), Output);
         Close (File);
         
         return Output;
      end;

   begin
      Connect_Empty;
      Assert_Booleans_Equal (Driver.Trait_Connected, True);
      Assert_Stream_Element_Arrays_Equal (Read_Stream_Element_Array (Temp_File), EMPTY_DATABASE);
   end;
   
   ------------------
   -- Test Connect --
   ------------------
   procedure Test_Connect (Test : in out Test_Cases.Test_Case'Class) is
   begin
      Connect;
      Assert_Booleans_Equal (Driver.Trait_Connected, True);
   end;
   
   ---------------------
   -- Test Disconnect --
   ---------------------
   procedure Test_Disconnect (Test : in out Test_Cases.Test_Case'Class) is
   begin
      Disconnect;
      Assert_Booleans_Equal (Driver.Trait_Connected, False);
   end;

end;
