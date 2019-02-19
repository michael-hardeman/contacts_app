package body Contacts_App.Database is
   
   procedure Connect (Driver : in out Database_Driver; Database_File : in String; Log_File : in String) is
      use AdaBase.Logger.Facility;

      Facility : LogFacility;
   begin 
      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => Log_File);

      Driver.Basic_Connect (Database => Database_File);
   end;
   
   procedure Disconnect (Driver : in out Database_Driver) is
      use AdaBase.Logger.Facility;
   begin
      Driver.Command_Standard_Logger (Device => File, Action => Detach);
      Driver.Disconnect;
   end;
   
end;
