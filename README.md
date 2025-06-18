# LS-LS180 - Database Foundations
Repository for working through Launch School's LS180 Course

## :green_book: Books
1. [Introduction to SQL](https://launchschool.com/books/sql)

## :memo: Articles
1. [PostgreSQL Documentation](https://wiki.postgresql.org/wiki/Main_Page)

## :clipboard: Notes

### ALTER TABLE / COLUMN SYNTAX

| Action | Command | Notes | 
|--------|---------|-------|
| Add a column to a table | ALTER TABLE table_name ADD COLUMN column_name data_type CONSTRAINTS; | Alters a table by adding a column with a specified data type and optional constraints. |
| Alter a column's data type | ALTER TABLE table_name ALTER COLUMN column_name TYPE data_type; | Alters the table by changing the datatype of column. |
| Rename a table | ALTER TABLE table_name RENAME TO new_table_name; | Changes the name of a table in the currently connected to database. |
| Rename a column within a table | ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name; | Renames a column of the specified table. |
| Add column constraint (`NOT NULL`) | ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL; | Adds a specified constraint to the specified table column. |
| Add table constraint | ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_clause; | Adds a specified constraint to the specified table. |
| Remove a table constraint | ALTER TABLE table_name DROP CONSTRAINT constraint_name; | Removes a constraint from the specified table. |
| Remove a column constraint | ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL; | Removes a constraint from the specified column. This syntax is necessary for `NOT NULL` constraints, which aren't specifically named. |
| Remove a column from a table | ALTER TABLE table_name DROP COLUMN column_name; | Removes a column from the specified table. |
| Delete a table from the database | DROP TABLE table_name; | Permanently deletes the specified table from its database. |

&nbsp;

### Common PostgreSQL Functions

#### String Functions:

| Function | Example | Notes |
|----------|---------|-------|
| length | SELECT length(full_name) FROM users; | This returns the length of every user's name. You could also use `length` in a `WHERE` clause to filter data based on name length. |
| trim | SELECT trim(leading ' ' from full_name) FROM users; | If any of the data in our `full_name` column had a space in front of the name, using the `trim` function like this would remove that leading space. |

#### Date / Time Functions



| Function | Example | Notes |
|----------|---------|-------|
| date_part | SELECT full_name, date_part('year', last_login) FROM users; | `date_part` allows us to view a table that only contains a part of a user's timestamp that we specify. The example query allows us to see each user's name along with the year of the `last_login` date. Sometimes having date/time data down to the second isn't needed. |
| age | SELECT full_name, age(last_login) FROM users; | The `age` function, when passed a single `timestamp` as an argument, calculates the time elapsed between that timestamp and the current time. The example query allows us to see how long it has been since each user last logged in. |


#### Aggregate Functions:

| Function | Example | Notes |
|----------|---------|-------|
| count | SELECT count(id) FROM users; | Returns the number of values in the column passed in as an argument. This type of function can be very useful depending on the context. We could find the number of users who have enabled an account, or even how many users have certain last names if we use the above statement with other clauses. |
| sum | SELECT sum(id) FROM users; | Not to be confused with `count`. This _sums_ numeric type values for all of the selected rows and returns the total. |
| min | SELECT min(last_login) FROM users; | This returns the lowest value in a column for all of the selected rows. Can be used with various data types such as numeric, date/ time, and string. 
| max | SELECT max(last_login) FROM users; | This returns the highest value in a column for all of the selected rows. Can be used with various data types such as numeric, date/ time, and string. |
| avg | SELECT avg(id) FROM users; | Returns the average (arithmetic mean) of numeric type values for all of the selected rows. |