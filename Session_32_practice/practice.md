### Perform the following queries

Q.1. Show records of 'male' patient from 'southwest' region.

```sql
SELECT *
FROM session_32.data
WHERE gender= "male"
AND region = "southwest";
```

Q.2. Show all records having bmi in range 30 to 45 both inclusive.

```sql
SELECT *
FROM sessio_32.data
WHERE bmi BETWEEN
30 AND 45;
```

Q.3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.

```sql
SELECT
MIN(bloodpressure) AS "MinBP",
MAX(bloodpressure) AS "MaxBP"
FROM sessio_32.data
WHERE diabetic = "Yes"
AND smoker = "Yes";
```

Q.4. Find no of unique patients who are not from southwest region.

```sql
SELECT
COUNT(DISTINCT(PatientID))
FROM session_32.data
WHERE region NOT IN ("southwest");
```

Q.5. Total claim amount from male smoker.

```sql
SELECT
SUM(claim)
FROM session_32.data
WHERE gender= "male"
AND smoker= "Yes";
```

Q.6. Select all records of south region.

```sql
SELECT *
FROM session_32.data
WHERE region
IN("southwest","southeast");
```

Q.7. No of patient having normal blood pressure. Normal range[90-120]

```sql
SELECT
COUNT(*)
FROM session_32.data
WHERE bloodpressure
BETWEEN 90 AND 120;
```

Q.8. No of pateint under 17 years of age having normal blood pressure as per below formula -

    - BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)

    - Note: Formula taken just for practice, don't take in real sense.

```sql
SELECT
COUNT(*)
FROM session_32.data
WHERE age < 17
AND bloodpressure
BETWEEN (80 + (age * 2)) AND ( 100 + (age * 2));
```

Q.9. What is the average claim amount for non-smoking female patients who are diabetic?

```sql
SELECT
AVG(claim)
FROM session_32.data
WHERE gender="male"
AND smoker="No"
AND diabetic = "Yes";
```

Q.10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.

```sql
UPDATE session_32.data
SET claim = 5000
WHERE PatientID = 1234;

SELECT *
FROM session_32.data
WHERE PatientID = 1234;
```

Q.11. Write a SQL query to delete all records for patients who are smokers and have no children.

```sql
DELETE
FROM session_32.data
WHERE smoker="Yes"
AND children  = 0;

SELECT *
FROM session_32.data
WHERE smoker = "Yes"
AND children = 0;
```
