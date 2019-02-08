   
with AdaBase.Driver.Base.PostgreSQL;
with AdaBase.Statement.Base.PostgreSQL;
with AdaBase.Logger.Facility;

package Contacts_App.Database is
   
   LOG_FILE : constant String := "postgres.log";

   subtype Database_Driver       is AdaBase.Driver.Base.PostgreSQL.PostgreSQL_Driver;
   subtype Statement_Type        is AdaBase.Statement.Base.PostgreSQL.PostgreSQL_Statement;
   subtype Statement_Type_Access is AdaBase.Statement.Base.PostgreSQL.PostgreSQL_Statement_Access;

   Driver : Database_Driver;

   procedure Connect;
   procedure Disconnect;

end;
