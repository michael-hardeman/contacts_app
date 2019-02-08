package body Contacts_App.Database is
   
   procedure Connect is
      use AdaBase.Logger.Facility;

      Facility : LogFacility;
   begin 
      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => LOG_FILE);

      Driver.Basic_Connect (Database => "contacts_app",
                            Username => "contacts_app",
                            Password => "KcWTgnDHk7og",
                            Hostname => "localhost",
                            Port     => 3306);
   end;
   
   procedure Disconnect is
      use AdaBase.Logger.Facility;
   begin
      Driver.Command_Standard_Logger (Device => File, action => Detach);
   end;
   
end;
