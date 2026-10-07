create view full_review_series as select first_name, last_name, count(*) as count, ifnull(min(rating),0), ifnull(max(rating),0),ifnull(avg(rating),0), case when count(*) >1 then 'ACTIVE' else 'INACTIVE' end as STATUS from reviewers left join reviews on reviewers.id = reviews.reviewer_id group by first_name, last_name;
show tables;
select * from full_review_series; // will give the same response of above select query.


-- Window


CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

mysql> select *, rank() over(partition by department order by salary) from employees;
+--------+------------------+--------+------------------------------------------------------+
| emp_no | department       | salary | rank() over(partition by department order by salary) |
+--------+------------------+--------+------------------------------------------------------+
|     19 | customer service |  31000 |                                                    1 |
|     15 | customer service |  38000 |                                                    2 |
|     18 | customer service |  40000 |                                                    3 |
|     16 | customer service |  45000 |                                                    4 |
|     21 | customer service |  55000 |                                                    5 |
|     20 | customer service |  56000 |                                                    6 |
|     17 | customer service |  61000 |                                                    7 |
|      5 | engineering      |  67000 |                                                    1 |
|      2 | engineering      |  69000 |                                                    2 |
|      3 | engineering      |  70000 |                                                    3 |
|      1 | engineering      |  80000 |                                                    4 |
|      6 | engineering      |  89000 |                                                    5 |
|      7 | engineering      |  91000 |                                                    6 |
|      4 | engineering      | 103000 |                                                    7 |
|      8 | sales            |  59000 |                                                    1 |
|     12 | sales            |  60000 |                                                    2 |
|     13 | sales            |  61000 |                                                    3 |
|     14 | sales            |  61000 |                                                    3 |
|      9 | sales            |  70000 |                                                    5 |
|     11 | sales            |  72000 |                                                    6 |
|     10 | sales            | 159000 |                                                    7 |
+--------+------------------+--------+------------------------------------------------------+
21 rows in set (0.011 sec)

mysql> select *, rank() over(partition by department order by salary),row_number() over(partition by department order by salary) as row_num from employees;
+--------+------------------+--------+------------------------------------------------------+---------+
| emp_no | department       | salary | rank() over(partition by department order by salary) | row_num |
+--------+------------------+--------+------------------------------------------------------+---------+
|     19 | customer service |  31000 |                                                    1 |       1 |
|     15 | customer service |  38000 |                                                    2 |       2 |
|     18 | customer service |  40000 |                                                    3 |       3 |
|     16 | customer service |  45000 |                                                    4 |       4 |
|     21 | customer service |  55000 |                                                    5 |       5 |
|     20 | customer service |  56000 |                                                    6 |       6 |
|     17 | customer service |  61000 |                                                    7 |       7 |
|      5 | engineering      |  67000 |                                                    1 |       1 |
|      2 | engineering      |  69000 |                                                    2 |       2 |
|      3 | engineering      |  70000 |                                                    3 |       3 |
|      1 | engineering      |  80000 |                                                    4 |       4 |
|      6 | engineering      |  89000 |                                                    5 |       5 |
|      7 | engineering      |  91000 |                                                    6 |       6 |
|      4 | engineering      | 103000 |                                                    7 |       7 |
|      8 | sales            |  59000 |                                                    1 |       1 |
|     12 | sales            |  60000 |                                                    2 |       2 |
|     13 | sales            |  61000 |                                                    3 |       3 |
|     14 | sales            |  61000 |                                                    3 |       4 |
|      9 | sales            |  70000 |                                                    5 |       5 |
|     11 | sales            |  72000 |                                                    6 |       6 |
|     10 | sales            | 159000 |                                                    7 |       7 |
+--------+------------------+--------+------------------------------------------------------+---------+
21 rows in set (0.057 sec)


mysql> select *, rank() over(partition by department order by salary),row_number() over(partition by department order by salary) as row_num, rank() over(order by salary) from employees;
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+
| emp_no | department       | salary | rank() over(partition by department order by salary) | row_num | rank() over(order by salary) |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+
|     19 | customer service |  31000 |                                                    1 |       1 |                            1 |
|     15 | customer service |  38000 |                                                    2 |       2 |                            2 |
|     18 | customer service |  40000 |                                                    3 |       3 |                            3 |
|     16 | customer service |  45000 |                                                    4 |       4 |                            4 |
|     21 | customer service |  55000 |                                                    5 |       5 |                            5 |
|     20 | customer service |  56000 |                                                    6 |       6 |                            6 |
|      8 | sales            |  59000 |                                                    1 |       1 |                            7 |
|     12 | sales            |  60000 |                                                    2 |       2 |                            8 |
|     17 | customer service |  61000 |                                                    7 |       7 |                            9 |
|     13 | sales            |  61000 |                                                    3 |       3 |                            9 |
|     14 | sales            |  61000 |                                                    3 |       4 |                            9 |
|      5 | engineering      |  67000 |                                                    1 |       1 |                           12 |
|      2 | engineering      |  69000 |                                                    2 |       2 |                           13 |
|      3 | engineering      |  70000 |                                                    3 |       3 |                           14 |
|      9 | sales            |  70000 |                                                    5 |       5 |                           14 |
|     11 | sales            |  72000 |                                                    6 |       6 |                           16 |
|      1 | engineering      |  80000 |                                                    4 |       4 |                           17 |
|      6 | engineering      |  89000 |                                                    5 |       5 |                           18 |
|      7 | engineering      |  91000 |                                                    6 |       6 |                           19 |
|      4 | engineering      | 103000 |                                                    7 |       7 |                           20 |
|     10 | sales            | 159000 |                                                    7 |       7 |                           21 |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+
21 rows in set (0.012 sec)

mysql> select *, rank() over(partition by department order by salary),row_number() over(partition by department order by salary desc) as row_num, rank() over(order by salary) from employees;
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+
| emp_no | department       | salary | rank() over(partition by department order by salary) | row_num | rank() over(order by salary) |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+
|     19 | customer service |  31000 |                                                    1 |       7 |                            1 |
|     15 | customer service |  38000 |                                                    2 |       6 |                            2 |
|     18 | customer service |  40000 |                                                    3 |       5 |                            3 |
|     16 | customer service |  45000 |                                                    4 |       4 |                            4 |
|     21 | customer service |  55000 |                                                    5 |       3 |                            5 |
|     20 | customer service |  56000 |                                                    6 |       2 |                            6 |
|      8 | sales            |  59000 |                                                    1 |       7 |                            7 |
|     12 | sales            |  60000 |                                                    2 |       6 |                            8 |
|     17 | customer service |  61000 |                                                    7 |       1 |                            9 |
|     13 | sales            |  61000 |                                                    3 |       4 |                            9 |
|     14 | sales            |  61000 |                                                    3 |       5 |                            9 |
|      5 | engineering      |  67000 |                                                    1 |       7 |                           12 |
|      2 | engineering      |  69000 |                                                    2 |       6 |                           13 |
|      3 | engineering      |  70000 |                                                    3 |       5 |                           14 |
|      9 | sales            |  70000 |                                                    5 |       3 |                           14 |
|     11 | sales            |  72000 |                                                    6 |       2 |                           16 |
|      1 | engineering      |  80000 |                                                    4 |       4 |                           17 |
|      6 | engineering      |  89000 |                                                    5 |       3 |                           18 |
|      7 | engineering      |  91000 |                                                    6 |       2 |                           19 |
|      4 | engineering      | 103000 |                                                    7 |       1 |                           20 |
|     10 | sales            | 159000 |                                                    7 |       1 |                           21 |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+
21 rows in set (0.011 sec)

mysql>

mysql> select *, rank() over(partition by department order by salary),row_number() over(partition by department order by salary desc) as row_num, rank() over(order by salary), dense_rank() over(order by salary) from employees;
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+------------------------------------+
| emp_no | department       | salary | rank() over(partition by department order by salary) | row_num | rank() over(order by salary) | dense_rank() over(order by salary) |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+------------------------------------+
|     19 | customer service |  31000 |                                                    1 |       7 |                            1 |                                  1 |
|     15 | customer service |  38000 |                                                    2 |       6 |                            2 |                                  2 |
|     18 | customer service |  40000 |                                                    3 |       5 |                            3 |                                  3 |
|     16 | customer service |  45000 |                                                    4 |       4 |                            4 |                                  4 |
|     21 | customer service |  55000 |                                                    5 |       3 |                            5 |                                  5 |
|     20 | customer service |  56000 |                                                    6 |       2 |                            6 |                                  6 |
|      8 | sales            |  59000 |                                                    1 |       7 |                            7 |                                  7 |
|     12 | sales            |  60000 |                                                    2 |       6 |                            8 |                                  8 |
|     17 | customer service |  61000 |                                                    7 |       1 |                            9 |                                  9 |
|     13 | sales            |  61000 |                                                    3 |       4 |                            9 |                                  9 |
|     14 | sales            |  61000 |                                                    3 |       5 |                            9 |                                  9 |
|      5 | engineering      |  67000 |                                                    1 |       7 |                           12 |                                 10 |
|      2 | engineering      |  69000 |                                                    2 |       6 |                           13 |                                 11 |
|      3 | engineering      |  70000 |                                                    3 |       5 |                           14 |                                 12 |
|      9 | sales            |  70000 |                                                    5 |       3 |                           14 |                                 12 |
|     11 | sales            |  72000 |                                                    6 |       2 |                           16 |                                 13 |
|      1 | engineering      |  80000 |                                                    4 |       4 |                           17 |                                 14 |
|      6 | engineering      |  89000 |                                                    5 |       3 |                           18 |                                 15 |
|      7 | engineering      |  91000 |                                                    6 |       2 |                           19 |                                 16 |
|      4 | engineering      | 103000 |                                                    7 |       1 |                           20 |                                 17 |
|     10 | sales            | 159000 |                                                    7 |       1 |                           21 |                                 18 |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+------------------------------------+
21 rows in set (0.025 sec)

mysql> select *, rank() over(partition by department order by salary),row_number() over(partition by department order by salary desc) as row_num, rank() over(order by salary), dense_rank() over(order by salary), ntile(10) over(order by salary) from employees;
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+------------------------------------+---------------------------------+
| emp_no | department       | salary | rank() over(partition by department order by salary) | row_num | rank() over(order by salary) | dense_rank() over(order by salary) | ntile(10) over(order by salary) |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+------------------------------------+---------------------------------+
|     19 | customer service |  31000 |                                                    1 |       7 |                            1 |                                  1 |                               1 |
|     15 | customer service |  38000 |                                                    2 |       6 |                            2 |                                  2 |                               1 |
|     18 | customer service |  40000 |                                                    3 |       5 |                            3 |                                  3 |                               1 |
|     16 | customer service |  45000 |                                                    4 |       4 |                            4 |                                  4 |                               2 |
|     21 | customer service |  55000 |                                                    5 |       3 |                            5 |                                  5 |                               2 |
|     20 | customer service |  56000 |                                                    6 |       2 |                            6 |                                  6 |                               3 |
|      8 | sales            |  59000 |                                                    1 |       7 |                            7 |                                  7 |                               3 |
|     12 | sales            |  60000 |                                                    2 |       6 |                            8 |                                  8 |                               4 |
|     17 | customer service |  61000 |                                                    7 |       1 |                            9 |                                  9 |                               4 |
|     13 | sales            |  61000 |                                                    3 |       4 |                            9 |                                  9 |                               5 |
|     14 | sales            |  61000 |                                                    3 |       5 |                            9 |                                  9 |                               5 |
|      5 | engineering      |  67000 |                                                    1 |       7 |                           12 |                                 10 |                               6 |
|      2 | engineering      |  69000 |                                                    2 |       6 |                           13 |                                 11 |                               6 |
|      3 | engineering      |  70000 |                                                    3 |       5 |                           14 |                                 12 |                               7 |
|      9 | sales            |  70000 |                                                    5 |       3 |                           14 |                                 12 |                               7 |
|     11 | sales            |  72000 |                                                    6 |       2 |                           16 |                                 13 |                               8 |
|      1 | engineering      |  80000 |                                                    4 |       4 |                           17 |                                 14 |                               8 |
|      6 | engineering      |  89000 |                                                    5 |       3 |                           18 |                                 15 |                               9 |
|      7 | engineering      |  91000 |                                                    6 |       2 |                           19 |                                 16 |                               9 |
|      4 | engineering      | 103000 |                                                    7 |       1 |                           20 |                                 17 |                              10 |
|     10 | sales            | 159000 |                                                    7 |       1 |                           21 |                                 18 |                              10 |
+--------+------------------+--------+------------------------------------------------------+---------+------------------------------+------------------------------------+---------------------------------+

mysql> SELECT emp_no, department, salary,lag(salary) over(order by salary), lead(salary) over(order by salary) from employees;
+--------+------------------+--------+-----------------------------------+------------------------------------+
| emp_no | department       | salary | lag(salary) over(order by salary) | lead(salary) over(order by salary) |
+--------+------------------+--------+-----------------------------------+------------------------------------+
|     19 | customer service |  31000 |                              NULL |                              38000 |
|     15 | customer service |  38000 |                             31000 |                              40000 |
|     18 | customer service |  40000 |                             38000 |                              45000 |
|     16 | customer service |  45000 |                             40000 |                              55000 |
|     21 | customer service |  55000 |                             45000 |                              56000 |
|     20 | customer service |  56000 |                             55000 |                              59000 |
|      8 | sales            |  59000 |                             56000 |                              60000 |
|     12 | sales            |  60000 |                             59000 |                              61000 |
|     13 | sales            |  61000 |                             60000 |                              61000 |
|     14 | sales            |  61000 |                             61000 |                              61000 |
|     17 | customer service |  61000 |                             61000 |                              67000 |
|      5 | engineering      |  67000 |                             61000 |                              69000 |
|      2 | engineering      |  69000 |                             67000 |                              70000 |
|      3 | engineering      |  70000 |                             69000 |                              70000 |
|      9 | sales            |  70000 |                             70000 |                              72000 |
|     11 | sales            |  72000 |                             70000 |                              80000 |
|      1 | engineering      |  80000 |                             72000 |                              89000 |
|      6 | engineering      |  89000 |                             80000 |                              91000 |
|      7 | engineering      |  91000 |                             89000 |                             103000 |
|      4 | engineering      | 103000 |                             91000 |                             159000 |
|     10 | sales            | 159000 |                            103000 |                               NULL |
+--------+------------------+--------+-----------------------------------+------------------------------------+
21 rows in set (0.013 sec)


mysql> SELECT emp_no, department, salary,salary - lag(salary) over(order by salary) as lag_salary,  salary - lead(salary) over(order by salary) lead_salary from employees;
+--------+------------------+--------+------------+-------------+
| emp_no | department       | salary | lag_salary | lead_salary |
+--------+------------------+--------+------------+-------------+
|     19 | customer service |  31000 |       NULL |       -7000 |
|     15 | customer service |  38000 |       7000 |       -2000 |
|     18 | customer service |  40000 |       2000 |       -5000 |
|     16 | customer service |  45000 |       5000 |      -10000 |
|     21 | customer service |  55000 |      10000 |       -1000 |
|     20 | customer service |  56000 |       1000 |       -3000 |
|      8 | sales            |  59000 |       3000 |       -1000 |
|     12 | sales            |  60000 |       1000 |       -1000 |
|     13 | sales            |  61000 |       1000 |           0 |
|     14 | sales            |  61000 |          0 |           0 |
|     17 | customer service |  61000 |          0 |       -6000 |
|      5 | engineering      |  67000 |       6000 |       -2000 |
|      2 | engineering      |  69000 |       2000 |       -1000 |
|      3 | engineering      |  70000 |       1000 |           0 |
|      9 | sales            |  70000 |          0 |       -2000 |
|     11 | sales            |  72000 |       2000 |       -8000 |
|      1 | engineering      |  80000 |       8000 |       -9000 |
|      6 | engineering      |  89000 |       9000 |       -2000 |
|      7 | engineering      |  91000 |       2000 |      -12000 |
|      4 | engineering      | 103000 |      12000 |      -56000 |
|     10 | sales            | 159000 |      56000 |        NULL |
+--------+------------------+--------+------------+-------------+
21 rows in set (0.017 sec)
