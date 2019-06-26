
Shared
======

This folder contains all things that are shared by all the `*_api` projects. Shared dependencies, shared project configuration, shared source code, shared test code. This is the most essential part of the application to get building. If you can set up tests.gpr, then all other projects should work correctly.

Setup
-----

The only dependencies that are linked are the database connector libraries.
SQLite is required as it is used as the in memory database for the unit tests.
The database each service actually uses can be MySQL, PostgreSQL, or Sqlite. 
I reccomend you DO install either MySQL or PostgreSQL and use it. Having a remote database is
very useful.

The instructions for linking the database connectors depend on your system platform.
The instructions are listed here, and also in [shared/dependencies.gpr](shared/dependencies.gpr)

### Windows

 1. Download [SQLite binaries](https://sqlite.org/download.html) 
 2. Choose if you want to download either [MySQL](https://dev.mysql.com/downloads/installer/) or [PostgreSQL](https://www.postgresql.org/download/) installer.
 3. Place the SQLite binaries in a convenient spot and add it to your `%PATH%` environment variable.
 4. If you installed MySQL or PostgresSQL then add the /lib folder from their installation to your `%PATH%` environment variable.
     * MySQL Default lib folder: `C:\Program Files\MySQL\MySQL Connector C 6.1\lib`
     * PostgreSQL Default lib folder: `C:\Program Files\PostgreSQL\version\lib`
 5. Modify the paths in [shared/dependencies.gpr][shared/dependencies.gpr] to point to the folders described in 3 and 4.

### Unix

 1. Use your package manager to install [libsqlite3-dev](https://packages.ubuntu.com/disco/libsqlite3-dev)
 2. Choose if you want to download either [libmysqlclient-dev](https://packages.ubuntu.com/disco/libmysqlclient-dev) or [libpq-dev](https://packages.ubuntu.com/disco/libpq-dev)

Example Application Database
----------------------------

Relevant database setup scripts are included in the database folder. Follow the instructions in that folder to set up the example database.

Building
--------

Use [shared/tests.gpr](shared/tests.gpr) to test if your database is setup correctly. The important part about building now is setting the right Scenario variables:

`gprbuild -Pshared/tests.gpr -XSQLITE=yes -XMYSQL=yes -XPOSTGRESQL=no -XDatabase=mysql -XOS_VERSION=windows -XDEBUGSYM=no -XGPR_BUILD=static -XGNATCOLL_CORE_BUILD=static -XXMLADA_BUILD=static -XAWS_BUILD=static`

You only have to list a scenario variable if you want to change it's value from the default.

The scenario variables available are:

 | Variable            | Default | Possible Values         | Description                                 |
 | ------------------- | ------- | ----------------------- | ------------------------------------------- |
 | SQLITE              | yes     | yes, no                 | Adds SQLite sources to AdaBase (REQUIRED)   |
 | MYSQL               | no      | yes, no                 | Adds MySQL sources to AdaBase               |
 | POSTGRESQL          | no      | yes, no                 | Adds PostgreSQL sources to AdaBase          |
 | DATABASE            | sqlite  | mysql, postgres, sqlite | Which real database to connect to           |
 | OS_VERSION          | unix    | unix, windows           | Configures linking options                  |
 | DEBUGSYM            | no      | yes, no                 | Compiles with debug symbols or optimization |
 | GPR_BUILD           | static  | static, dynamic         | Something for AWS, don't modify             |
 | GNATCOLL_CORE_BUILD | static  | static, dynamic         | Something for AWS, don't modify             |
 | XMLADA_BUILD        | static  | static, dynamic         | Something for AWS, don't modify             |
 | AWS_BUILD           | static  | static, dynamic         | Something for AWS, don't modify             |

For the `*_api` folders I reccomend using the both.gpr files to build both the tests and the server together. They have
the same options as listed above.
