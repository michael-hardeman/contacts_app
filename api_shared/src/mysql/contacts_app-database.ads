with AdaBase.Driver.Base.MySQL;
with AdaBase.Statement.Base.MySQL;
with AdaBase.Logger.Facility;

package Contacts_App.Database is

   LOG_FILE : constant String := "mysql.log";
   
   subtype Database_Driver       is AdaBase.Driver.Base.MySQL.MySQL_Driver;
   subtype Statement_Type        is AdaBase.Statement.Base.MySQL.MySQL_Statement;
   subtype Statement_Type_Access is AdaBase.Statement.Base.MySQL.MySQL_Statement_Access;

   Driver : Database_Driver;

   procedure Connect;
   procedure Disconnect;
   
end;
