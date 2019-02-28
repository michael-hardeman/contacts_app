with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package body Contacts_App.Database is
   
   procedure Connect is
      use AdaBase.Logger.Facility;

      Facility : LogFacility;
   begin 
      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => LOG_FILE);

      Driver.Basic_Connect (Database => DB_FILE);
   end;
   
   procedure Disconnect is
      use AdaBase.Logger.Facility;
   begin
      Driver.Command_Standard_Logger (Device => File, Action => Detach);
      Driver.Disconnect;
   end;

   procedure Connect_Empty is
   begin
      Create (Temp_File);
      Stream_Element_Array'Write (Stream (Temp_File), EMPTY_DATABASE);
      Close (Temp_File);

      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => LOG_FILE);

      Driver.Basic_Connect (Database => Name(Temp_File));
   end;
   
end;
