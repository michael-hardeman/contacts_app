
Example Ada Micro Service Project
=================================

This is an example of a modern web application, built with an Ada micro service backend. I hope this can serve as a template that will help others build high integrity backends, quickly.

Running It
----------

  1. Follow the instructions in [shared/README.md](shared/README.md) to get the server side stuff compiling.
  2. Follow the instructions in [webpage/README.md](webpage/README.md) to get the client side stuff built.
  3. Build all backend servers using with [application.gpr](application.gpr).
  4. Launch all servers and the webpage to see the full application.

Building
--------

Use [application.gpr](application.gpr) to build all executables in the application:

`gprbuild -Pall.gpr -XSQLITE=yes -XMYSQL=yes -XPOSTGRESQL=no -XDatabase=mysql -XOS_VERSION=windows -XDEBUGSYM=no -XGPR_BUILD=static -XGNATCOLL_CORE_BUILD=static -XXMLADA_BUILD=static -XAWS_BUILD=static`

The above shows all scenario variables, but you only have to set the variable if you want to change it's value from the default.

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

Libraries Summary
-----------------

 * Ada Web Server - For building programs that serve and consume HTTP/HTTPS content.
 * GNATCOLL - I only used the JSON parser and serializer; but there are many useful components.
 * AdaBase - Database connector bindings for MySQL, Postgres, SQLite, and Firebird.
 * AdaID - GUID generation library
 * AUnit - Ada unit testing framework.

Port Summary
------------
 
 The port the server will use is configured in the aws.ini file inside each `*_api` folder.

 | Service        | Port |
 | -------------- | ---- |
 | webpage        | 8081 |
 | auth_api       | 8082 |
 | users_api      | 8083 |
 | contacts_api   | 8084 |

Enabling HTTPS
--------------

For a micro service architecture, it would be better to configure your reverse proxy or load balancer to use HTTPS instead of the individual services. However, there might be some situation where you need https communication internally. If you haven't already, you have to rebuild and install AWS with SSL support enabled since it's not built with it by default.

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
