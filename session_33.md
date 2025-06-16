* [ ] Sorting Data

#### DESC

#### ASC

#### Limit x,y

Here is x is offset and y is row count. So if i say LIMIT 4,3 - that means it will ignore 0,1,2,3 and from 4 it will go for 4,5,6 (4 including).

### GROUP

*We use Parent table and categorize it to child tables as many categories we have based on the requirement. And then Perfrom aggregation on them.*

We have to categorize data (by each brand name) in order to find the Each brand and total devices they offer. To do that we make each sub table that gives information for each unique brand name.

### Having

*Where is for select that is Having is for Group by.*

For our data set we have some brands that only has one or two devices and that are very expensive, so when we try to find out the most expensive phones it does not make sense to have such exceptions in output - to filter out that we use HAVING where we give condition that only give brands that have minimum of 20 Devices.

```sql
SELECT brand_name ,
COUNT (*) AS "Count",
AVG(price)
FROM campusx.smartphones
GROUP BY brand_name
HAVING Count > 20;
```
