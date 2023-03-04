create database Employees;
use employees;

create table employee(
    ID INT NOT NULL,
    birth_date DATE  NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name  VARCHAR(16) NOT NULL,
    gender     ENUM ('M','F') NOT NULL,    
    hire_date  DATE NOT NULL,
    PRIMARY KEY (ID) 
    );
    
create table title(
 employeeID int not null,
 title varchar(50) not null,
 from_date date not null,
 to_date date,
 PRIMARY KEY (employeeID),
 FOREIGN KEY (employeeID) REFERENCES employee(ID)
    );
    
CREATE TABLE salary (
    employeeID      INT    NOT NULL,
    amount      decimal (10,2)   NOT NULL,
    from_date   DATE   NOT NULL,
    to_date     DATE   NOT NULL,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES employee(ID)
    );
  
CREATE TABLE department (
    dept_ID char(4) NOT NULL,
    dept_name varchar(40) Not null,
    PRIMARY KEY (dept_ID)
    );  
 
CREATE TABLE department_employee (
    employeeID      INT    NOT NULL,
    departmentID char(4) not null,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES employee(ID),
    FOREIGN KEY (departmentID) REFERENCES department(dept_ID)
    );   
    
CREATE TABLE  department_manager (
    employeeID      INT    NOT NULL,
    departmentID char(4) not null,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES employee(ID),
	FOREIGN KEY (departmentID) REFERENCES department(dept_ID)

    );
    
    
INSERT INTO employee (ID, birth_date, first_name, last_name, gender, hire_date) 
VALUES 
(1, '1995-03-15', 'John', 'Smith', 'M', '2020-08-15'),
(2, '1998-11-02', 'Jane', 'Doe', 'F', '2021-01-12'),
(3, '1992-07-23', 'Bob', 'Johnson', 'M', '2021-06-24'),
(4, '1994-04-08', 'Sara', 'Lee', 'F', '2022-02-28'),
(5, '1999-09-14', 'David', 'Kim', 'M', '2022-07-16'),
(6, '1993-01-20', 'Maria', 'Garcia', 'F', '2021-04-18'),
(7, '1997-06-05', 'Alex', 'Chen', 'M', '2020-11-08'),
(8, '1991-12-18', 'Emily', 'Jones', 'F', '2021-03-31'),
(9, '1996-02-11', 'Daniel', 'Nguyen', 'M', '2021-09-02'),
(10, '1990-10-27', 'Amy', 'Wong', 'F', '2022-05-14');

INSERT INTO employee(ID, birth_date, first_name, last_name, gender, hire_date) VALUES
    (11, '1998-08-03', 'Peter', 'Zhang', 'M', '2022-10-09'),
    (12, '1992-05-29', 'Linda', 'Kim', 'F', '2023-01-20'),
    (13, '1994-12-17', 'Tom', 'Brown', 'M', '2020-12-23'),
    (14, '1997-03-21', 'Sophia', 'Davis', 'F', '2021-07-28'),
    (15, '1993-11-01', 'Chris', 'Hernandez', 'M', '2021-10-01'),
    (16, '1995-09-09', 'Emma', 'Wilson', 'F', '2022-03-11'),
    (17, '1991-04-04', 'Josh', 'Gomez', 'M', '2022-08-22'),
    (18, '1996-07-16', 'Olivia', 'Rodriguez', 'F', '2021-11-05'),
    (19, '1990-12-05', 'Adam', 'Lee', 'M', '2020-09-05'),
    (20, '1999-02-28', 'Ava', 'Martinez', 'F', '2021-02-03'),
    (21, '1992-10-10', 'Mike', 'Nguyen', 'M', '2021-08-07'),
    (22, '1994-06-19', 'Sarah', 'Garcia', 'F', '2022-01-19'),
    (23, '1997-01-03', 'Jason', 'Chen', 'M', '2022-06-10'),
    (24,'1993-08-28', 'Karen', 'Kim', 'F','2023-02-23'),
    (25,'1995-05-12', 'Kevin', 'Jones', 'M','2020-10-20');

insert into title(employeeID, title, from_date, to_date)
values
(1, 'Senior Engineer', '2020-08-15', '2022-09-07'),
(2, 'Engineer', '2021-01-12', '2023-01-25'),
(3, 'Staff', '2021-06-24', '2022-06-29'),
(4, 'Engineer', '2022-02-28', NULL),
(5, 'Staff', '2022-07-16', NULL),
(6, 'Staff', '2021-04-18', NULL),
(7, 'Senior Engineer', '2020-11-08', NULL),
(8, 'Engineer', '2021-03-31', NULL),
(9, 'Staff', '2021-09-02', NULL),
(10, 'Engineer', '2022-05-14', NULL),
(11, 'Staff', '2022-10-09', NULL),
(12, 'Engineer', '2023-01-20', NULL),
(13, 'Senior Engineer', '2020-12-23', NULL),
(14, 'Engineer', '2021-07-28', NULL),
(15, 'Engineer', '2021-10-01', NULL),
(16, 'Staff', '2022-03-11', NULL),
(17, 'Engineer', '2022-08-22', NULL),
(18, 'Engineer', '2021-11-05', NULL),
(19, 'Senior Engineer', '2020-09-05', NULL),
(20, 'Staff', '2021-02-03', NULL),
(21, 'Engineer', '2021-08-07', NULL),
(22, 'Engineer', '2022-01-19', NULL),
(23, 'Engineer', '2022-06-10', NULL),
(24, 'Staff', '2023-02-23', NULL),
(25, 'Senior Engineer', '2020-10-20', NULL);

INSERT INTO salary (employeeID, amount)
VALUES
  (1, 7000.00),
  (2, 5200.00),
  (3, 5100.00),
  (4, 5250.00),
  (5, 5300.00),
  (6, 4500.00),
  (7, 7200.00),
  (8, 4800.00),
  (9, 4900.00),
  (10, 5000.00),
  (11, 6000.00),
  (12, 6100.00),
  (13, 7100.00),
  (14, 6250.00),
  (15, 6300.00),
  (16, 5500.00),
  (17, 5600.00),
  (18, 5700.00),
  (19, 7250.00),
  (20, 5900.00),
  (21, 4000.00),
  (22, 5200.00),
  (23, 6000.00),
  (24, 5050.00),
  (25, 7300.00);

INSERT INTO department (dept_ID, dept_name)
VALUES
('D01', 'Development'),
('D02', 'Finance'),
('D03', 'Marketing'),
('D05', 'Human Resources'),
('D04', 'Customer Service');

INSERT INTO department_employee (employeeID, departmentID)
VALUES
(1, 'D01'),
(2, 'D03'),
(3, 'D02'),
(4, 'D05'),
(5, 'D04'),
(6, 'D02'),
(7, 'D01'),
(8, 'D04'),
(9, 'D05'),
(10, 'D01'),
(11, 'D04'),
(12, 'D01'),
(13, 'D04'),
(14, 'D01'),
(15, 'D01'),
(16, 'D03'),
(17, 'D01'),
(18, 'D01'),
(19, 'D01'),
(20, 'D02'),
(21, 'D01'),
(22, 'D01'),
(23, 'D01'),
(24, 'D03'),
(25, 'D01');

insert into department_manager (employeeID, departmentID)
values
(25, 'D01'),
(20, 'D02'),
(16, 'D03'),
(13, 'D04'),
(4, 'D05');

select * from employee
limit 5;

select * from title
limit 5;

select * from salary
limit 5;

select * from department
limit 5;

select * from department_employee;

select * from department_manager;


