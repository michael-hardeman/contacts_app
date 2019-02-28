with Ada.Streams; use Ada.Streams;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with AdaBase.Driver.Base.SQLite;
with AdaBase.Statement.Base.SQLite;
with AdaBase.Logger.Facility;

package Contacts_App.Database is

   DB_FILE  : constant String := "../database/sqlite/contacts_app.db";
   LOG_FILE : constant String := "sqlite.log";

   EMPTY_DATABASE : constant Stream_Element_Array (1 .. 8192) := (
      16#53#, 16#51#, 16#4c#, 16#69#, 16#74#, 16#65#, 16#20#, 16#66#,
      16#6f#, 16#72#, 16#6d#, 16#61#, 16#74#, 16#20#, 16#33#, 16#00#,
      16#10#, 16#00#, 16#01#, 16#01#, 16#00#, 16#40#, 16#20#, 16#20#, 
      16#00#, 16#00#, 16#00#, 16#02#, 16#00#, 16#00#, 16#00#, 16#02#,
      16#00#, 16#00#, 16#00#, 16#02#, 16#00#, 16#00#, 16#00#, 16#01#,
      16#00#, 16#00#, 16#00#, 16#02#, 16#00#, 16#00#, 16#00#, 16#04#,
      16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 
      16#00#, 16#00#, 16#00#, 16#01#, 16#00#, 16#00#, 16#00#, 16#00#,
      16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 
      16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
      16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 
      16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#02#,
      16#00#, 16#2e#, 16#24#, 16#80#, 16#0d#, 16#00#, 16#00#, 16#00#,
      16#00#, 16#10#, 16#00#, 16#00#, 16#0f#, 16#b4#, 16#00#, 16#00#,
      others => 16#00#);

   subtype Database_Driver       is AdaBase.Driver.Base.SQLite.SQLite_Driver;
   subtype Statement_Type        is AdaBase.Statement.Base.SQLite.SQLite_Statement;
   subtype Statement_Type_Access is AdaBase.Statement.Base.SQLite.SQLite_Statement_Access;
   
   Temp_File : Stream_IO.File_Type;
   Driver    : Database_Driver;

   procedure Connect;
   procedure Connect_Empty;
   procedure Disconnect;

end;
