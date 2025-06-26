# DDL
*LS180 SQL Fundamentals Exercises*

## 1. Create an Extrasolar Planetary Database

### Challenge:

Create a postgresql database named `extrasolar`, and then create two tables in the database as follows:

1. `stars` table:

    - `id`: a unique serial number that auto-increments and serves as a primary key for this table.
    
    - `name`: the name of the star,e,g., "Alpha Centauri A". Allow room for 25 characters. Must be unique and non-null.
    
    - `distance`: the distance in light years from Earth. Define this as a whole number (e.g., 1, 2, 3, etc) that must be `non-null` and greater than 0.
    
    - `spectral_type`: the spectral type of the star: O, B, A, F, G, K, and M. Use a one character string.
    
    - `companions`: how many companion stars does the star have? A whole number will do. Must be non-null and non-negative.

2. `planets` table

    - `id`: a unique serial number that auto-increments and serves as a primary key for this table.
    
    - `designation`: a single alphabetic character that uniquely identifies the planet in its star system ('a', 'b', 'c', etc.)
    
    - `mass`: estimated mass in terms of Jupiter masses; use an integer for this value.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
CREATE DATABASE extrasolar;

CREATE TABLE stars (
    id serial PRIMARY KEY,
    name varchar(25) UNIQUE NOT NULL,
    distance integer NOT NULL CHECK (distance > 0),
    spectral_type VARCHAR(1), 
    companions integer NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
    id serial PRIMARY KEY,
    designation varchar(1) UNIQUE,
    mass integer
);
```
</details>

<br>

## 2. Relating Stars and Planets

### Challenge:

Add a `star_id` column to the `planets` table; this column will be used to relate each planet in the planets table to its home star in the `stars` table. Make sure the column is defined in such a way that it is required and must have a value that is present as an id in the stars table.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
ALTER TABLE planets 
ADD COLUMN star_id integer NOT NULL REFERENCES stars (id);
```
</details>

## 3. Increase Star Name Length

### Challenge:

Modify the name column of the `stars` table so that it allows star names as long as 50 characters.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
ALTER TABLE stars 
ALTER COLUMN name TYPE varchar(50);
```
</details>

## 4. Stellar Distance Precision

### Challenge:

Modify the distance column in the `stars` table so that it allows fractional light years to any degree of precision required.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;
```
</details>

## 5. Check Values in List

### Challenge:

Add a constraint to the table `stars` on the `spectral_type` column that will enforce the requirement that a row must hold one of the 7 listed values: 'O', 'B', 'A', 'F', 'G', 'K', and 'M'. Also, make sure that a value is required for this column.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
ALTER TABLE stars
ALTER COLUMN spectral_type SET NOT NULL,
ADD CONSTRAINT spectral_type_check CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));
```
</details>