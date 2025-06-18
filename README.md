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
