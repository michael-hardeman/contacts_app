with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package body Contacts_App.Database is
   
   ---------------------
   -- Connect Private --
   ---------------------
   procedure Connect_Private (Driver   : in out Database_Driver; 
                              DB_File  : in     String;
                              Log_File : in     String) 
   is
      use AdaBase.Logger.Facility;

      Facility : LogFacility;
   begin 
      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => Log_File);

      Driver.Basic_Connect (Database => DB_File);
   end;

   -------------------
   -- Connect Empty --
   -------------------
   procedure Connect_Empty is begin
      Create (Temp_File);
      Stream_Element_Array'Write (Stream (Temp_File), EMPTY_DATABASE);
      Close (Temp_File);

      Connect_Private (Driver, Name (Temp_File), DEFAULT_LOG);
   end;
   
   -------------
   -- Connect --
   -------------
   procedure Connect is begin
      Connect_Private (Driver, DEFAULT_FILE, DEFAULT_LOG);
   end;
   
   ----------------
   -- Disconnect --
   ----------------
   procedure Disconnect is
      use AdaBase.Logger.Facility;
   begin
      Driver.Command_Standard_Logger (Device => File, Action => Detach);
      Driver.Disconnect;
   end;

end;
