--creating tables
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(6),
	birth_date DATE,
	first_name VARCHAR(40),
	last_name VARCHAR(40),
	sex VARCHAR(1),
	hire_date DATE
);

CREATE TABLE departments(
	dept_no VARCHAR(6) PRIMARY KEY,
	dept_name VARCHAR(25) 
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(6),
	emp_no INT PRIMARY KEY
);

CREATE TABLE dept_emp(
	emp_no INT PRIMARY KEY,
	dept_no VARCHAR(6)
);

CREATE TABLE titles(
	title_id VARCHAR(6) PRIMARY KEY,
	title VARCHAR(30)
);

CREATE TABLE salaries(
	emp_no INT PRIMARY KEY,
	salary INT
);

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
FULL OUTER JOIN salaries
ON employees.emp_no = salaries.emp_no);

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees 
WHERE employees.hire_date > '1986-01-01' AND employees.hire_date < '1987-01-01';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name
FROM dept_manager
JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no;


--Inserted to prevent error where it did not allow insert a duplicate value into the primary key column of the dept_emp table.
ALTER TABLE dept_emp DROP CONSTRAINT dept_emp_pkey;


--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';


--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT employees.last_name, 
COUNT(employees.last_name) as total_last_name
FROM employees
GROUP BY employees.last_name
ORDER BY total_last_name DESC;