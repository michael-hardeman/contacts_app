
Contacts Example App
====================

This is an example of a modern web application, built with an Ada micro service backend. I hope this can serve as a template that will help others build high integrity backends, quickly.

Libraries Summary
-----------------

 * Ada Web Server - For building programs that serve HTTP/HTTPS content
 * GNATCOLL - I only used the JSON parser/serializer; but there are quite a few useful components here.
 * AdaBase - Database Connector Bindings for MySQL, Postgres, SQLite, 
 * AdaID - GUID generation

Port Summary
------------

 | Service        | Port |
 | -------------- | ---- |
 | webpage        | 8081 |
 | auth_api       | 8082 |
 | users_api      | 8083 |
 | contacts_api   | 8084 |

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

### Linux

 1. Use your package manager to install [libsqlite3-dev](https://packages.ubuntu.com/disco/libsqlite3-dev)
 2. Choose if you want to download either [libmysqlclient-dev](https://packages.ubuntu.com/disco/libmysqlclient-dev) or [libpq-dev](https://packages.ubuntu.com/disco/libpq-dev)

Example Application Database
----------------------------

Relevant database setup scripts are included in the database folder. Follow the instructions in that folder to set up the example database.

Building
--------

Use [shared/tests.gpr](shared/tests.gpr) to test if your database is setup correctly. The important part about building now is setting the right Scenario variables:

`gprbuild -Pshared/tests.gpr -XSQLITE=yes -XMYSQL=yes -XPOSTGRESQL=no -XDatabase=mysql -XOS_VERSION=windows -XDEBUG=yes -XDEBUGSYM=no -XGPR_BUILD=static -XGNATCOLL_CORE_BUILD=static -XXMLADA_BUILD=static -XAWS_BUILD=static`

You only have to list a scenario variable if you want to change it's value from the default.

The scenario variables available are:

 | Variable            | Default | Possible Values         | Description                               |
 | ------------------- | ------- | ----------------------- | ----------------------------------------- |
 | SQLITE              | yes     | yes, no                 | Adds SQLite sources to AdaBase (REQUIRED) |
 | MYSQL               | no      | yes, no                 | Adds MySQL sources to AdaBase             |
 | POSTGRESQL          | no      | yes, no                 | Adds PostgreSQL sources to AdaBase        |
 | DATABASE            | sqlite  | mysql, postgres, sqlite | Which real database to connect to         |
 | OS_VERSION          | unix    | unix, windows           | Configures linking options                |
 | DEBUG               | yes     | yes, no                 | Compiles our sources with debug symbols   |
 | DEBUGSYM            | no      | yes, no                 | Compiles AdaBase with debug symbols       |
 | GPR_BUILD           | static  | static, dynamic         | Something for AWS, don't modify           |
 | GNATCOLL_CORE_BUILD | static  | static, dynamic         | Something for AWS, don't modify           |
 | XMLADA_BUILD        | static  | static, dynamic         | Something for AWS, don't modify           |
 | AWS_BUILD           | static  | static, dynamic         | Something for AWS, don't modify           |

For the `*_api` folders I reccomend using the both.gpr files to build both the tests and the server together. They have
the same options as listed above.

Enabling HTTPS
--------------

For a microservice architecture, it would be better to configure your reverse proxy or load balancer to use HTTPS instead of the individual services. However, there might be some situation where this is needed. If you haven't already, you have to rebuild and install AWS with SSL support enabled.

Refer to the [Building AWS](https://docs.adacore.com/aws-docs/aws/building_aws.html) documentation. Here is an example of what I did to enable it.

First install either openssl or gnutls. I will use gnutls as an example:

    sudo apt-get install gnutls-bin libgnutls28-dev

Then clone the source repo:

    git clone --recursive clone https://github.com/AdaCore/aws.git ~/aws
    cd ~/aws

Generate the setup file

    make setup

Next edit the generated makefile.setup. Some of them are specific to your system, but the ones that I needed to change are:

    NETLIB=ipv4
    SOCKET=gnutls
    DEBUG=false

Finally build and install aws with SSL
    
    make build install

Now you should be able to set the aws.ini config values that enable SSL.
