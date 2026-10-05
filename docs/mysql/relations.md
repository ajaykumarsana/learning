- one to one // address,work,place
- one to many // customer placing order
- many to many // students attending classes

# primary key at column

- defines that particular column is primary information, mostly this column value will be unique and (or) auto_increamental and not null.

# foreign key

- this initializes the relation between two tables.
- Usually foreign key refers to primary key of another table and should have same data type.
- this foreign key sets the rule to make sure to have value of which already exist in another primary key column.
- having any other value other than primary key column data of another table in foreign key column would fail the insertion.
- syntax `FOREIGN KEY(<col_name>) REFERENCES tablename(<col>)`

`Example:`

CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50)
);

CREATE TABLE orders (
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE,
amount DECIMAL(8,2),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(id)
);

## Error - foreign key

`mysql> insert into orders(order_date,amount,customer_id) values ('2022-02-22',123,99);`
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`relation`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`))
<JOIN should have ON condition but not where>

# Cross join

- it is very rarely used
- this does many to many combinations - no of rows of table 1 \* table2 is the count of rows.
- syntax `select * from customers, orders;`

# innerJoin

- it is kind of intersection of two tables with join on the columns which are foreignkey of another table column, returns data if connected condition is met
- `JOIN <table> ON <connected_condition>`
- `mysql> select * from customers JOIN orders ON customers.id = orders.customer_id;`
- first table is primary table , second table which is declared foreignkey on the column of previous table.
- while joining tables it is required to select only necessary column rather all columns.
- this is useful who does activity on the relation of these both tables belong to.

## innerjoin - group by

- `mysql> select first_name,last_name,sum(amount) from customers JOIN orders ON customers.id = orders.customer_id group by first_name,last_name;`
  +------------+-----------+-------------+
  | first_name | last_name | sum(amount) |
  +------------+-----------+-------------+
  | Boy | George | 135.49 |
  | George | Michael | 813.17 |
  | Bette | Davis | 450.25 |
  +------------+-----------+-------------+
  3 rows in set (0.011 sec)

- it is mostly used.

# Left JOIn.

- it returns whole data of left side table which is primary table by keeping null as the values for the column which are not mapped.
- when no corresponding info in right side table gives you null values in right table column values.
- this join is useful who didn't place any order.
- `mysql> select * from customers LEFT JOIN orders ON customers.id = orders.customer_id;`
  +----+------------+-----------+------------------+------+------------+--------+-------------+
  | id | first_name | last_name | email | id | order_date | amount | customer_id |
  +----+------------+-----------+------------------+------+------------+--------+-------------+
  | 1 | Boy | George | george@gmail.com | 2 | 2017-11-11 | 35.50 | 1 |
  | 1 | Boy | George | george@gmail.com | 1 | 2016-02-10 | 99.99 | 1 |
  | 2 | George | Michael | gm@gmail.com | 4 | 2015-01-03 | 12.50 | 2 |
  | 2 | George | Michael | gm@gmail.com | 3 | 2014-12-12 | 800.67 | 2 |
  | 3 | David | Bowie | david@gmail.com | NULL | NULL | NULL | NULL |
  | 4 | Blue | Steele | blue@gmail.com | NULL | NULL | NULL | NULL |
  | 5 | Bette | Davis | bette@aol.com | 5 | 1999-04-11 | 450.25 | 5 |
  +----+------------+-----------+------------------+------+------------+--------+-------------+
  7 rows in set (0.010 sec)`

## left join with group by

- it is very similar to inner join group by with differentiation of showing customers who didn't place any order.
- `mysql> select first_name, last_name, sum(amount)  from customers LEFT JOIN orders ON customers.id = orders.customer_id group by first_name,last_name;`
  +------------+-----------+-------------+
  | first_name | last_name | sum(amount) |
  +------------+-----------+-------------+
  | Boy | George | 135.49 |
  | George | Michael | 813.17 |
  | David | Bowie | NULL |
  | Blue | Steele | NULL |
  | Bette | Davis | 450.25 |
  +------------+-----------+-------------+

## IFNULL

- it takes two arguments, first one is actual calculator if it is null second param will print the defined value.
- it is used to avoid null respone when we are counting.
- `IFNULL(sum(column),0)`
- `mysql> select first_name, last_name, IFNULL(SUM(amount),0)  from customers LEFT JOIN orders ON customers.id = orders.customer_id group by first_name, last_name;`
  +------------+-----------+-----------------------+
  | first_name | last_name | IFNULL(SUM(amount),0) |
  +------------+-----------+-----------------------+
  | Boy | George | 135.49 |
  | George | Michael | 813.17 |
  | David | Bowie | 0.00 |
  | Blue | Steele | 0.00 |
  | Bette | Davis | 450.25 |
  +------------+-----------+-----------------------+
  5 rows in set (0.214 sec)

# RIGHT join

- it is to identiy a order which doesn't have customer info.
- right side table is fully covered, leaving null for the values of left side if connected condidiont did meet but no value exist.
- `mysql> SELECT  * FROM customers RIGHT JOIN orders ON customers.id = orders.customer_id;`
  +------+------------+-----------+------------------+----+------------+---------+-------------+
  | id | first_name | last_name | email | id | order_date | amount | customer_id |
  +------+------------+-----------+------------------+----+------------+---------+-------------+
  | 1 | Boy | George | george@gmail.com | 1 | 2016-02-10 | 99.99 | 1 |
  | 1 | Boy | George | george@gmail.com | 2 | 2017-11-11 | 35.50 | 1 |
  | 2 | George | Michael | gm@gmail.com | 3 | 2014-12-12 | 800.67 | 2 |
  | 2 | George | Michael | gm@gmail.com | 4 | 2015-01-03 | 12.50 | 2 |
  | 5 | Bette | Davis | bette@aol.com | 5 | 1999-04-11 | 450.25 | 5 |
  | NULL | NULL | NULL | NULL | 6 | 1990-02-10 | 1234.00 | NULL |
  +------+------------+-----------+------------------+----+------------+---------+-------------+
  6 rows in set (0.008 sec)

# DELETE FOREIGN KEY linked data.

- when a tables are connected through Foreign key and primary key , it won't be possible to delete the primary table data of whose primary key column matches with any data in foreign key column of secondary table.
- `mysql> delete from customers where first_name = 'Boy';` // <delete a customer who has order>
  ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`relation`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`))
- `mysql> delete from customers where first_name = 'Blue';` // <delete a customer who doesn't have any order>
  Query OK, 1 row affected (0.242 sec)`

## DELETE CASCADE

- since we can't delete the data from primary table which is linked through foreign key from another table, delete cascade made it possible
- it has to be provided to the column of which foreign key is set.
- syntax `ON DELETE CASCADE` at foreign key specified column
- now upon adding this, deleting data from primary table would delete the foreign key linkage data from another table

# many to many

- we can perform multiple joins on single table
- syntax `<table> join <table1> on <table.id> = <table1.id> join <tabl2> on <tabl2>.id = <tab1>.id`

# round

- it is used for rounding of decimals with input of value, decimal digit to round of
- syntax `round(column,<no>`

```sql
--8<-- "docs/mysql/many to many.sql"
```
