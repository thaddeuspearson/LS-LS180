# DML
*LS180 SQL Fundamentals Exercises*

## 1. Set Up Database

### Challenge:

1. Create a database named `workshop`.

2. Create a table should be called `devices`. This table should have columns that meet the following specifications:
    - Includes a primary key called `id` that is auto-incrementing.
    - A column called `name`, that can contain a String. It cannot be NULL.
    - A column called `created_at` that lists the date this device was created. It should be of type timestamp and it should also have a default value related to when a device is created.

3. Make a table called `parts` that reflects the information listed above. Table `parts` should have the following columns that meet the following specifications:
    - An `id` which auto-increments and acts as the primary key
    - A `part_number`. This column should be unique and not null.
    - A foreign key column called `device_id`. This will be used to associate various parts with a device.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
CREATE DATABASE workshop;

CREATE TABLE devices (
    id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
    id serial PRIMARY KEY,
    part_number integer NOT NULL UNIQUE,
    device_id integer REFERENCES devices (id)
);
```
</details>

<br>

## 2. Insert Data for Parts and Devices

### Challenge:

1. Add in two different devices. One should be named, `"Accelerometer"`. The other should be named, `"Gyroscope"`.

2. The first device should have 3 parts _(this is grossly simplified)_. The second device should have 5 parts. The part numbers may be any number between 1 and 10000.

3. There should also be 3 parts that don't belong to any device yet.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
INSERT INTO devices (name) VALUES ('Accelerometer'), ('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES (1, 1), (2, 1), (3, 1), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2);

INSERT INTO parts (part_number) VALUES (100), (200), (300);
```
</details>

<br>

## 3. Inner Join

### Challenge:

1. Write an SQL query to display all devices along with all the parts that make them up. We only want to display the name of the devices. Its parts should only display the part_number.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT d.name, p.part_number FROM devices d JOIN parts p ON d.id = p.device_id;
```
</details>

<br>

## 4. Select part_number

### Challenge:

1. We want to grab all parts that have a part_number that starts with 3. Write a SELECT query to get this information. This table may show all attributes of the parts table.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT * FROM parts WHERE part_number::text LIKE '3%';
```
</details>

<br>

## 5. Aggregate Functions

### Challenge:

1. Write an SQL query that returns a result table with the name of each device in our database together with the number of parts for that device.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT d.name, count(p.device_id) FROM devices d LEFT JOIN parts p on d.id = p.device_id GROUP BY d.name;
```
</details>

<br>

## 6. ORDER BY

### Challenge:

1. Alter the SQL query from the above challenge so that we get a result table that looks like the following

    ```sql
    name          | count
    --------------+-------
    Gyroscope     |     5
    Accelerometer |     3
    ```

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT d.name, count(p.device_id) FROM devices d LEFT JOIN parts p on d.id = p.device_id GROUP BY d.name ORDER BY d.name DESC;
```
</details>

<br>

## 7. IS NULL and IS NOT NULL

### Challenge:

1. Write two SQL queries:

    - One that generates a listing of parts that currently belong to a device.
    - One that generates a listing of parts that don't belong to a device.

2. Do not include the `id` column in your queries.

### Solution:

<details><summary>Click to Reveal</summary>

1. parts that currently belong to a device
    ```sql
    SELECT part_number, device_id FROM parts WHERE device_id IS NOT NULL;
    ```
2. parts that currently don't beling to a device
    ```sql
    SELECT part_number, device_id FROM parts WHERE device_id IS NULL;
    ```
</details>

<br>

## 8. Oldest Device

### Challenge:

1. Insert a device called `'Magnetometer'` to devices. Give it at least 1 part.

2. Write an SQL statement that will return the name of the oldest device from our devices table.

### Solution:

1. Insert `'Magnetometer'`:
    ```sql
    INSERT INTO devices (name) VALUES ('Magnetometer');
    INSERT INTO parts (part_number, device_id) VALUES (42, 3);
    ```
2. Select oldest Device:
    ```sql
    SELECT name AS oldest_device FROM devices ORDER BY created_at LIMIT 1;
    ```
</details>
