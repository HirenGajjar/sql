### CRUD

DML commands

1. Create Data - using INSERT - single value or multiple values - In order or without order
   If you want to add values in any order then make sure you provice all the values for each column, similarly we can provide specific values only by providing specific column names in syntax
2. Read Data - SELECT
3. Update Data
4. Delete Data

### Import

**Mostly SELECT filters columns, WHERE filters rows.**

```sql
SELECT * FROM campusx.smartphones WHERE 1;
```

```sql
SELECT * FROM cmapusx.smartphones;
```

```sql
SELECT * FROM campusx.smartphones WHILE TRUE;
```

How to import data ?

rename the columns using AS

```sql
SELECT model FROM campusx.smartphones;
```

```sql
SELECT model,os AS "Operating System" FROM campusx.smartphones;
```

### ALIAS

Add constant valued column

```sql
SELECT
model AS "Device Name",
SQRT((resolution_widht * resolution_widht ) + (resolution_height * resolution_height)) / screen_size AS "PPI of Device"
FROM campusx.smartphones;
```

### Constants

Here we created a new column With name of Type that has value of Smart Phone in each row. A constant Column.

```sql
SELECT model, "Smart Phone" AS "Type" FROM campus.smartphones;
```

### DISTINCT

Find Unique values from a column

```sql
SELECT DISTINCT(brand_name) AS "UNIQUE BRANDS" FROM campusx.smartphones;
```

```sql
SELECT DISTINCT(processor_brand) AS "UNIQUE PROCESSOR" , price FROM campusx.smartphones;
```

```sql
SELECT DISTINCT(os) AS "OPERATING SYSTEM" FROM campusx.smartphones;
```

Distinct Combo

```sql
SELECT DISTINCT brand_name , processor_brand FROM campusx.smartphones;
```

### WHERE

Filtering Rows based on conditions

Q. Find All the Models where brand name is samsung

```sql
SELECT model FROM campusx.smartphones WHERE brand_name = "samsung";
```

!. Find me all the phones above 50K INR ?

```sql
SELECT model , price FROM campusx.smartphones WHERE price > 50000;
```

### BETWEEN

Q. Find all the phones between 10K to 20K INR ?

```sql
SELECT * FROM campusx.smartphones WHERE price BETWEEN 10000 AND 20000;
```

Same question can be solved using following query

```sql
SELECT *
FROM campusx.smartphones
WHERE price > 9999
AND price < 20001;
```

As here < > will exclude the number we gave in the range whereas between will include whlie provinding the answer.

### Comments in mysql --

```sql
-- Commnet In SQL
```

### Query Execution Order

**FJWGHSDO**

![1749625343403](image/session_32/1749625343403.png)

### IN and NOT IN

Q. Find me smartphones which has processor of snapdragon ,exynos and bionic ? - It can be done with OR operaiton or IN function.

```sql
SELECT *
FROM campusx.smartphones
WHERE processor_brand = "snapdragon"
OR processor_brand = "exynos"
OR processor_brand = "bionic";
```

Using IN

```sql
SELECT *
FROM cammpusx.smartphones
WHERE processor_brand IN ("snapdragon","exynos","bionic");
```

Q. Give me phone that deoes not use the processor of snapdragon ,exynos and bionic ?

```sql
SELECT *
FROM campusx.smartphones
WHERE processor_brand
NOT IN ("snapdragon","exynos","bionic");
```

## UPDATE

As we know Dimonsity makes mediatek processors - now we want consistency to make all the mediatek to Dimonsity.

_Update is for data and alter for structure/schema_

## DELETE

Delete the selected / conditioned rows.

## Functions

There are two types of function.

1. Build in
   1. Scaler - It works on each row like - Round
   2. Aggregate/Summary - Works on whole column to give summary - like Ave, Min ,Max etc
2. User define

---

### Aggregate Functions

#### Max - Min

Find the max porced phone and min priced phone.

```sql
SELECT MAX(price)
FROM campusx.smartphones;

SELECT MIN(price)
FROM campusx.smartphones;
```

Find Max ram and Min ram Phones ?

```sql
SELECT MAX(ram_capacity)
FROM campusx.smartphones;

SELECT MIN(ram_capacity)
FROM campusx.smartphones;
```

Find Most expensive phone from Samsung

```sql
SELECT MAX(price)
FROM campusx.smartphones
WHERE brand_name = "samsung";
```

#### AVG

Find the Average rating of apple phones

```sql
SELECT AVG(rating)
FROM campusx.smartphones
WHERE brand_name = "apple";
```

#### Count

```sql
SELECT COUNT(*)
FROM campusx.smartphones
WHERE brand_name = "oneplus";
```

#### Count - Distinct

Find the number of unique brands of phone

To find eahc brand that is unique we can use only Distinct

```sql
SELECT DISTINCT(brand_name)
FROM campusx.smartphones;
```

But to find the count of total unique brands we can use count

```sql
SELECT COUNT(DISTINCT(brand_name))
FROM campusx.smartphones;
```

Similarly Find the number of unique number of processor brands

```sql
SELECT COUNT(DISTINCT(processor_brand))
FROM campusx.smartphones;

```

#### Standard Deviation

Find the standard deviation for screen size

```sql
SELECT STD(screen_size)
FROM campusx.smartphones;
```

#### Variance

```sql
SELECT VARIANCE(screen_size)
FROM campusx.smartphones;
```

Q. Find the vairance of xiaomi phone price

```sql
SELECT VARIANCE(price)
FROM campusx.smartphones
WHERE brand_name = "xiaomi";
```

### Scaler Function

#### Absolute

Q. Subtract the price of all the phones by 100,000 and then try to make ABS

Lets subtract from 100,000

```sql
SELECT price - 100000
FROM campusx.smartphones;
```

Now Get the absolute

```sql
SELECT ABS(price - 100000)
FROM campusx.smartphones;
```

#### Round

Q. Get the PPI of each phone and make it round with 3 decimal places and model name

```sql
SELECT model,
ROUND(SQRT(resolution_width * resolution_width + resolution_height * resolution_height) / screen_size AS "PPI", 3)
FROM campusx.smartphones;
```

#### CEIL and FLOOR - Next immediate Int and Previous Immediate Int

Q. Find ceil and floor values for screen size

```sql
SELECT
CEIL(scree_size)
FROM campusx.smartphones;

SELECT
FLOOR(scree_size)
FROM campusx.smartphones;
```

---

---

# Practice Questions

Q. Find the average battery capacity and the average primary rear camera resolution for all smartphone where the price is >= 100000.

```sql
SELECT
AVG(battery_capacity)
AS "Battery Capacity",
AVG(primary_camera_rear)
AS "Rear Camera Resolution"
FROM campusx.smartphones
WHERE price >= 100000;
```

Q. Find the average internal memory capacity of smartphones that have a refresh rete of 120hz or higher and a front camera resolution is >= 20 megapixels.

```sql
SELECT
AVG(internal_memory)
AS "Storage"
FROM campusx.smartphones
WHERE refresh_rate >= 120
AND primary_camera_front >= 20;
```

Q. Find the 5G compactibility phones.

```sql
SELECT COUNT(*)
FROM campusx.smartphones
WHERE has_5g = "True";
```
