with Ada.Exceptions;
with Ada.Text_IO;

with AWS.Messages;
with AWS.MIME;
with AWS.Status;

with Contacts_App.Authorization.Credentials;
with Contacts_App.Authorization.Session;
with Contacts_App.Authorization.User;
with GNATCOLL.JSON;

package body Contacts_App.Dispatchers is

   use Ada;

   ----------
   -- Post --
   ----------
   type Post is new Services.Dispatchers.Method.Handler with null record;

   overriding function Dispatch (Dispatcher : in Post;
                                 Request    : in Status.Data)
                                 return Response.Data
   is
      pragma Unreferenced (Dispatcher);
      use Authorization.Credentials;
      use Authorization.Session;

      Credentials : Credentials_State := Parse (Status.Binary_Data (Request));
      Session     : Session_State     := Create_Or_Revive (Credentials);
   begin
      return Response.Build (Content_Type => MIME.Application_JSON,
                             Message_Body => Serialize (Session),
                             Status_Code  => Messages.s200);

   exception
      when Authorization.Credentials.Parsing_Error =>
         return Response.Acknowledge (Messages.s400, "Invalid Body");
      when Authorization.User.User_Not_Found =>
         return Response.Acknowledge (Messages.S401, "Invalid Credentials");
      when Error : others =>
         Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Name (Error));
         Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (Error));
         return Response.Acknowledge (Messages.S500, "Server Error");
   end;

   ----------------
   -- Initialize --
   ----------------
   procedure Initialize (Web_Config : in Config.Object) is
      pragma Unreferenced (Web_Config);
   begin
      null;
   end;

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
