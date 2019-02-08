
with Ada.Directories;

with AWS.Messages;
with AWS.MIME;
with AWS.Templates;
with AWS.Status;

package body Contacts_App.Dispatchers is

   use Ada;

   ----------
   -- Post --
   ----------

   type Post is new Services.Dispatchers.Method.Handler with null record;

   overriding function Dispatch
     (Dispatcher : in Post;
      Request    : in Status.Data)
      return Response.Data;

   -------------------
   -- POST Dispatch --
   -------------------
   overriding function Dispatch
     (Dispatcher : in Post;
      Request    : in Status.Data)
      return Response.Data
   is
      pragma Unreferenced (Dispatcher);
   begin
      return Response.Acknowledge
        (Messages.S403, "Invalid Username/Password Combination");
   end Dispatch;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Web_Config : in Config.Object) is
      pragma Unreferenced (Web_Config);
   begin
      null;
   end Initialize;

   --------------------------
   -- Register_Dispatchers --
   --------------------------

   procedure Register_Dispatchers
      (Web_Dispatcher : in out Services.Dispatchers.Method.Handler)
   is
      Post_Dispatcher : Post;
   begin
      Services.Dispatchers.Method.Register (Dispatcher => Web_Dispatcher,
                                            Method     => Status.POST,
                                            Action     => Post_Dispatcher);
   end;
end;
