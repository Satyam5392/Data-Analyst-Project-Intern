###                      EMPLOYEE DEPARTMENT ANLYSIS
------------------------------------------------------------
CREATE DATABASE SQLPROJECT;
use sqlproject;
---------------------------------------------
CREATE TABLE Dept (
DeptNo int primary key ,
Dname varchar(50),
Loc varchar(50)
);
--------------------------------------------
insert into dept
values(10,'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');
---------------------------------------------------------
CREATE TABLE EMPLOYEE(
EmpNo int not null unique primary key,
Ename varchar(30),
Job varchar(30) default 'CLERK',
Mgr int,
HireDate date,
Salary decimal (10,2) check(salary>0),
Comm decimal(10,2),
DeptNo int ,
 foreign key(deptno) references dept(deptno) );
 ---------------------------------------------------------------
insert into employee(empno,ename,job,mgr,hiredate,salary,deptno)
values(7369,'SMITH','CLERK',7902,'1890-12-17',800,20);
insert into employee
values(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30);
insert into employee(empno,ename,job,mgr,hiredate,salary,deptno)
values(7566,'JONES','MANAGER',7839,'1981-04-02',2975,20);
insert into employee VALUES(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30);
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE(empno,ename,job,mgr,hiredate,salary,deptno)
values(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,20);
INSERT INTO EMPLOYEE(empno,ename,job,hiredate,salary,deptno)
values(7839,'KING','PRESIDENT','1981-11-17',5000,10);
INSERT INTO EMPLOYEE
VALUES(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMPLOYEE(empno,ename,job,mgr,hiredate,salary,deptno)
values(7876,'ADAMS','CLERK',7788,'1987-05-23',1100,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,10);
---------------------------------------------------
select ename,salary from employee where salary>1000;
-----------------------------------------------------
select * from employee where hiredate <'1981-09-30';
-------------------------------------------------------------------
select ename from employee where ename like '_i%';
---------------------------------------------------------
select ename,salary,salary*0.4 Allowances,salary*0.1 PF from employee;
-----------------------------------------------------------------------
SELECT ename,job from employee where comm is null;
---------------------------------------------------------------------
select empno,ename,salary from employee order by salary;
-----------------------------------------------------------------------
select distinct job as jobs from employee;
---------------------------------------------------
select sum(salary) as salary,job from employee group by job having job = 'salesman';
------------------------------------------------------------------------------------
select round(avg(salary)/12) as salary,job from employee group by job;
-------------------------------------------------------------------------
select ename,salary,dname from employee join dept on employee.deptno = dept.deptno;
-----------------------------------------------------------------------------------
create table job_grades(
grade varchar(10),
lowest_sal int,
highest_sal int
);
------------------------------------------------------------------
insert into job_grades
values('A',0,999),
('B',1000,1999),
('C',2000,2999),
('D',3000,3999),
('E',4000,5000);
-------------------------------------------------------------------
select e.ename,e.salary,g.grade from employee e join job_grades g on e.salary between g.lowest_sal and highest_sal;
------------------------------------------------------------------
select employee.ename,m.ename from employee ,employee m where employee.mgr=m.empno;
------------------------------------------------------------------
select ename,salary+comm  'total salary' from employee;
------------------------------------------------------------
select ename,salary from employee where empno%2<>0;
select ename,salary from employee where mod(empno,2)=1;
---------------------------------------------------------------
select ename,salary,dense_rank() over(partition by job order by salary) orgrank,dense_rank()
over(partition by dname order by salary) departmentrank from employee join dept on
employee.deptno = dept.deptno;
----------------------------------------------------------------
select salary ,ename from employee order by salary desc limit 3;
-------------------------------------------------------------------------
select max(salary) 'highest salary',job from employee group by job;
-----------------------------------------------------------------------
##              ORDERS COST  SALESPEOPLE
-------------------------------------------------------------------------
CREATE TABLE SALESPEOPLE(
Snum int,
Sname varchar(50),
City varchar(50),
Comm dec(4,2)
);
-----------------------------------------------------------------------------
INSERT INTO SALESPEOPLE
VALUES(1001,'Peel','London',0.12),
(1002,'Serres', 'San Jose',0.13),
(1003,'Axelrod','New York',0.10),
(1004,'Motika','London',0.11),
(1007,'Rafkin','Barcelona',0.15);
--------------------------------------------------------------------------------
select * from salespeople;
-------------------------------------------------------------------------------
create table customer(
Cnum int,
Cname varchar(30),
City varchar(30),
Rating int,
Snum int
);
-----------------------------------------------------------------------------------
insert into customer
values(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Pereira','Rome',100,1004),
(2008,'James','London',200,1007);
---------------------------------------------------------------------------------------
select * from customer;
----------------------------------------------------------------------------------
CREATE TABLE orders(
Onum int,
Amt decimal (8,2),
Odate date,
Cnum int,
Snum int
);
--------------------------------------------------------------------------------------
insert into orders
values(3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);
---------------------------------------------------------------------------------
select * from orders;
------------------------------------------------------------------------------------
select sname as 'SALES PEOPLE' ,customer.cname as 'CUSTOMER NAME',
customer.city AS 'CITY' from salespeople,customer
where salespeople.city=customer.city;
-------------------------------------------------------------------------------------------------
select salespeople.sname as 'SALESPERSON',customer.cname AS 'CUSTOMERS' from salespeople,customer
where salespeople.snum=customer.snum;
-----------------------------------------------------------------------
select salespeople.sname,customer.cname,orders.onum,salespeople.city,customer.city from salespeople,customer,orders 
where salespeople.city<>customer.city
and orders.snum=customer.snum
and orders.snum = salespeople.snum;
------------------------------------------------------------------------------------
select onum,cname from orders,customer where orders.cnum=customer.cnum;
-------------------------------------------------------------------------------------
select * from customer order by rating;
--------------------------------------------

------------------------------------------------
select s.sname,ss.sname,s.city from salespeople s,salespeople ss where s.city=ss.city;
--------------------------------------------------------------------------------------
select orders.snum,salespeople.sname,orders.cnum from orders,salespeople where orders.snum = salespeople.snum
and orders.cnum = 2008;
------------------------------------------------------------------------------------------
select * from orders where amt> (select avg(amt) from orders where odate = '1994-10-04');
-------------------------------------------------------------------------------------------
select o.onum,o.amt,o.odate,s.snum,s.sname,s.city from orders o,salespeople s where o.snum = s.snum 
and s.city = 'London';
-----------------------------------------------------------------------------------------------
select * from customer where cnum>(select snum from salespeople where sname='Serres');
---------------------------------------------------------------------------------------
select cnum,city,rating from customer where rating >(select avg(rating) from customer where city = 'San Jose');
--------------------------------------------------------------------------------------------
select s.snum,s.sname,c.cnum,c.cname from salespeople s,customer c where s.snum = c.snum;
------------------------------------------------------------------------------------------




