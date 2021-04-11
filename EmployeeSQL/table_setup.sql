DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;


CREATE TABLE titles (
	title_id VARCHAR(10) PRIMARY KEY NOT NULL,
	title VARCHAR(35) NOT NULL
);

CREATE TABLE employees (
	emp_no INTEGER NOT NULL PRIMARY KEY,
	emp_title VARCHAR(15),
	birth_date VARCHAR(15),
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	sex VARCHAR(5),
	hire_date DATE,
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

CREATE TABLE departments (
	dept_no VARCHAR(15) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(20) NOT NULL
	
);

CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(15) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager ( 
	dept_no VARCHAR(15) NOT NULL,
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);



CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	salary INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--verifying each table is there after importing
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

--1 list the details of each employee: employee number, last name, first name, sex, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, 
	employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2 List first name, last name, and hire date for employees who were hired in 1986.

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3 List the manager of each department with the following information: department number,
--department name, the manager's employee number, last name, first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no,
	employees.first_name, employees.last_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
on dept_manager.emp_no = employees.emp_no;

--4 List the department of each employee with the following information: employee number,
-- last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments 
ON dept_emp.dept_no = departments.dept_no;


--5  List first name, last name, and sex for employees whose first
-- name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6 List all employees in the Sales department, including their employee number,
-- last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--7 List all employees in the Sales and Development departments, including their
-- employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8 In descending order, list the frequency count of employee last names, i.e.,
-- how many employees share each last name

SELECT last_name,
COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

--epilogue
SELECT * 
FROM employees
WHERE emp_no = 499942;
--hmmmm