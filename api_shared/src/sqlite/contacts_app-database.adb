package body Contacts_App.Database is
   
   procedure Connect is
      use AdaBase.Logger.Facility;

      Facility : LogFacility;
   begin 
      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => LOG_FILE);

      Driver.Basic_Connect (Database => DATABASE_PATH);
   end;
   
   procedure Disconnect is
      use AdaBase.Logger.Facility;
   begin
      Driver.Command_Standard_Logger (Device => File, Action => Detach);
   end;
   
end;
