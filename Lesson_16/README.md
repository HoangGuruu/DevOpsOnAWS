![Alt text](../Banner.png)

# Bài 16 Connect tới Database và thao tác

## Connect tới database bằng cli và thao tác với database

```sh
# Connect to RDS Posrgres
PGPASSWORD=12345678a psql -h localhost -p 5435 -U postgres -d database_name
# Example
PGPASSWORD=12345678a psql -h devops-2-10.cnusie6q2fao.ap-southeast-1.rds.amazonaws.com -p 5432 -U postgres -d devops

```
## Thao tác với PostgreSQL
1. Create a Database
To create a new database, use the CREATE DATABASE statement:

```sql
CREATE DATABASE mydatabase;
```
2. Create a User (Optional)
If you want to create a new user, you can do so with:

```sql
CREATE USER myuser WITH PASSWORD 'mypassword';
```
3. Grant Privileges to the User (Optional)
Grant all privileges on the database to the user:

```sql
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;
```
4. Connect to the Database
Connect to the specific database:

```bash
\c mydatabase
```
5. Create a Table
To create a table, use the CREATE TABLE statement:

```sql
CREATE TABLE mytable (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
```
6. Show Databases
To list all databases:

```sql
\l
```
7. Show Tables
To list all tables in the current database:

```sql
\dt
```
8. Insert Data into Table
To insert data into a table:

```sql
INSERT INTO mytable (name, age) VALUES ('Alice', 30), ('Bob', 25);
```
9. Select Data from Table
To select all data from a table:

```sql
SELECT * FROM mytable;
```
10. Exit the PostgreSQL Prompt
To exit the PostgreSQL prompt:

```sql
\q
```
11. Delete table
```css
\c mydatabase
DROP TABLE mytable;
```
12. Delete database
```css
DROP DATABASE mydatabase;
```
