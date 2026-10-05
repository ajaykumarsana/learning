# source

- Go to sql file location
- open mysql terminal
- source 2.sql

# concat

- concatenate multiple collumns together or any strings with columnns
- usage `select concat(<col1>,<col2>) from <table_name>;`
- `select concat(author_fname,author_lname) from books;`
- With alias ` select concat(author_fname,author_lname) as name from books;`
  mysql> select concat(author_fname,author_lname) as name from books;
  +---------------------+
  | name |
  +---------------------+
  | JhumpaLahiri |

## concat_ws

- this is used for `concatenation with seperator`
- syntax is `concat_ws('delimiter',columns...[strings array])`
- mysql> select concat_ws(' ',author_fname,author_lname) as name from books;
  +----------------------+
  | name |
  +----------------------+
  | Jhumpa Lahiri |
  | Neil Gaiman |

# substring - substr

- `substring(value, index,?length)`
- `substr`
- index starts from 1 unlike array string.
  - negative value of index would apply from reverse position of the string till the count of value.
- if length not inputed from index position to till last of text would return.
- mysql> select substr(title,1) from books;
  +-----------------------------------------------------+
  | substr(title,1) |
  +-----------------------------------------------------+
  | The Namesake |
  | Norse Mythology |
  | American Gods |
- mysql> select substr(title,-3) from books;
  +------------------+
  | substr(title,-3) |
  +------------------+

# combine concat and substr

`mysql> select concat(substr(title,1,10),'...') as short_title from books;`
+---------------+
| short_title |
+---------------+
| The Namesa... |
| Norse Myth... |
| American G... |

# replace

- this is used to replace the selected string with desired values
- it is case sensitive
- syntax `replace(column,'replacable string','replaced string')`
- `mysql> select title from books;`
  +-----------------------------------------------------+
  | title |
  +-----------------------------------------------------+
  | The Namesake |
  | Norse Mythology |
  | American Gods |
  | Interpreter of Maladies |

- `mysql> select replace(title, ' ','-') from books;`
  +-----------------------------------------------------+
  | replace(title, ' ','-') |
  +-----------------------------------------------------+
  | The-Namesake |
  | Norse-Mythology |
  | American-Gods |
  | Interpreter-of-Maladies |

# reverse

- it is used to reverse the string.
- syntax `reverse(column)`
- mysql> select reverse(title) from books;
  +-----------------------------------------------------+
  | reverse(title) |
  +-----------------------------------------------------+
  | ekasemaN ehT |
  | ygolohtyM esroN |
  | sdoG naciremA |
  | seidalaM fo reterpretnI |
  | levoN A :gniK eht rof margoloH A |

# char_length

- it returns number of characters in the given string
- syntax `char_length(column)`
- mysql> select char_length(title) as title_length from books;
  +--------------+
  | title_length |
  +--------------+
  | 12 |
  | 15 |
  | 13 |

# LOWER , UPPER

- transform the given string to lower and upper case respectively
- syntax `lower(column)`, `upper(string...[column])`
- mysql> SELECT upper(AUTHOR_FNAME), LOWER(AUTHOR_LNAME) FROM BOOKS;
  +---------------------+---------------------+
  | upper(AUTHOR_FNAME) | LOWER(AUTHOR_LNAME) |
  +---------------------+---------------------+
  | JHUMPA | lahiri |
  | NEIL | gaiman |
  | NEIL | gaiman |

# INSERT

- it is used to add or replace text by specifying index, length and value
- syntax `replace (string...[column], index, length,'value')`
- mysql> select insert(title, 5, 1,' inserted') from books;
  +-------------------------------------------------------------+
  | insert(title, 5, 1,' inserted') |
  +-------------------------------------------------------------+
  | The insertedamesake |
  | Nors inserted Mythology |
  | Amer insertedcan Gods |

# left, right

- it is used to get left most or right most characters of given string with given number of charates
- syntax `left(column, index)` , `right(column, index)`
- mysql> select right(title,4) from books;
  +----------------+
  | right(title,4) |
  +----------------+
  | sake |
  | logy |
  | Gods |
- mysql> select left(title, 5) from books;
  +----------------+
  | left(title, 5) |
  +----------------+
  | The N |
  | Norse |
  | Ameri |
  | Inter |

# repeat

- it is used to repeat the given string with given no of time
- syntax `repeat(column, index);`
- mysql> select repeat(left(title,3) , 3) from books;
  +---------------------------+
  | repeat(left(title,3) , 3) |
  +---------------------------+
  | TheTheThe |
  | NorNorNor |
  | AmeAmeAme |
  | IntIntInt |
  | A HA HA H |
  | TheTheThe |

# trim

- it is used to trim the white spaces or character of our input choice from given string
- you can specity trailing, leading, both or nothing
- syntax `trim(string)`
- `trim( leading '.' from <string>)`
- `trim( trailing '.' from <string>)`
- `trim( both '.' from <string>)`

## some example

- reverse and upper case - `mysql> select upper(reverse(title)) from books;`
  +-----------------------------------------------------+
  | upper(reverse(title)) |
  +-----------------------------------------------------+
  | EKASEMAN EHT |
  | YGOLOHTYM ESRON |
- replace space with -> in title
  `mysql> select replace(title,' ','->') as title from books;`
  +--------------------------------------------------------------+
  | title |
  +--------------------------------------------------------------+
  | The->Namesake |
  | Norse->Mythology |
  | American->Gods |
- alias, revers with upper case of string
  `mysql> select author_fname as forward, upper(reverse(author_fname)) as reverse from books;`
  +---------+---------+
  | forward | reverse |
  +---------+---------+
  | Jhumpa | APMUHJ |
  | Neil | LIEN |
  | Neil | LIEN |
  | Jhumpa | APMUHJ |
  | Dave | EVAD |
  | Dave | EVAD |
  | Michael | LEAHCIM |

- complex use left, substr concat and so on
- `mysql> select concat(substr(title,1,10),'...') as 'short title', concat(author_lname,author_fname) as author, concat(stock_quantity,' in stock') as quantity from books;`
  +---------------+---------------------+--------------+
  | short title | author | quantity |
  +---------------+---------------------+--------------+
  | The Namesa... | LahiriJhumpa | 32 in stock |
  | Norse Myth... | GaimanNeil | 43 in stock |
  | American G... | GaimanNeil | 12 in stock |
  | Interprete... | LahiriJhumpa | 97 in stock |
  | A Hologram... | EggersDave | 154 in stock |
  | The Circle... | EggersDave | 26 in stock |
  | The Amazin... | ChabonMichael | 68 in stock |

- `mysql> select concat(left(title,10),'...') as 'short title', concat(author_lname,author_fname) as author, concat(stock_quantity,' in stock') as quantity from books;`
  +---------------+---------------------+--------------+
  | short title | author | quantity |
  +---------------+---------------------+--------------+
  | The Namesa... | LahiriJhumpa | 32 in stock |
  | Norse Myth... | GaimanNeil | 43 in stock |
  | American G... | GaimanNeil | 12 in stock |

- `left(title,10)` and `substr(title,1,10)` does the same

```sql
--8<-- "docs/mysql/2.sql"
```
