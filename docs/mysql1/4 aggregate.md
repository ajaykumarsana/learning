# count

- it is used to count the number of rowws returns by the query.
- you can use \* to get row count
- column can also be passed to count function it would return count of non null rows.
- `mysql> select count(_) from books;`
  +----------+
  | count(\_) |
  +----------+
  | 20 |
  +----------+
  1 row in set (0.354 sec)
- `mysql> select count(author_lname) from books;`
  +---------------------+
  | count(author_lname) |
  +---------------------+
  | 19 |
  +---------------------+
  1 row in set (0.008 sec)
- can be combined with distinct too.
- `mysql> select count(distinct author_lname) from books;` // removes duplicated and null then reutn the count
  +------------------------------+
  | count(distinct author_lname) |
  +------------------------------+
  | 11 |
  +------------------------------+
  1 row in set (0.222 sec)

# Group by

- summarize or aggregate idntical data into single rows.
- when `gropu by` applied at column level it groups same data rows together and return, you can check that by having count(\*)
- it return grouped rows as single rows.
- syntax `select column_name from <table> group by <col_name>;`
- column_name has to be selected otherwise it throws error.
- we can do multiple column group by specifying mulitple column names
- syntax `select columnname from <table> group by <col_name>,<col_name2>;`
- `group by` can be done by aliases also.
- `mysql> select author_lname,count(*) from books group by author_lname;`
  +----------------+----------+
  | author_lname | count(\*) |
  +----------------+----------+
  | Lahiri | 2 |
  | Gaiman | 3 |
  | Eggers | 3 |
  | Chabon | 1 |
  | Smith | 1 |
  | Carver | 2 |
  | DeLillo | 1 |
  | Steinbeck | 1 |
  | Foster Wallace | 2 |
  | Harris | 2 |
  | Saunders | 1 |
  | NULL | 1 |
  +----------------+----------+
  12 rows in set (0.208 sec)
- `mysql> select author_lname,count(*) from books group by author_lname order by author_lname;`
  +----------------+----------+
  | author_lname | count(\*) |
  +----------------+----------+
  | NULL | 1 |
  | Carver | 2 |
  | Chabon | 1 |
  | DeLillo | 1 |
  | Eggers | 3 |
  | Foster Wallace | 2 |
  | Gaiman | 3 |
  | Harris | 2 |
  | Lahiri | 2 |
  | Saunders | 1 |
  | Smith | 1 |
  | Steinbeck | 1 |
  +----------------+----------+
  12 rows in set (0.010 sec)
- `mysql> select author_lname, count(*) from books group by author_lname, author_fname;`
  +----------------+----------+
  | author_lname | count(\*) |
  +----------------+----------+
  | Lahiri | 2 |
  | Gaiman | 3 |
  | Eggers | 3 |
  | Chabon | 1 |
  | Smith | 1 |
  | Carver | 2 |
  | DeLillo | 1 |
  | Steinbeck | 1 |
  | Foster Wallace | 2 |
  | Harris | 1 |
  | Harris | 1 |
  | Saunders | 1 |
  | NULL | 1 |
  +----------------+----------+
  13 rows in set (0.010 sec)
- `mysql> SELECT CONCAT(author_fname, ' ', author_lname) AS author,  COUNT(*)`
  `-> FROM books`
  `-> GROUP BY author;` // aliases with group by
  +----------------------+----------+
  | author | COUNT(\*) |
  +----------------------+----------+
  | Jhumpa Lahiri | 2 |
  | Neil Gaiman | 3 |
  | Dave Eggers | 3 |
  | Michael Chabon | 1 |
  | Patti Smith | 1 |
  | Raymond Carver | 2 |
  | Don DeLillo | 1 |
  | John Steinbeck | 1 |
  | David Foster Wallace | 2 |
  | Dan Harris | 1 |
  | Freida Harris | 1 |
  | George Saunders | 1 |
  | NULL | 1 |
  +----------------------+----------+
  13 rows in set (0.010 sec)

## GROUP BY HAVING

- having is being useful when you want to add a condition of group because where can't be used on group by
- `select .... from table where <condition> group by <column> having <condition>`

# Min and MAx

- it has to be applied at column while selecting columns.
- `it runs based on ASCII code`
- when text contains it return least and most ascii code data
- for number min, max applies as intended
- `select min(pages) from books;`
- `select max(released_year) from books;`
- `mysql> select min(released_year) as firstpublished, max(released_year), count(*), concat(author_fname,' ',author_lname) as author from books group by author;`
- this does mix and max grouping
  +----------------+--------------------+----------+----------------------+
  | firstpublished | max(released_year) | count(\*) | author |
  +----------------+--------------------+----------+----------------------+
  | 1996 | 2003 | 2 | Jhumpa Lahiri |
  | 2001 | 2016 | 3 | Neil Gaiman |
  | 2001 | 2013 | 3 | Dave Eggers |
  | 2000 | 2000 | 1 | Michael Chabon |
  | 2010 | 2010 | 1 | Patti Smith |
  | 1981 | 1989 | 2 | Raymond Carver |
  | 1985 | 1985 | 1 | Don DeLillo |
  | 1945 | 1945 | 1 | John Steinbeck |
  | 2004 | 2005 | 2 | David Foster Wallace |
  | 2014 | 2014 | 1 | Dan Harris |
  | 2001 | 2001 | 1 | Freida Harris |
  | 2017 | 2017 | 1 | George Saunders |
  | NULL | NULL | 1 | NULL |
  +----------------+--------------------+----------+----------------------+
  13 rows in set (0.009 sec)

# sub queries

- query has to used in the where clause of another query
- sub query returns a value, that will act as clause.
- `mysql> select * from books where pages = (select max(pages) from books);` // gives highest pages record number
  +---------+-------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+-------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | 7 | The Amazing Adventures of Kavalier & Clay | Michael | Chabon | 2000 | 68 | 634 |
  +---------+-------------------------------------------+--------------+--------------+---------------+----------------+-------+
  1 row in set (0.241 sec)
- `mysql> select * from books order by pages desc limit 1;` // order by also does the same.
  +---------+-------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+-------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | 7 | The Amazing Adventures of Kavalier & Clay | Michael | Chabon | 2000 | 68 | 634 |
  +---------+-------------------------------------------+--------------+--------------+---------------+----------------+-------+
  1 row in set (0.008 sec)
- `diff is order by returns only one query if multiple same max values found.`

# sum

- To get sum of all values of a given column.
- `mysql> select sum(pages) from books;`
  +------------+
  | sum(pages) |
  +------------+
  | 6623 |
  +------------+
  1 row in set (0.008 sec)

- `mysql> select sum(stock_quantity) from books;`
  +---------------------+
  | sum(stock_quantity) |
  +---------------------+
  | 2450 |
  +---------------------+
  1 row in set (0.006 sec)

- we can use sum and group by, so it does sum of all individual groups
- `mysql> select  concat(author_fname,' ',author_lname) as author, sum(stock_quantity) from books group by author;`
  +----------------------+---------------------+
  | author | sum(stock_quantity) |
  +----------------------+---------------------+
  | Jhumpa Lahiri | 129 |
  | Neil Gaiman | 155 |
  | Dave Eggers | 284 |
  | Michael Chabon | 68 |
  | Patti Smith | 55 |
  | Raymond Carver | 35 |
  | Don DeLillo | 49 |
  | John Steinbeck | 95 |
  | David Foster Wallace | 264 |
  | Dan Harris | 29 |
  | Freida Harris | 287 |
  | George Saunders | 1000 |
  | NULL | NULL |
  +----------------------+---------------------+
  13 rows in set (0.012 sec)

# avg

- it calculates the averge ot all values of selected column result.
- works very similar to sum but does average.
- `mysql> select  concat(author_fname,' ',author_lname) as author, count(*) ,avg(stock_quantity) from books group by author;`
  +----------------------+----------+---------------------+
  | author | count(\*) | avg(stock_quantity) |
  +----------------------+----------+---------------------+
  | Jhumpa Lahiri | 2 | 64.5000 |
  | Neil Gaiman | 3 | 51.6667 |
  | Dave Eggers | 3 | 94.6667 |
  | Michael Chabon | 1 | 68.0000 |
  | Patti Smith | 1 | 55.0000 |
  | Raymond Carver | 2 | 17.5000 |
  | Don DeLillo | 1 | 49.0000 |
  | John Steinbeck | 1 | 95.0000 |
  | David Foster Wallace | 2 | 132.0000 |
  | Dan Harris | 1 | 29.0000 |
  | Freida Harris | 1 | 287.0000 |
  | George Saunders | 1 | 1000.0000 |
  | NULL | 1 | NULL |
  +----------------------+---
