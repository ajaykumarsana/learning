# Distinct

- it is to be used at column which does filter of repetitive content.
- return the column type values only once.
- syntax `select distinct <col_name> from table;`
- it can be used at any any combination of custom column selector
- mysql> select author_lname, author_fname from books;
  +----------------+--------------+
  | author_lname | author_fname |
  +----------------+--------------+
  | Lahiri | Jhumpa |
  | Gaiman | Neil |
  | Gaiman | Neil |
  | Lahiri | Jhumpa |
  | Eggers | Dave |
  | Eggers | Dave |
  | Chabon | Michael |
  | Smith | Patti |
  | Eggers | Dave |
  | Gaiman | Neil |
  | Carver | Raymond |
  | Carver | Raymond |
  | DeLillo | Don |
  | Steinbeck | John |
  | Foster Wallace | David |
  | Foster Wallace | David |
  | Harris | Dan |
  | Harris | Freida |
  | Saunders | George |
  +----------------+--------------+
- mysql> select distinct concat(author_fname, ' ',author_lname) from books;
  +----------------------------------------+
  | concat(author_fname, ' ',author_lname) |
  +----------------------------------------+
  | Jhumpa Lahiri |
  | Neil Gaiman |
  | Dave Eggers |
  | Michael Chabon |
  | Patti Smith |
  | Raymond Carver |
  | Don DeLillo |
  | John Steinbeck |
  | David Foster Wallace |
  | Dan Harris |
  | Freida Harris |
  | George Saunders |
  +---------------------------
- it can be used at multiple columns too
- mysql> select distinct author_fname,author_lname from books;
  +--------------+----------------+
  | author_fname | author_lname |
  +--------------+----------------+
  | Jhumpa | Lahiri |
  | Neil | Gaiman |
  | Dave | Eggers |
  | Michael | Chabon |
  | Patti | Smith |
  | Raymond | Carver |
  | Don | DeLillo |
  | John | Steinbeck |
  | David | Foster Wallace |
  | Dan | Harris |
  | Freida | Harris |
  | George | Saunders |
  +--------------+----------------+
  12 rows in set (0.008 sec)

# Order by

- it is used to sort our results
- sorting to be done based on columns
- order by to be specified after specifying the table
- syntax `select * from table order by <column_name>`
  - sort ascending order by default
  - `select * from table order by <column_name> asc` does the same
- descending order
  - `select * from table order by <column_name> desc`
- we can do sorting by multiple columns
  - `select * from table order by <col1, col2>`
- you can define the column order for sorting too.
  - after order by define the column index position.
  - syntax `select * from table order by <col_index>`

# LIMIT

- Allows to control the number of results.
- syntax `limit <no of records>`
- it has to be placed at the end of query.
- `mysql> select \* from books order by released_year limit 5;`
  +---------+-----------------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+-----------------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | 14 | Cannery Row | John | Steinbeck | 1945 | 95 | 181 |
  | 11 | What We Talk About When We Talk About Love: Stories | Raymond | Carver | 1981 | 23 | 176 |
  | 13 | White Noise | Don | DeLillo | 1985 | 49 | 320 |
  | 12 | Where I'm Calling From: Selected Stories | Raymond | Carver | 1989 | 12 | 526 |
  | 4 | Interpreter of Maladies | Jhumpa | Lahiri | 1996 | 97 | 198 |
  +---------+-----------------------------------------------------+--------------+--------------+---------------+----------------+-------+
  5 rows in set (0.216 sec)
- you can specify from and to by giving two numbers
- syntax `limit <from>, <to>`
- `mysql> select \* from books order by released_year limit 3, 2;`
  +---------+------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+------------------------------------------+--------------+--------------+---------------+----------------+-------+
  | 12 | Where I'm Calling From: Selected Stories | Raymond | Carver | 1989 | 12 | 526 |
  | 4 | Interpreter of Maladies | Jhumpa | Lahiri | 1996 | 97 | 198 |
  +---------+------------------------------------------+--------------+--------------+---------------+----------------+-------+
  2 rows in set (0.006 sec)

# LIKE

- it is used for searching
- this is used at column level with where clause
- syntax `where <colname> like '%daf%'`
- syntax `where <colname> like '__daf%'`
- `%` refers to wild chard 0 or more characters
- `_` refers to only one character, numbers of '\_' can be put as per requirement
- use escape sequence if you want to match reserved wild charactes.
  - `where <colname> like '%\%%'` // any where % found in the given column entires
  - `where <colname> like '%\_%'` // any where '\_' found in the given column entires
- `mysql> select * from books where author_fname like 'f%';`
  +---------+-----------+--------------+--------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+-----------+--------------+--------------+---------------+----------------+-------+
  | 18 | fake_book | Freida | Harris | 2001 | 287 | 428 |
  +---------+-----------+--------------+--------------+---------------+----------------+-------+
  1 row in set (0.010 sec)
- `mysql> select * from books where author_fname like '_a%';`
  +---------+-----------------------------------------------------+--------------+----------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+-----------------------------------------------------+--------------+----------------+---------------+----------------+-------+
  | 5 | A Hologram for the King: A Novel | Dave | Eggers | 2012 | 154 | 352 |
  | 6 | The Circle | Dave | Eggers | 2013 | 26 | 504 |
  | 8 | Just Kids | Patti | Smith | 2010 | 55 | 304 |
  | 9 | A Heartbreaking Work of Staggering Genius | Dave | Eggers | 2001 | 104 | 437 |
  | 11 | What We Talk About When We Talk About Love: Stories | Raymond | Carver | 1981 | 23 | 176 |
  | 12 | Where I'm Calling From: Selected Stories | Raymond | Carver | 1989 | 12 | 526 |
  | 15 | Oblivion: Stories | David | Foster Wallace | 2004 | 172 | 329 |
  | 16 | Consider the Lobster | David | Foster Wallace | 2005 | 92 | 343 |
  | 17 | 10% Happier | Dan | Harris | 2014 | 29 | 256 |
  +---------+-----------------------------------------------------+--------------+----------------+---------------+----------------+-------+
  9 rows in set (0.010 sec)
- `mysql> select * from books where title like '%\%%';`
  +---------+-------------+--------------+--------------+---------------+----------------+-------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages |
  +---------+-------------+--------------+--------------+---------------+----------------+-------+
  | 17 | 10% Happier | Dan | Harris | 2014 | 29 | 256 |
  +---------+-------------+--------------+--------------+---------------+----------------+-------+
  1 row in set (0.008 sec)
