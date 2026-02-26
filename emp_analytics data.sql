create database employee_analytics_db;
use	 employee_analytics_db;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    hire_date DATE,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


INSERT INTO departments VALUES
(1, 'HR', 'Delhi'),
(2, 'IT', 'Bangalore'),
(3, 'Sales', 'Mumbai'),
(4, 'Finance', 'Pune'),
(5, 'Marketing', 'Hyderabad'),
(6, 'Operations', 'Chennai');


INSERT INTO employees VALUES
(101, 'Amit', 2, 60000, '2021-01-10', NULL),
(102, 'Riya', 1, 45000, '2020-03-15', 101),
(103, 'John', 2, 75000, '2019-07-22', 101),
(104, 'Sara', 3, 50000, '2022-05-01', 105),
(105, 'David', 3, 90000, '2018-11-11', NULL),
(106, 'Neha', 4, 65000, '2018-09-09', 110),
(107, 'Raj', 2, 80000, '2017-12-25', NULL),
(108, 'Pooja', 1, 47000, '2023-02-14', 102),
(109, 'Karan', 5, 52000, '2021-06-18', 115),
(110, 'Meena', 4, 88000, '2016-04-30', NULL),
(111, 'Arjun', 6, 40000, '2022-01-12', 118),
(112, 'Sneha', 5, 61000, '2020-10-10', 115),
(113, 'Rahul', 2, 72000, '2019-03-03', 107),
(114, 'Anita', 3, 58000, '2021-08-08', 105),
(115, 'Vikas', 5, 93000, '2017-05-19', NULL),
(116, 'Deepak', 6, 45000, '2023-04-01', 118),
(117, 'Priya', 1, 49000, '2022-09-09', 102),
(118, 'Mohit', 6, 87000, '2016-12-12', NULL),
(119, 'Nisha', 4, 67000, '2020-02-20', 110),
(120, 'Varun', 3, 61000, '2019-11-11', 105),
(121, 'Tina', 2, 54000, '2021-03-03', 107),
(122, 'Rohit', 5, 76000, '2018-08-08', 115),
(123, 'Simran', 1, 52000, '2020-06-06', 102),
(124, 'Yash', 4, 71000, '2019-01-01', 110),
(125, 'Kavya', 6, 48000, '2023-07-07', 118),
(126, 'Manish', 3, 83000, '2017-02-14', 105),
(127, 'Payal', 5, 59000, '2021-12-12', 115),
(128, 'Gaurav', 2, 91000, '2016-10-10', NULL),
(129, 'Isha', 1, 43000, '2022-11-11', 102),
(130, 'Harsh', 4, 77000, '2018-03-21', 110);

