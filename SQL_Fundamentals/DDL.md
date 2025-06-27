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

<br>

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

<br>

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

<br>

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

<br>

## 6. Enumerated Types

### Challenge:

Modify the `stars` table to remove the CHECK constraint on the `spectral_type` column, and then modify the `spectral_type` column so it becomes an enumerated type that restricts it to one of the following 7 values: 'O', 'B', 'A', 'F', 'G', 'K', and 'M'.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
CREATE TYPE spectral_type_enum AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
DROP CONSTRAINT spectral_type_check;

ALTER TABLE stars
ALTER COLUMN spectral_type TYPE spectral_type_enum
                           USING spectral_type::spectral_type_enum;
```
</details>

<br>

## 7. Planetary Mass Precision

### Challenge:

Modify the `mass` column in the `planets` table so that it allows fractional masses to any degree of precision required. 
In addition, make sure the `mass` is required and positive. Finally, make the `designation` column required.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
ALTER TABLE planets
ALTER COLUMN mass SET NOT NULL,
ALTER COLUMN mass TYPE numeric,
ADD CHECK (mass > 0);

ALTER TABLE planets
ALTER COLUMN designation SET NOT NULL;
```
</details>

<br>

## 8. Add a Semi-Major Axis Column

### Challenge:

Add a `semi_major_axis` column for the semi-major axis of each planet's orbit; the semi-major axis is the average distance from the planet's star as measured in astronomical units _(1 AU is the average distance of the Earth from the Sun)_. Use a data type of numeric, and require that each planet have a value for the semi_major_axis.


### Solution:

<details><summary>Click to Reveal</summary>

```sql
ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;
```
</details>

<br>

## 9. Add a Moons Table

### Challenge:

1. Add a `moons` table to the `extrasolar` database. The table should include the following data:

    - `id`: a unique serial number that auto-increments and serves as a primary key for this table.
    - `designation`: the designation of the moon. We will assume that moon designations will be numbers, with the first moon discovered for each planet being moon 1, the second moon being moon 2, etc. The designation is required.
    - `semi_major_axis`: the average distance in kilometers from the planet when a moon is farthest from its corresponding planet. This field must be a number greater than 0, but is not required; it may take some time before we are able to measure moon-to-planet distances in extrasolar systems.
    - `mass`: the mass of the moon measured in terms of Earth Moon masses. This field must be a numeric value greater than 0, but is not required.

2. Make sure you also specify any foreign keys necessary to tie each moon to other rows in the database.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
CREATE TABLE moons (
    id serial,
    designation integer NOT NULL CHECK (designation > 0),
    semi_major_axis numeric CHECK (semi_major_axis > 0.0),
    mass numeric CHECK (mass > 0.0),
    planet_id integer NOT NULL REFERENCES planets (id)
);
```
</details>

<br>

