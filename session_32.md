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
SELECT * FROM campusx.smartphones WHERE price > 9999 AND price < 20001;
```

As here < > will exclude the number we gave in the range whereas between will include whlie provinding the answer.

### Comments in mysql --

```sql
-- Commnet In SQL
```

### Query Execution Order

![1749625343403](image/session_32/1749625343403.png)

### IN and NOT IN

x
