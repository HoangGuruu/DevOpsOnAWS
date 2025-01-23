# 2.9 Cài đặt database postgres, mysql trên EC2 Ubuntu

```sh
# Connect to RDS Posrgres
PGPASSWORD= psql -h localhost -p 5435 -U postgres -d database_name
```

# PostgreSQL
1. Install PostgreSQL
First, update your package list and install PostgreSQL:

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```
2. Start and Enable PostgreSQL Service
Ensure the PostgreSQL service is running and enabled to start on boot:

```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```
3. Access PostgreSQL
Switch to the postgres user and open the PostgreSQL prompt:

```bash
sudo -i -u postgres
psql
```
4. Create a Database
To create a new database, use the CREATE DATABASE statement:

```sql
CREATE DATABASE mydatabase;
```
5. Create a User (Optional)
If you want to create a new user, you can do so with:

```sql
CREATE USER myuser WITH PASSWORD 'mypassword';
```
6. Grant Privileges to the User (Optional)
Grant all privileges on the database to the user:

```sql
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;
```
7. Connect to the Database
Connect to the specific database:

```bash
\c mydatabase
```
8. Create a Table
To create a table, use the CREATE TABLE statement:

```sql
CREATE TABLE mytable (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
```
9. Show Databases
To list all databases:

```sql
\l
```
10. Show Tables
To list all tables in the current database:

```sql
\dt
```
11. Insert Data into Table
To insert data into a table:

```sql
INSERT INTO mytable (name, age) VALUES ('Alice', 30), ('Bob', 25);
```
12. Select Data from Table
To select all data from a table:

```sql
SELECT * FROM mytable;
```
13. Exit the PostgreSQL Prompt
To exit the PostgreSQL prompt:

```sql
\q
```
14. Delete table
```css
\c mydatabase
DROP TABLE mytable;
```
15. Delete database
```css
DROP DATABASE mydatabase;
```
