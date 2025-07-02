# LS181 Exam Study Guide

## I. SQL

### 1. [Identify the different types of `JOIN`s and explain their differences](https://launchschool.com/books/sql/read/joins#whatissqljoin)

#### `(INNER) JOIN`
- Joins rows where both relations have entities
- no join-generated NULL values
- Filters incomplete joined rows

#### `LEFT (OUTER) JOIN`
- Selects all entries from the left table joined to any correlated entry that exists from the right
- Generates NULL values for entries on the right that do not have a match for the ON clause
- Filters results from the right table that do not correspond to an entry in the left table

#### `RIGHT (OUTER) JOIN`
- Selects all entries from the right table joined to any correlated entry that exists from the right
- Generates NULL values for entries on the left that do not have a match for the ON clause
- Filters results from the left table that do not correspond to an entry in the left table

#### `FULL OUTER JOIN`
- Combines `LEFT OUTER JOIN` and `RIGHT OUTER JOIN`
- Selects all entries from the left table joined to any correlated entry that exists from the right
- Generates NULL values for entries on the right that do not have a match for the ON clause
- Selects all entries from the right table joined to any correlated entry that exists from the right
- Generates NULL values for entries on the left that do not have a match for the ON clause
- Returns selected columns from all entries from both tables

#### `CROSS JOIN`
- Joins every entry from the left table with every table on the right
- Also called the **cartesian product**
    
### 2. [Name and define the three sublanguages of SQL and be able to classify different statements by sublanguage](https://launchschool.com/books/sql/read/interacting_with_postgresql#sqlsublanguages)

#### DDL:
- Data Definition Language
- Used to define the structure of a database and the tables and columns within it
- `CREATE`, `DROP`, `ALTER`

#### DML:
- Data Manipulation Language
- Used to retrieve or modify data stored in a database
- `SELECT`, `INSERT`, `DELETE`, `UPDATE`

#### DCL:
- Data Control Language
- Used to determine what various users are allowed to do when interacting with a database
- `GRANT`, `REVOKE`
    
### 3. Write SQL statements using:

#### [`SELECT`](https://launchschool.com/books/sql/read/select_queries#selectquerysyntax):
1. Basic syntax:
    ```sql
    SELECT column_name, ... 
    FROM table_name 
    WHERE condition;
    ```

#### [`INSERT`](https://launchschool.com/books/sql/read/add_data#insertionstatementsyntax):
1. Basic syntax:
    ```sql
    INSERT INTO table_name (column1_name, column2_name, ... )
        VALUES (data_for_column1, data_for_column2, ... );
    ```

#### [`UPDATE`](https://launchschool.com/books/sql/read/update_and_delete_data#updatingdata):
1. Basic syntax:
    ```sql
    UPDATE table_name
    SET column_name = value, ...
    WHERE expression;
    ```

#### [`DELETE`](https://launchschool.com/books/sql/read/update_and_delete_data#deletingdata):
1. Basic syntax:
    ```sql
    DELETE FROM table_name WHERE expression;
    ```

#### [`CREATE TABLE`](https://launchschool.com/books/sql/read/create_table#tablecreationsyntax):
1. Basic syntax:
    ```sql
    CREATE TABLE table_name (
        column_1_name column_1_data_type [constraints, ... ],
        column_2_name column_2_data_type [constraints, ... ],
        .
        .
        .
        constraints
    );
    ```

#### [`ALTER TABLE`](https://launchschool.com/books/sql/read/alter_table#altertablesyntax):
1. Add a Constraint:
    ```sql
    ALTER TABLE all_users
    ADD CONSTRAINT no_empty_name CHECK (full_name != '');
    ```

2. Remove a Constraint:
    ```sql
    ALTER TABLE table_name
    DROP CONSTRAINT constraint_name;
    ```

#### [`DROP TABLE`](https://launchschool.com/books/sql/read/alter_table#droppingtables):
1. Basic syntax:
    ```sql
    DROP TABLE all_users;
    ```

#### [`ADD COLUMN`](https://launchschool.com/books/sql/read/alter_table#addingacolumn):
1. Basic syntax:
    ```sql
    ALTER TABLE all_users
    ADD COLUMN last_login timestamp NOT NULL DEFAULT NOW();
    ```

#### [`ALTER COLUMN`](https://launchschool.com/books/sql/read/alter_table#renamingacolumn):
1. Rename a Column:
    ```sql
    ALTER TABLE all_users
    RENAME COLUMN username TO full_name;
    ```
2. Change a Column's datatype:
    ```sql
    ALTER TABLE all_users
    ALTER COLUMN full_name TYPE varchar(25);
    ```
3. Set a Column to NOT NULL:
    ```sql
    ALTER TABLE table_name
    ALTER COLUMN column_name SET NOT NULL;
    ```

#### [`DROP COLUMN`](https://launchschool.com/books/sql/read/alter_table#removingacolumn):
1. Basic syntax:
    ```sql
    ALTER TABLE table_name
    DROP COLUMN column_name;
    ```

### 4. Understand how to use:
    
#### [`GROUP BY`](https://launchschool.com/books/sql/read/more_on_select#groupby):
1. Basic syntax:
    ```sql
    SELECT column_name, count(id) 
    FROM table_name
    GROUP BY column_name;
    ```

#### [`ORDER BY`](https://launchschool.com/books/sql/read/select_queries#ordering):
1. Basic syntax:
    ```sql
    SELECT column_name, ...
    FROM table_name
    WHERE condition
    ORDER BY column_name [ASC/DESC];
    ```

#### [`WHERE`](https://launchschool.com/books/sql/read/basics_tutorial#selectrows):
1. Basic syntax:
    ```sql
    SELECT column_name, ...
    FROM table_name
    WHERE condition
    ```

#### [`HAVING`](https://launchschool.com/lessons/a1779fd2/assignments/f4b7a9dc):


### 5. [Understand how to create and remove constraints, including `CHECK` constraints](https://launchschool.com/books/sql/read/add_data#constraintsdata)

#### CREATE CONSTRAINT

#### DROP CONSTRAINT
    
### 6. [Be familiar with using subqueries and join tables](https://launchschool.com/lessons/e752508c/assignments/2009d549)

#### Subqueries

#### Joins

<br>

## II. PostgreSQL

### 1. [Describe what a sequence is and what they are used for](https://launchschool.com/lessons/a1779fd2/assignments/00e428da)

#### Sequences
1. A sequence is a special kind of relation that generates a series of numbers. 

2. A sequence will remember the last number it generated, so it will generate numbers in a predetermined sequence automatically.

### 2. [Create an auto-incrementing column](https://launchschool.com/lessons/a1779fd2/assignments/00e428da)

#### Auto-incrementing Column
1. Basic syntax:
    ```sql
    CREATE SEQUENCE table1_id_seq;
    SELECT nextval('table1_id_seq');
    ```

### 3. [Define a default value for a column](https://launchschool.com/lessons/a1779fd2/assignments/c6a5a6cb)

#### DEFAULT
1. Basic syntax:
    ```sql
    ALTER TABLE table1 ALTER COLUMN column1 SET DEFAULT 0;
    ```

### 4. [Be able to describe what primary, foreign, natural, and surrogate keys are](https://launchschool.com/lessons/a1779fd2/assignments/00e428da)

#### PRIMARY KEY
1. a Primary key uniquely identifies rows within its own table. 

#### FOREIGN KEY
1. Foreign keys create relationships by referencing unique columns (usually primary keys) in other tables and enforce referential integrity when constrained.

#### Natural Key
1. A natural key is an existing value in a dataset that can uniquely identify each row, like a phone number or email address

2. These often have issues like changing or not being unique.

#### Surrogate Key
1. A surrogate key is a value created solely to identify a row, usually an auto-incrementing number (like an id)

2. This avoids problems that natural keys have because surrogate keys are unique and stable.

### 5. [Create and remove `CHECK` constraints from a column](https://launchschool.com/books/sql/read/add_data#constraintsdata)

#### CREATE CHECK
1. Basic syntax:
    ```sql
    ALTER TABLE table1 ADD CHECK (column_name = condition);
    ```
     or
    ```sql
    ALTER TABLE table1 ADD CONSTRAINT table1_column_name_check CHECK (column_name = condition);
    ```

#### Remove CHECK CONSTRAINT
1. Basic syntax:
    ```sql
    ALTER TABLE table1 DROP CONSTRAINT table1_column_name_check;
    ```

### 6. [Create and remove foreign key constraints from a column](https://launchschool.com/lessons/5ae760fa/assignments/bb4f3ba2)

#### CREATE FOREIGN KEY
1. Basic syntax:
    ```sql
    ALTER TABLE table1 ADD CONSTRAINT table1_table2_id_fkey FOREIGN KEY (table2_id) REFERENCES table2(id);
    ```

#### Remove Foreign Key Constraints
1. Basic syntax:
    ```sql
    ALTER TABLE table1 DROP CONSTRAINT table1_table2_id_fkey;
    ```
<br>

## III. Database Diagrams

### 1. [Talk about the different levels of schema](https://launchschool.com/lessons/5ae760fa/assignments/2f3bc8f7).

### 2. [Define cardinality and modality](https://launchschool.com/lessons/5ae760fa/assignments/46053e3b)

### 3. Be able to draw database diagrams using crow's foot notation.

### 4. Be able to interpret existing ERDs and crow's foot notation
