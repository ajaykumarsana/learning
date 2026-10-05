# Date data type

- used to store date in `yyyy-mm-dd` format.

# Time data type

- `hh:mm:ss`

# DateTime data type

- `yyyy-mm-dd hh:mm:ss`
- it has range of 1000 year to 9999 year range

# curtime

`mysql> select curtime();`
+-----------+
| curtime() |
+-----------+
| 20:27:37 |
+-----------+
1 row in set (0.051 sec)

# curdate

`mysql> select curdate();`
+------------+
| curdate() |
+------------+
| 2026-06-13 |
+------------+
1 row in set (0.004 sec)

# now - current_timestamp

`mysql> select now();`
+---------------------+
| now() |
+---------------------+
| 2026-06-13 20:28:47 |
+---------------------+
1 row in set (0.006 sec)

`mysql> select current_timestamp();`
+---------------------+
| current_timestamp() |
+---------------------+
| 2026-06-13 20:30:20 |
+---------------------+
1 row in set (0.005 sec)

# date functions

- day() - day of the month.
  - dayofmonth(birthdate) - day of the month.
- dayname() - prints day name of the week
- dayofweek() - day of the week. 1-7
- dayofyear() - day of the year
- week() - gets week number
- weekday() - gets days week day index
- weekofyear() - return week of the year
- month() - gives the month number
- monthname() - gets the month name
- year() - gives the year

# time functions

- hour(colname) - returns hours
- minute(colname) -
- second(colname)
- time(colname) - return time in HH:mm:SS in 24h

# DATE_FORMAT functions

- pre defined function to get date according format input
- syntax `DATE_FORMAT(<col>,format);`

  - format // can provide multiple format with sepertor of any choice

    - %a - weekday name
    - %b - month name
    - %c - month in numeric
    - %d, %e - day number of the month
    - %D - day of the month with english specific 1st, nd, rd, th...
    - %2 - weekday number
    - %W - weekday name
    - %m - month number
    - %M - month name
    - %r - time including AM or PM
    - %T - time of the field in hh:mm:ss in 24h
    - %y - Year number of last two digits
    - %Y - Whole Year number

    - ...

  - `mysql> select DATE_FORMAT(birthdt,'%a %b %m %d %e %T %r') from people;`
    +---------------------------------------------+
    | DATE_FORMAT(birthdt,'%a %b %m %d %e %T %r') |
    +---------------------------------------------+
    | Mon Dec 12 25 25 11:00:00 11:00:00 AM |
    | Thu Apr 04 11 11 09:45:10 09:45:10 AM |
    | Sat Aug 08 15 15 23:59:00 11:59:00 PM |
    | Sat Jun 06 13 13 20:46:41 08:46:41 PM |
    | Sat Jun 06 13 13 20:46:52 08:46:52 PM |
    +---------------------------------------------+
    5 rows in set (0.007 sec)

# DATEDIFF

- it will give the number of days differenc between two gives dates.
- syntax `DATEDIFF(date1,date2);`
- `mysql> select DATEDIFF(curdate(),birthdt) from people;`
  +-----------------------------+
  | DATEDIFF(curdate(),birthdt) |
  +-----------------------------+
  | 9302 |
  | 15039 |
  | 2129 |
  | 1 |
  | 1 |
  +-----------------------------+
  5 rows in set (0.008 sec)

# DATE_ADD, DATE_SUB methods

- it will adds up the given number to the given date
- syntax `DATE_ADD(date, INTERVAL <no> YEAR/DAY/HOUR/Minute/second)`
- `mysql> select birthdt, DATE_ADD(birthdt, INTERVAL 1 DAY), DATE_ADD(birthdt, INTERVAL 1 HOUR),  DATE_ADD(birthdt, INTERVAL 1 MINUTE), DATE_ADD(birthdt, INTERVAL 10 SECOND) from people;`
  +---------------------+-----------------------------------+------------------------------------+--------------------------------------+---------------------------------------+
  | birthdt | DATE_ADD(birthdt, INTERVAL 1 DAY) | DATE_ADD(birthdt, INTERVAL 1 HOUR) | DATE_ADD(birthdt, INTERVAL 1 MINUTE) | DATE_ADD(birthdt, INTERVAL 10 SECOND) |
  +---------------------+-----------------------------------+------------------------------------+--------------------------------------+---------------------------------------+
  | 2000-12-25 11:00:00 | 2000-12-26 11:00:00 | 2000-12-25 12:00:00 | 2000-12-25 11:01:00 | 2000-12-25 11:00:10 |
  | 1985-04-11 09:45:10 | 1985-04-12 09:45:10 | 1985-04-11 10:45:10 | 1985-04-11 09:46:10 | 1985-04-11 09:45:20 |
  | 2020-08-15 23:59:00 | 2020-08-16 23:59:00 | 2020-08-16 00:59:00 | 2020-08-16 00:00:00 | 2020-08-15 23:59:10 |
  | 2026-06-13 20:46:41 | 2026-06-14 20:46:41 | 2026-06-13 21:46:41 | 2026-06-13 20:47:41 | 2026-06-13 20:46:51 |
  | 2026-06-13 20:46:52 | 2026-06-14 20:46:52 | 2026-06-13 21:46:52 | 2026-06-13 20:47:52 | 2026-06-13 20:47:02 |
  +---------------------+-----------------------------------+------------------------------------+--------------------------------------+---------------------------------------+
  5 rows in set (0.008 sec)
  - these can be used at column with +,- operator and english text
    - `date + INTERVAL 1 DAY` would also give same result of DATE_ADD
    - `date - INTERVAL 1 DAY` would also give same result of DATE_SUB

# TIMEDIFF, ADDTIME, SUBTIME methods

- `select TIMEDIFF(birthtime,curtime()) from people;`
- `select ADDTIME(birthtime,'4:05') from people;`
  - `select ADDTIME(birthtime, 5) from people;`
  - `select ADDTIME(birthtime, '2:3:5') from people;`
- SUBTIME also works same way as ADDTIME

# timestamp data type

- used for values which contain date & time
- it is similar to DATETIME with difference in memory storage, it is tiny
  - it is due to storage less date range start from `1970-01-01 to 2038:01:19`
  - it doesn't suite for storing DOB.
- this best suits to track when the event are happening like create , update.
- `TIMESTAMP default current_timestamp`
  - `create table captions( text varchar(50), time TIMESTAMP default current_timestamp);`
  - takes the default current timestamp of insertion time
- # updated_at TIMESTAMP `ON UPDATE CURRENT_TIMESTAMP;`
  - this is for updating time stamp when update query is triggered at any colum of that row
