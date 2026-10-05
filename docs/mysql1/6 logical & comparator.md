# comparison

- != not equal to
- not like
  - exact opposite to `like '%<val>%'`
  - exact opposite to `like '__<val>__'`
  - syntax `where <col> not like <condition>`
- > ,>=
- <, <=
- logical and `&&`, for adding two conditions
- logical OR `||`
- IN
  - very similar to OR but with more than 2 options it suits best
  - `select * from people where birth_year in (2010,2014,205);`
- NOT IN
  - exact opposite of `IN`
  - `select * from people where birth_year NOT in (2010,2014,205);`
- `Between`
  - it should be used for range of values
  - syntax `between <val1> AND <val2>`
  - would act same as two conditions `>= and <=` range of values
- compare dates
  - use logical operators with year(), hour(),minute() methods for precise comparision
  - OR use CAST(val AS DATETIME) then use logical comparator
  - `SELECT * FROM people WHERE birthtime`
    `BETWEEN CAST('12:00:00' AS TIME)`
    `AND CAST('16:00:00' AS TIME);`
- MODULO - %
  - a mathamatical operator to differentiate number based on expected result
  - `value % denominator`

## CASE

- we can use multiple case based return values as a columns for the values.
- it has `CASE WHEN THEN ELSE END` params
- `select CASE when year >=2000 THEN '20th century' else '19th century' end as 'column' from <table>`
- `mysql> select *, CASE  WHEN released_year >=2000 then 'afte 20th century' else '19th century' end AS genre from books;`
  +---------+-----------------------------------------------------+--------------+----------------+---------------+----------------+-------+-------------------+
  | book_id | title | author_fname | author_lname | released_year | stock_quantity | pages | genre |
  +---------+-----------------------------------------------------+--------------+----------------+---------------+----------------+-------+-------------------+
  | 1 | The Namesake | Jhumpa | Lahiri | 2003 | 32 | 291 | afte 20th century |
  | 2 | Norse Mythology | Neil | Gaiman | 2016 | 43 | 304 | afte 20th century |
  | 3 | American Gods | Neil | Gaiman | 2001 | 12 | 465 | afte 20th century |
  | 4 | Interpreter of Maladies | Jhumpa | Lahiri | 1996 | 97 | 198 | 19th century |
  | 5 | A Hologram for the King: A Novel | Dave | Eggers | 2012 | 154 | 352 | afte 20th century |
  | 6 | The Circle | Dave | Eggers | 2013 | 26 | 504 | afte 20th century |
  | 7 | The Amazing Adventures of Kavalier & Clay | Michael | Chabon | 2000 | 68 | 634 | afte 20th century |
  | 8 | Just Kids | Patti | Smith | 2010 | 55 | 304 | afte 20th century |
  | 9 | A Heartbreaking Work of Staggering Genius | Dave | Eggers | 2001 | 104 | 437 | afte 20th century |
  | 10 | Coraline | Neil | Gaiman | 2003 | 100 | 208 | afte 20th century |
  | 11 | What We Talk About When We Talk About Love: Stories | Raymond | Carver | 1981 | 23 | 176 | 19th century |
  | 12 | Where I'm Calling From: Selected Stories | Raymond | Carver | 1989 | 12 | 526 | 19th century |
  | 13 | White Noise | Don | DeLillo | 1985 | 49 | 320 | 19th century |
  | 14 | Cannery Row | John | Steinbeck | 1945 | 95 | 181 | 19th century |
  | 15 | Oblivion: Stories | David | Foster Wallace | 2004 | 172 | 329 | afte 20th century |
  | 16 | Consider the Lobster | David | Foster Wallace | 2005 | 92 | 343 | afte 20th century |
  | 17 | 10% Happier | Dan | Harris | 2014 | 29 | 256 | afte 20th century |
  | 18 | fake_book | Freida | Harris | 2001 | 287 | 428 | afte 20th century |
  | 19 | Lincoln In The Bardo | George | Saunders | 2017 | 1000 | 367 | afte 20th century |
  | 20 | NULL | NULL | NULL | NULL | NULL | NULL | 19th century |
  +---------+-----------------------------------------------------+--------------+----------------+---------------+----------------+-------+-------------------+
  20 rows in set (0.010 sec)

## `IS NULL`

- null has a very unique comparator, null doesn't work with logical comparators.
- `where col is null`
- `IS NOT NULL`
  - opposite of `is null`
  - `where col is not null`

`select * from books where author_lname like 'c%' or author_lname like 's%';`
`mysql> select title,author_lname, case when title like '%Stories' then 'Short stories' when title like 'Just Kids' and title like '%A Heartbreaking Work%' then 'Memoir' else 'novel' end as type from books;`
+-----------------------------------------------------+----------------+---------------+
| title | author_lname | type |
+-----------------------------------------------------+----------------+---------------+
| The Namesake | Lahiri | novel |
| Norse Mythology | Gaiman | novel |
| American Gods | Gaiman | novel |
| Interpreter of Maladies | Lahiri | novel |
| A Hologram for the King: A Novel | Eggers | novel |
| The Circle | Eggers | novel |
| The Amazing Adventures of Kavalier & Clay | Chabon | novel |
| Just Kids | Smith | novel |
| A Heartbreaking Work of Staggering Genius | Eggers | novel |
| Coraline | Gaiman | novel |
| What We Talk About When We Talk About Love: Stories | Carver | Short stories |
| Where I'm Calling From: Selected Stories | Carver | Short stories |
| White Noise | DeLillo | novel |
| Cannery Row | Steinbeck | novel |
| Oblivion: Stories | Foster Wallace | Short stories |
| Consider the Lobster | Foster Wallace | novel |
| 10% Happier | Harris | novel |
| fake_book | Harris | novel |
| Lincoln In The Bardo | Saunders | novel |
| NULL | NULL | novel |
+-----------------------------------------------------+----------------+---------------+
20 rows in set (0.206 sec)

`mysql> select author_fname, author_lname, concat(count(*), ' books') count from books group by author_fname,author_lname;` // this will return all as books
`mysql> select author_fname, author_lname, case when count(*) > 1 then concat(count(*), ' books') else concat(count(*),' book') end as count from books group by author_fname,author_lname;`
+--------------+----------------+---------+
| author_fname | author_lname | count |
+--------------+----------------+---------+
| Jhumpa | Lahiri | 2 books |
| Neil | Gaiman | 3 books |
| Dave | Eggers | 3 books |
| Michael | Chabon | 1 book |
| Patti | Smith | 1 book |
| Raymond | Carver | 2 books |
| Don | DeLillo | 1 book |
| John | Steinbeck | 1 book |
| David | Foster Wallace | 2 books |
| Dan | Harris | 1 book |
| Freida | Harris | 1 book |
| George | Saunders | 1 book |
| NULL | NULL | 1 book |
+--------------+-----------`
