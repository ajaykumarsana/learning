# What is Database

- A collection of data which has methods to access and manipulate data.
- A structured set of computerized data with an accessible interface
- `password is admin`

Available Relational Database

1. Mysql
2. SQLite
3. PostgresQL
4. Oracel

# MySQL vs SQL

- Structured Query Language - Is the language we use to talk with data base.
- Mysql is not DB but it DBMS.
  - DBMS is something which interacts with database.

# installation

- Install VC ++
- Install Mysql community server
  - Remember the password and port details
- access `mysql -u root -p`// use the password in above step
  - Open Mysql command line client - it would ask password
- Install Work Bench
- Install DbGate
- add mysql path to system variables path sothat mysql command can be found

# Tables

- Database is collection of tables
- It has format of data and shape
- it holds the collectoin of same shape
- A collection of related data held in structued format within database.
- Table has headers called columns with it has own data types of each column

## data types

Mostly used data types are varchar(variable in length) and int(whole number)

- Numeric

  - TINYINT - 1 byte - 8 bits
  - SMALLINT -2 bytes
  - MEDIUMINT - 3 bytes
  - INT - 4 bytes
  - BIGINT - 8 bytes
  - DECIMAL - it takes two numbers as params. DECIMAL(Totaldigits,float_digits)
    - `floatdigits will round off to nearest float number` // it throws warnig though
      - `mysql> insert into price(rate) values(99.123);`
        Query OK, 1 row affected, 1 warning (0.239 sec)
    - `decimal digits has to totaldigits - float digits count`
      - when decimal digits are more than above it will throw Out of range error. - `mysql> insert into price(rate) values(100.12);`
        ERROR 1264 (22003): Out of range value for column 'rate' at row 1
    - `mysql> desc price;`
      +-------+--------------+------+-----+---------+-------+
      | Field | Type | Null | Key | Default | Extra |
      +-------+--------------+------+-----+---------+-------+
      | rate | decimal(4,2) | YES | | NULL | |
      +-------+--------------+------+-----+---------+-------+
      1 row in set (0.027 sec)
  - FLOAT - 4 bytes
  - DOUBLE - 8 bytes - high efficient
  - BIT
  - `it can store both negative and positive values with signed`
  - `integer can have only positive values with declaration of unsigned` // this will icnreae postive value range
  - `<column_name> TINYINT UNSIGNED;` - this can't have negative values
  - it will ignore fractional numbers if you try to insert and keeps only decimal numbers

- String

  - CHAR
    - it is used to have fixed number of values for all rows in a table.
    - if data is less than the given length mysql right pads white spaces for the shortage of charactes
    - it does remvoes white spaces while fetching it back.
    - due to its fixed nature, data takes less bytes
    - zipcode, state abbreaviatoin, y/n flag
    - `use this for fixed characters`
  - VARCHAR
    - it can be defined as varchar(100) - it takes upto 100 characters only.
    - due to vary char length data takes more bytes
    - `use this for vairable length characters of data`
  - BINARY
  - VARBINARY
  - BLOB
  - TINYBLOB
  - MEDIUMBLOB
  - LONGBLOB
  - TEXT
  - TINYTEXT
  - MEDIUMTEXT
  - LONGTEXT
  - ENUM

- Date
  - DATE
  - DATETIME
  - TIME
  - TIMESTAMP
  - YEAR

# warnings

- `show warnings` // will display warnings in table

```sql
--8<-- "docs/mysql/11 ig_clone_data.sql"
```

```sql
--8<-- "docs/mysql/11_practise.sql"
```
