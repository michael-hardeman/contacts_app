
with AWS.Config;
with AWS.Response;
with AWS.Services.Dispatchers.Method;
with AWS.Status;

package Contacts_App.Dispatchers is

   use AWS;

   procedure Initialize (Web_Config : in Config.Object);

   procedure Register_Dispatchers
     (Web_Dispatcher : in out Services.Dispatchers.Method.Handler);

end;
