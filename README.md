# Company Database

## What is happening in the project:
This project centers around building and exploring a relational database modeled after a fictional company. I began by creating the full schema and loading all the data into the appropriate tables using a mix of SQL scripts and .dat files. My employee table only had 10 columns so had to put a dummy value in the 11th as I didn’t want to keep changing the sql files. After loading each table, I verified the results with simple SELECT queries to ensure the data was imported properly.

Once the database was ready for use, I wrote a series of SQL queries to retrieve, filter, and analyze information across the system. These included inserting new employees, sorting last names, filtering workers by department or salary, and retrieving employees tied to specific projects. Many queries required joining multiple tables to uncover relationships such as finding employees supervised by a particular manager, identifying dependents, or listing workers who contributed more than a certain number of hours to a project. I also used nested queries to locate employees in the same department as the highest‑paid worker and to gather project numbers associated with employees named “Smith.”

The project wrapped up with several data‑modification tasks. I inserted new departments with their managers and start dates, updated an employee’s birthdate, and confirmed each change with follow‑up queries. Finally, I deleted one of the newly added departments after ensuring it had no employees assigned to it, demonstrating how foreign‑key constraints affect deletion. Overall, the project provided a full end‑to‑end experience with SQL from building the schema to performing meaningful analysis and updates across a connected set of tables.

# - More Information -

## What is inside each of the source files:
There are three files for each table in this directory. For example for the
DEPARTMENT table the three files are: 

<ol>
<li> department.sql: contains the SQL Create Table statement to create the table.
<li> department.dat: contains data for the table to be loaded using the MySQL load command.
<li> load-department.sql: contains the LOAD command to load data into the table.
</ol>

<P>
The file, source.sql, contains MySQL "source" commands to execute the "create table" and
"load" commands for each table.

<P>
After signing in to MySQL and changing to "company" database, simply run the following
command to create and populate the tables:

<P>
mysql> source source.sql
