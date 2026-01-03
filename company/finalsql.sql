
/*
Martin Ljuljduraj
*/

USE company;


/*
Question 1:  Write an insert statement to add your name 
(the name you have listed on CUNYfirst) to the employee table. 
For the SSN field, please make up a made-up fake SSN such 
as 123456789. DO NOT USE your real SSN. 
You can choose any department you want for your information.

Your query for question 1 should go below after the comment
*/

INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, dno) 
VALUES ('Martin', 'L', 'Ljuljduraj', '999999999', '1905-05-01', '123 Bronx Ave, NY', 'M', 90000, 1);


/*
Question 2:
Retrieve all last names of all employees ordered alphabetically by last name.
Your query for question 2 should go below after the comment
*/

SELECT lname from employee
ORDER BY lname ASC;

/*
Question 3:
Retrieve the names of all employees in department 5 who work 
more than 10 hours per week on the ProductX project.
*/

SELECT e.fname, e.minit, e.lname
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber
WHERE e.dno = 5
  AND p.pname = 'ProductX'
  AND w.hours > 10;

/*
Question 4:
Retrieve all employees in department 5 whose salary is 
between $25,000 and $45,000.
*/

SELECT * /* asterisk (*), which stands for all the attributes */
FROM employee
WHERE dno = 5
  AND salary BETWEEN 25000 AND 45000;

/*
Question 5:
Retrieve the birth date and address of the employee(s) 
whose name is ‘Joyce A English’. 
*/

SELECT bdate, address
FROM employee
WHERE fname = 'Joyce'
  AND minit = 'A'
  AND lname = 'English';

/*
Question 6:
List the names of all employees who have a dependent with 
the same first name as themselves.
*/

SELECT e.fname, e.minit, e.lname
FROM employee e
JOIN dependent d ON e.ssn = d.essn
WHERE e.fname = d.dependent_name;

/*
Question 7: Find the names of all employees who are directly 
supervised by ‘Franklin Wong’
*/

SELECT e.fname, e.minit, e.lname
FROM employee e
JOIN employee s ON e.superssn = s.ssn
WHERE s.fname = 'Franklin'
  AND s.lname = 'Wong';

/*
Question 8: For each department whose average employee 
salary is more than $30,000, retrieve the department name 
and the number of employees working for that department.
*/

SELECT d.dname, COUNT(e.ssn) AS num_employees
FROM department d
JOIN employee e ON d.dnumber = e.dno
GROUP BY d.dname
HAVING AVG(e.salary) > 30000;

/*
Question 9: Retrieve the number of male employees in each 
department making more than $30,000.
*/

SELECT d.dname, COUNT(e.ssn) AS num_male_employees
FROM employee e
JOIN department d ON e.dno = d.dnumber
WHERE e.sex = 'M'
  AND e.salary > 30000
GROUP BY d.dname;

/*
Question 10: Retrieve the names of all employees who work in 
the department that has the employee with the highest salary 
among all employees.
*/

SELECT fname, minit, lname
FROM employee
WHERE dno = (
  SELECT dno
  FROM employee
  WHERE salary = (
    SELECT MAX(salary)
    FROM employee
  )
);

/*
Question 11: Retrieve the names of all employees who are 
supervised by an employee with ssn of ‘888665555’
*/

SELECT fname, minit, lname
FROM employee
WHERE superssn = '888665555';

/*
Question 12: Show the resulting salaries if every employee 
working on the ‘ProductY’ project is given a 15% raise.
*/

SELECT e.fname, e.minit, e.lname,
       e.salary,
       ROUND(e.salary * 1.15, 2) AS raised_salary
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber
WHERE p.pname = 'ProductY';

/*
Question 13: Retrieve the name and address of all employees 
who work for the 'Headquarters' department.
*/

SELECT e.fname, e.minit, e.lname, e.address
FROM employee e
JOIN department d ON e.dno = d.dnumber
WHERE d.dname = 'Headquarters';

/*
Question 14: Update the birth date of the employee whose ssn 
is '123456789' to '1965-01-08'
*/

UPDATE employee
SET bdate = '1965-01-08'
WHERE ssn = '123456789';

/*
Question 15: For every project located in ‘Stafford’, list 
the project number, the controlling department number, and 
the department manager’s last name, address, and birth date.
*/

SELECT p.pnumber, p.dnum, e.lname, e.address, e.bdate
FROM project p
JOIN department d ON p.dnum = d.dnumber
JOIN employee e ON d.mgrssn = e.ssn
WHERE p.plocation = 'Stafford';

/*
Question 16: For each employee, retrieve the employee’s first 
and last name and the first and last name of his or her 
immediate supervisor.
*/

SELECT e.fname AS employee_fname,
       e.lname AS employee_lname,
       s.fname AS supervisor_fname,
       s.lname AS supervisor_lname
FROM employee e
LEFT JOIN employee s ON e.superssn = s.ssn;

/*
Question 17: List all project numbers for projects that 
involve an employee whose last name is ‘Smith’, either as a 
worker or as a manager of the department that controls the project
*/

/* This code gives an error, looking only for 'Smith' last name 
SELECT DISTINCT p.pnumber
FROM project p
JOIN department d ON p.dnum = d.dnumber
JOIN employee e ON d.mgr_ssn = e.ssn
WHERE e.lname = 'Smith'
*/

/* Correct code */

SELECT DISTINCT p.pnumber
FROM project p
JOIN department d ON p.dnum = d.dnumber
JOIN employee e ON d.mgrssn = e.ssn
WHERE e.lname = 'Smith'
     
UNION
    
SELECT DISTINCT p.pnumber
FROM project p
JOIN works_on w ON p.pnumber = w.pno
JOIN employee e ON w.essn = e.ssn
WHERE e.lname = 'Smith';

/*
Question 18: Retrieve a list of employees and the projects 
they are working on, ordered by department and, within each 
department, ordered alphabetically by last name, then first name
*/

SELECT e.dno,
       e.lname,
       e.fname,
       p.pname,
       p.pnumber
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber
ORDER BY e.dno, e.lname, e.fname;

/*
Question 19: Write a query to insert the following new departments
*/

/* Write this first to make sure the employees exists */
SELECT ssn, fname, lname
FROM employee
WHERE ssn IN ('666666601', '987654321', '444444402', '666666602', '666666600');

/* Insert the new departments */
INSERT INTO department (dname, dnumber, mgrssn, mgrstartdate)
VALUES 
  ('Marketing', 11, '666666601', '2000-07-22'),
  ('Human Resources', 12, '987654321', '2010-04-02'),
  ('Finance', 13, '444444402', '2012-07-12'),
  ('Operations', 14, '666666600', '2024-05-22'),
  ('Customer Service', 15, '666666600', '2020-05-22');

/* Shows all the new departments */
SELECT * FROM department WHERE dnumber IN (11, 12, 13, 14, 15);

/* 
Question 20: Write a query to delete the ‘Operations’ department.
*/

SELECT * FROM department WHERE dname = 'Operations';