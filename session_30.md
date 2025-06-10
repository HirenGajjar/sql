### Data

Everything is data. Data is oil.

Computer evoulution speeded up the generation of data, internet make data accessible anywhere anytime. AI is the reflection of the data generated, stored and process. That is why databases and sql are still relevent.

DB are software that stores the data in rational and logical way that helps perfrom operations on data to achieve business goals.

CRUD is all we do in DB. There can be fancy names - but under the hood it is CRUD.

### **Properties of DB.**

1. Integrity - Accuracy + Consistency
2. Availability - 24 x 7 x 365
3. Security
4. Independent - Any data and DB should be independent of application and devices.
5. Concurrancy - Parallely able to serve N numbers of request.

### **Types of DB.**

1. Relational - Most common - RDBMS - SQLDB - rows + cols + tables + Relation
2. NoSQL - Not Only SQL - Docs, Images, Videos etc. MongoDB
3. Column DB - Storing data in cols - well suitable for warehousing and analysis. (At 40:00 Session - 30 DB Fundamental)
   - https://dataschool.com/data-modeling-101/row-vs-column-oriented-databases/
4. Graph DB - it stores graph structured data like - social connection - FB uses it. Recommendation systems. Neo4J.
5. Key-value DB -Good for cashing, handle small quick task. Twitter shows person and his followers, following and number of twits.

Just because large famouse compnies uses certain type of DBs that does not make it great choice for your application. Always take a moment and thought to choose wisely.

### **Relational Model.**

Relation is an idea, theoritical concept and mathematical represnt of Tables. Tables are practical implimentaiton of relations. Both can be used interchanbly.
Tables === Relation === collection of rows and columns

Columns - attributes/ fields
Number of attributes called as DEGREE OF THE RELATION

Rows - tuples / records
Number of rows know as - CARDINALITY of the relation

Missing - empty values are called NULL

What kind of data and data type is stored in perticular column is called DOMAIN.

### **DBMS.**

A DBMS is an interface and intermediate platform between user and user's data, which is a software that allows to perform CRUD operations.

Data is stored on Hardware - Hardware is access by OS - DBMS is connection between user and OS. OS is connection between Hardware and user.

_Data managemnt, Integrity (acuraccy), security (authority etc),Concurrency (handle N number of requests and maintain data accuracy), Transcation (Either modification are completed or not triggered at all), Utilites(Data import export, user managment, backps, logging etc)._

### **Database Keys.**

https://www.geeksforgeeks.org/types-of-keys-in-relational-model-candidate-super-primary-alternate-and-foreign/

**Key -** it is an attribute or set of attributes that uniquely identifies a specific row/tuple in a table.
Basically something in a each row that is completly uniuqe in that table.
Helps maintaining integrity and reliability.

Keys help maintaining data uniqueness, integrity, Effective data retrival

1. Super key - combination of columns to identify perticular row.
2. Candidate key - a way to identify a row uniquly with minimum combination of attributes without redundant attribute(something that is not needed or useful)
3. Primary key - The one and only unique key that is totally unique to identify that row in table that has no null value. NOT NULL. NO DUPLICATE. Prefered is small, numerical, constant.
4. Alternate key - second prefered primary key
5. Composite key - A combo of two or more attributes.
6. Surrogate key - certain situations that has no combination that can be a key so we add new column that acts as a Surrogate key. (Primary key in majboori)
7. Foreign Key - A primary key in one table being used in another one known as a foreign key.
8. Compound Key

### **Cardinality of Relationship.**

Entity - something that we can make a table like name , number or email etc.

Entities of one table can connect to entities of another table - that occurance of relation - the number is known as a cardinality.

1-1 : Me and my DNA
Need only One table to store such cardinality

1-Many : One blog -million readers
Two tables needed to store such cardinality

Many-Many : Many blogs have millions readers
Need 3 tables to store such cardinality

### **Drawbacks of DB**

Complex, Expensive, Scalability (Exponentional), Data integrity, Security, Data Migration, Flexibility.
