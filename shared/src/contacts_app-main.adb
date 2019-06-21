
with AWS.Config.Set;
with AWS.Services.Dispatchers.Method;
with AWS.Server;
with AWS.Net.SSL;
with AWS.Net.SSl.Certificate;

with Contacts_App.Utilities;
with Contacts_App.Dispatchers;
with Contacts_App.Database;

procedure Contacts_App.Main is
   use AWS;

   Web_Server     : Server.HTTP;
   Web_Config     : Config.Object;
   Web_Dispatcher : Services.Dispatchers.Method.Handler;
   SSL_Config     : Net.SSL.Config;


begin
   ------------
   -- Config --
   ------------
   -- reads the aws.ini in the project specific *_api folder
   Config.Load_Config;
   Web_Config := Config.Get_Current;

   --------------
   -- Database --
   --------------
   Database.Connect;

   -----------------
   -- Dispatchers --
   -----------------
   Dispatchers.Initialize (Web_Config);
   Dispatchers.Register_Dispatchers (Web_Dispatcher);

   ---------
   -- SSL --
   ---------
   -- To enable SSL you will need to recompile AWS with SSL support. See the README
   -- You will also need to set some values in the aws.ini file. See the example
   -- config below.
   --
   -- It is recommended that SSL should be configured on the reverse proxy
   -- instead configuring SSL on every service
   --
   if Config.Security (Web_Config) then

      -- example SSL aws.ini
      --
      -- security true
      -- certificate contacts_app.crt
      -- key contacts_app.key
      -- reuse_address true
      -- trusted_ca constacts_app-ca.crt
      -- crl_file contacts_app-crl1.pem
      -- certificate_required true
      -- exchange_certificate true
      -- server_host mywebsite.com
      -- server_port 8443

      Net.SSL.Initialize (Config               => SSL_Config,
                          Certificate_Filename => Config.Certificate          (Web_Config),
                          Key_Filename         => Config.Key                  (Web_Config),
                          Exchange_Certificate => Config.Exchange_Certificate (Web_Config),
                          Certificate_Required => Config.Certificate_Required (Web_Config),
                          Trusted_CA_Filename  => Config.Trusted_CA           (Web_Config),
                          CRL_Filename         => Config.CRL_File             (Web_Config));

      Net.SSL.Certificate.Set_Verify_Callback (SSL_Config, Utilities.Verify_Certificate'Access);

      Server.Set_SSL_Config (Web_Server, SSL_Config);
   end if;

   Server.Start (Web_Server, Web_Dispatcher, Web_Config);

   Server.Wait (Server.Q_Key_Pressed);

   Database.Disconnect;

   Server.Shutdown (Web_Server);
end;
