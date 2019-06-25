
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

Database
--------

### Building with MySQL

#### Linux

Install the client libraries libmysqlclient will need to be present on the system you deploy to.

    sudo apt-get install libmysqlclient-dev

#### Windows

The client library `libmysql.dll` is included in the [MySQL Installer](https://dev.mysql.com/downloads/installer/). After downloading and installing, I found it in `C:\Program Files\MySQL\MySQL Connector C 6.1\lib`. Copy `libmysql.dll` to `shared` and to each `*_api` folder. That dll will need to exist on the executable path of the `*_api.exe` on any system you deploy to.

### Building the API with PostgreSQL

#### Linux
  
Install the client libraries. libpq will need to be present on the system you deploy to.

    sudo apt-get install libpq-dev

#### Windows

The client library `libpq.dll` is included in the [PostgreSQL Installer](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads). After downloading and installing, I found it in `C:\Program Files\PostgreSQL\version\lib`. Copy `libpq.dll` to `shared` and to each `*_api` folder. That dll will need to exist on the executable path of the `*_api.exe` on any system you deploy to.



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
