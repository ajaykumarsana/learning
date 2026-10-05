# Basic database commands

## list databases

`show databases;`

## create database

`create database <name>`

## delete database

`drop databse <name>`

## select database

`use <name>`

## rename database - deprecated/removed

## To know which db we're in run `select database();`

# create a table

`Create table <name> (`
`<col_name> <data_type>,`
`<col_name> <data_type>,`
`);`

# To know what tables exist

`show tables;`

# to know what columns exist in table

Below both will print the same output.
`desc <table_name>` same as `describe <table_name>`
`show columns from <table_name>`

# Delete a table

`drop table <table_name>`

# insert into table

`insert into <table_name>(<column_name in ,>) values (<values to be placed inrespective column in same order of columns>);`

## Multiple inserts

` insert into table (columns) values (value1...),(value2...)...`

### insert empty row.

Will place all null values in the table
` insert into person () values ();`

## ADD not null

just add `NOT NULL` after column data type in create table query.
`create table person ( name varchar(50), age INT not null, location varchar(50));`

`mysql> insert into person (name) values ('');`
`ERROR 1364 (HY000): Field 'age' doesn't have a default value`

## add defaut value to a column

Specify beside column data type `default <default_value>`

`create table person ( name varchar(50) default 'no_name', age INT not null, location varchar(50) default 'IN');`
Example;

```
mysql> create table person ( name varchar(50) default 'no_name', age INT not null, location varchar(50) default 'IN');
Query OK, 0 rows affected (0.387 sec)

mysql> insert into person (age) values (22);
Query OK, 1 row affected (0.251 sec)

mysql> select * from person;
+---------+-----+----------+
| name    | age | location |
+---------+-----+----------+
| no_name |  22 | IN       |
+---------+-----+----------+
1 row in set (0.007 sec)
```

NOTE : we can have both not null , default value at a same column i.e not null forces us to have some value
it throws error that a column can't be null.

# primary key

- it is unique identifier to differentiate from another row which may have same data.
- it can be set at column level by defining `primary key` at the end while creating or altering table.
  `id int not null primary key`

- `create table person ( `id int not null primary key`, name varchar(50) default 'no_name', age INT not null, location varchar(50) default 'IN');`
- primary key can't be null so it is not necessary to mention as 'not null'
- when we set primary key to any column that automatically sets not null to the column def.

## another option

CREATE TABLE person (
id INT,
name VARCHAR(100) NOT NULL,
age INT NOT NULL,
PRIMARY KEY (cat_id)
);

## composite primary key

- when two columns forming together with primary key is called composite
  CREATE TABLE likes (
  user_id INTEGER NOT NULL,
  photo_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(photo_id) REFERENCES photos(id),
  PRIMARY KEY(user_id, photo_id)
  -- this will create composite primary key and make sure like will be done once
  );

# Auto increment

- it can increase automatically to differentiate from other values of rows.
- usually auto increment values are primary keys
- `id int auto_increment primary key`

`create table person ( id int auto_increment primary key, name varchar(100) not null);`

# Alter - table

## change column defintion

### add not null

`alter table person change column 'age' 'age varchar(60) not null;`

mysql> insert into person(id,name,age) values(1,'asdf',10),(1,'asdf',10)
-> ;
ERROR 1062 (23000): Duplicate entry '1' for key 'person.PRIMARY'
mysql> insert into person(id,name,age) values(1,'asdf',10),(2,'asdf',10)
-> ;
Query OK, 2 rows affected (0.105 sec)
Records: 2 Duplicates: 0 Warnings: 0

### remove not null i.e set nullable

`alter table person change column id id int null;`

### add primary key to a column

`alter table person change column id id int primary key;`
mysql> desc person;
+----------+--------------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| id | int | YES | | NULL | |
| name | varchar(100) | YES | | NULL | |
| age | varchar(60) | NO | | NULL | |
| location | varchar(50) | YES | | IN | |
+----------+--------------+------+-----+---------+-------+
4 rows in set (0.028 sec)

mysql> alter table person change column id id int primary key;
Query OK, 0 rows affected (1.127 sec)
Records: 0 Duplicates: 0 Warnings: 0

mysql> desc person;
+----------+--------------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| id | int | NO | PRI | NULL | |
| name | varchar(100) | YES | | NULL | |
| age | varchar(60) | NO | | NULL | |
| location | varchar(50) | YES | | IN | |
+----------+--------------+------+-----+---------+-------+
4 rows in set (0.027 sec)

### drop primary key

`alter table person drop primary key;`

- this only removes primary key but not null still be kept
  mysql> alter table person drop primary key;
  Query OK, 2 rows affected (1.230 sec)
  Records: 2 Duplicates: 0 Warnings: 0

mysql> desc person;
+----------+--------------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| id | int | NO | | NULL | |
| name | varchar(100) | YES | | NULL | |
| age | varchar(60) | NO | | NULL | |
| location | varchar(50) | YES | | IN | |
+----------+--------------+------+-----+---------+-------+
4 rows in set (0.048 sec)

### Add auto_increment

` alter table person change id id int auto_increment primary key;`

# Alias

rename a column of your choice, this would help to get to use of the clause better

`mysql> select first_name as fn from employees;`
+----+
| fn |
+----+
| aa |
| aa |
| aa |
| aa |
| aa |
| aa |
| aa |
| aa |
| aa |
+----+

# Update

- update specific columns of a table by specifying where clause and set values
- make sure you add where clause otherwise value would be set for entire column.
- also for prevention of unwanted update run the select query at first to see the data portion which would update.

`Update <tablename> set <column_name> = value where <column with condition`

## with multiple set

`Update <tablename> set <column_name> = value, <collumn_name2> = value2 where <column with condition`

mysql> select \* from person;
+----+------+
| id | name |
+----+------+
| 1 | |
| 2 | |
| 3 | a |
| 4 | b |
+----+------+
4 rows in set (0.008 sec)

`mysql> update person set name='no_name' where name = '';`
Query OK, 2 rows affected (0.254 sec)
Rows matched: 2 Changed: 2 Warnings: 0

mysql> select \* from person;
+----+---------+
| id | name |
+----+---------+
| 1 | no_name |
| 2 | no_name |
| 3 | a |
| 4 | b |
+----+---------+
4 rows in set (0.006 sec)

# Delete - From

- delete of rows entirely according to provided where clause
- as similar to update make sure we run select to know which data that we try to delete.
- similar to update it requires `where clause to be set otherwise whole table gonna delete`
- command is `delete from <tableName> where <condition>`

mysql> select \* from person;
+----+---------+
| id | name |
+----+---------+
| 1 | no_name |
| 2 | no_name |
| 3 | a |
| 4 | b |
+----+---------+
4 rows in set (0.006 sec)

`mysql> delete from person where name = 'no_name';`
Query OK, 2 rows affected (0.252 sec)

mysql> select \* from person;
+----+------+
| id | name |
+----+------+
| 3 | a |
| 4 | b |
+----+------+
2 rows in set (0.005 sec)

# source

you can locate to execute sql queries which stored in a file.

- Go to file located folder
- login into mysql -u root -p
- `source <filename.sql>`

# CAST

- used to convert one data type to another
- syntax `CAST ('<val>' as <DATATYPE>)`
- string to time
  - select CAST('9:1:5' AS time);
    +-----------------------+
    | CAST('9:1:5' AS time) |
    +-----------------------+
    | 09:01:05 |

# RENAME

- used for renaming the table.
- `rename table price to price_list`
