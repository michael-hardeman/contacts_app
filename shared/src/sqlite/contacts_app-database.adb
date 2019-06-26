package body Contacts_App.Database is

   -------------
   -- Connect --
   -------------
   procedure Connect is
      use AdaBase.Logger.Facility;

      Facility : LogFacility;
   begin
      Driver.Command_Standard_Logger (Device => File, Action => Attach);
      Driver.Set_Logger_Filename (Filename => DEFAULT_LOG);

      Driver.Basic_Connect (Database => DEFAULT_FILE);
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
