use 
--DDL
--contrain 1-Null or not NUll       2-unique         3-check  4-Rule
select * from Empoyee
create Table Employee(
ID int Primary key,
Fname varchar(50) not null,
age  int default 23,
BD date default getdate(),)
Pnum int Foreign Key References Project(Pnum))


--driven column
Netsal as(sal+Overtime) persisted int not null default 0 
age as(year(getdate())-year(BD)) int,

--Composite Primary Key---------- 
reate Table HumanResources.Employee(
ID int Primary key,
Fname varchar(50) not null,
age  int default 23 unique,
BD date default getdate(),)
Pnum int Foreign Key References Project(Pnum)

, constraint c1 primary key(ID,Fname) --composite primary key
constraint c2 unique(age),
constraint c3 check(age>18) 
constraint c4 department(Dnum) foreign key on Emp(ID)
on delete set null on update cascade))

--add contrain to your table-----------------------------
alter table Empoyee add constraint c100 check(salary>1000)





--Copy table into another new table  with data 
select * into table2 from Empoyee
select SSN,Dnum into table3  from Empoyee
--copy table in another new table without data
select * into table4 from Empoyee where 1=2
--copy some of data from table to existing table 
insert into table2 
select * from Empoyee



--adding column 
alter table Employee add min_wieght int 
--changing data type of column
alter table Employee alter column min_wieght varchar(50)
--removing columm from table
alter table Employee drop column min_wieght
--removing table 
drop table Work
-----------------------------------------------------------------------------------
--DML Queries insert-update-delete-merge 
insert into Employee values(7,'Hamed',15,NULL,NULL)
insert into Empoyee values(7,'Khaled','tarek','M',NULL,NULL,1,4500,15)
--insert constructor multiple rows
insert into Employee(ID,Fname) values(3,'Khaled'),(4,'Tarek'),(5,'Ibrahim')
--can not insert in the same row twice 
insert into Employee(ID,Fname,Pnum) values(7,'Khaled',5),(8,'Tarek',6);


---updating values
update Employee
	set age=24,Fname='ibrahim' where id=1
update Employee 
	set age+=1
---updae values of column to make it all with null
update Employee 
	set age=NULL



-----delete all  values from table but keeping the structure
select * from Empoyee
select * from Department
delete from Employee
----- delete rows from table
delete from Employee
	where id=1
	
delete from Employee
	where id=5;

delete from Department 
	where Dname='HR';
	
--Truncate is faster than delete as delete is written in log file and you could return data with delete
--truncate will reset the identity and will begin with 1


 
-----------------------------------------------------------------------------------
--DQL Select
select * from Empoyee

select ID,Fname from Employee 

select ID,Fname,age from Employee where age>15 order by age desc

--Selecting two columns in one column
select FirstN+' '+LastN as fullName
from Empoyee 

--selct the Fname is not or equalNull
select * from Empoyee where LastN is Null
select * from Empoyee where LastN is not Null
select * from Empoyee where LastN is not Null and BD is Null

--select without duplicates on specific column with ordering from a to z
select  distinct FirstN from Empoyee

select * from Empoyee  where Gender in ('M','f')
select * from Empoyee where Gender='M' and Dnum is not NULL
select * from Employee where age>15 and age <22 
select * from Employee where age between 20 and 30 

----------------------------------------------------------------------------------
--DQL Joins 
select * from Empoyee
select * from Department
select SSN,Dname from Empoyee cross join Department ---does not allowed in BUSINESS 

select * from Empoyee 
select * from Department
insert into Department values(5,'Mangement',NULL,NULL)
---innner join -equi join
select SSN,FirstN,Dname from Empoyee,Department where Empoyee.Dnum=Department.Dnum
select SSN,FirstN,Dname from Empoyee e,Department d where e.Dnum=d.Dnum
select SSN,FirstN,Dname from Empoyee inner join Department on Empoyee.Dnum=Department.Dnum

--outer join
select SSN,FirstN,Dname from Empoyee left outer join Department on Empoyee.Dnum=Department.Dnum
select SSN,FirstN,Dname from Empoyee right outer join Department on Empoyee.Dnum=Department.Dnum
select SSN,FirstN,Dname from Empoyee full outer join Department on Empoyee.Dnum=Department.Dnum

--Self join for unary relationship
select * from Empoyee
select x.FirstN as EmpoyeeN, y.FirstN as SuperN from Empoyee x, Empoyee y where x.Superid=y.SSN

--join multi tables 
select x.FirstN,Dname,y.Superid from Empoyee x,Department d,Empoyee y where y.SSN=x.Superid and x.SSN=d.Dnum

select x.FirstN,Dname,y.Superid from Empoyee x inner join Department d
on x.SSN=d.Dnum
inner join empoyee y
on y.SSN=x.Superid 

-------------------------------------
--DML joins 
update Empoyee
	set Salary+=3000
from Empoyee e,Department d  where e.Dnum=d.Dnum and Dname='Marketing'
select * from Empoyee
update Empoyee set age=15 from Empoyee e,Department d where e.Dnum=d.Dnum and Dname='HR'; 
---------------------------------------------------------------------------------------------------------
--repalce null values 
select ISNULL(Dnum,100)  as D from Empoyee
select * from Empoyee 
--replace with two values if the first is null replace with second
select coalesce(FirstN,LastN,'No_Data') as NewDepartment from Empoyee

--------------------------------------------------------------------------------------------------------------
--select two column into one column with different data type
select FirstN+' '+Salary from Empoyee --will give error
select FirstN+' '+convert(varchar(5),Salary) from Empoyee
select FirstN+'  Department  is  '+convert(varchar(5),Dnum) from Empoyee ---6 will give you null as the department is null 
select FirstN+' '+convert(varchar(5),isnull(Dnum,0)) from Empoyee 
---the best one is 
select CONCAT(FirstN,' is ',isnull(Dnum,0)) as NewC from Empoyee
select year(getdate())
select month(getdate())
select * from Empoyee 
select FirstN from Empoyee where SUBSTRING(FirstN,0,3)='al'
--db name
select db_name()
--user use server name
select suser_name()
---top function
select top(3)* from Empoyee
select top(2) salary from Empoyee order by Salary desc
--top with ties getting the last rows similar to  the last one in your table
select top(5) with ties* from Empoyee order by Salary desc

--Global universal id  benesift in selecting random data from the table
select newid()
select *,NEWID() as Special_id from Empoyee
select top(3)* from Empoyee order by NEWID()
---------------------------------------------------------------------------------------------------------------------
--like statment start with letter 
select * from Empoyee where FirstN like 'a%' 
--end letter
select * from Empoyee where FirstN like '%a' 
--letter in any place
select * from Empoyee where FirstN like '%a%' 
--second letter
select * from Empoyee where FirstN like '_a%' 
--start with a or h or m statement for mulit letter to begin with
select * from Empoyee where FirstN='[ahm]%'
--not start with a or h or m statement for mulit letter to begin with
select * from Empoyee where FirstN='[^l]%'
---range or for letter 
select * from Empoyee where FirstN='[a-h]%'
--string ending with perecent simple
select * from Empoyee where FirstN='%[%]'
--the first and last are underscore
select * from Empoyee where FirstN='[_]%[%]'


-----------------------------------------------------------------------------------------------
--order by 
select * from Empoyee
select * from Empoyee order by 6 asc,age asc;
------------------------------------------------------------------------------------------------------------
--Aggregate function
select sum(salary) from Empoyee
select MIN(salary),MAX(salary) from Empoyee
select count(*) from Empoyee 
select count(FirstN) from Empoyee
select avg(salary) from Empoyee
----
select FirstN,MIN(salary) from Empoyee --will give you error due to the non uniform aggregate so you should apply group by
select Min(salary),Dnum from Empoyee group by  Dnum
----- where in aggregate before group by 
select Min(salary)Dnum from Empoyee where Dnum in (1,2) group by Dnum
select Min(salary), Dnum from Empoyee where Gender='M' group by Dnum
-----------------
---different Tables
select sum(salary), d.Dname, d.Dnum from Empoyee e,Department d where e.Dnum=d.Dnum group by Dname,d.Dnum  
--------------
select * from Empoyee
------- having in aggregate after group by  
select sum(salary) as Summation_Salary, Dnum from empoyee group by Dnum having SUM(salary)>500

--where and having in aggregate function in one statement
select sum(salary) as Summation_Salary, d.Dnum,d.Dname from empoyee e,Department d where 
e.Dnum=d.Dnum and e.Gender='M' group by d.Dnum,d.Dname having SUM(salary)>=10000

-- aggregate with having only without group by
select sum(salary) from Empoyee having count(SSN)>4
---------------------------------------------------------------------------------------------------------------------
----Subquries  try used it in only with aggregate function
--for solving aggregate function 
select * from Empoyee where Salary>= (select max(salary) from Empoyee)

--subqueris with Updating 
update Empoyee 
	set Salary+=1 where Dnum=(select Dnum from Department where Dname='HR')


--for query without aggregate function
select * from Empoyee
select * from Empoyee where Dnum in (select distinct Dnum from Empoyee where Dnum>3);
------------------------------------------------------------------
-- joins is faster than subqueries  try in your best not to use it 
----------------------------------------------------------------------

--------------------------------------------------------------------------------------
--Union Family (union all-union-intersect-except) merging data vertically
--That is Called batch view 
select  Fname from Employee
select FirstN from Empoyee

--That is called Union the number of table columns and types must be equal
---get all
select  Fname from Employee
union all
select FirstN from Empoyee
-- get the Distinct but it is slower
select  Fname from Employee
union 
select FirstN from Empoyee

--get the intersect
select  Fname from Employee
Intersect
select FirstN from Empoyee 

--get the rows in the first table but not in second table
select  Fname from Employee
Except
select FirstN from Empoyee 
--------------------------------------------------------------------------------------------------------
--Excecution Order 
-- 1-From    2-joins     3-on  4-where   5-group   6-having   7- select   8-order by   8- top 

--Example: 
select CONCAT(FirstN,' ',LastN) as full_name from Empoyee where full_Name='ali Fares' --will give errror

--solution subquiery
select * from (select CONCAT(FirstN,' ',LastN) as full_name from Empoyee) as new_table
where full_Name='ali Fares' 

--------------------------------------------------------------------------------------------------------
--DB Objects [Table View Function SP Rule]
--path [ServerName].[DBname].[Schema].[Objectname]

select * from [DESKTOP-QKBK3B2].[AdventureWorks2012].[HumanResources].[Department]
select * from [DESKTOP-QKBK3B2].[DB1].[dbo].[Department]

---------------------------------------------------------------------------------------------------
--Rank Functions to answer some business Questions--like get the third high salary from the table
--row_number() function --given numbers only with out seeing the value --not repetative numbers
select * from (select *, ROW_NUMBER() over (order by salary desc) as RN from Empoyee) as newtable where RN<3;
--or 
select top(3)* from Empoyee order by Salary desc

--dense_rank() --give numbers depending on the value of salary its_self --repetative numbers
select * from (select *, DENSE_RANK() over (order by salary desc) as DR from Empoyee) as newtable where DR=2;

--Ntiles dividing our table into multiple groups 
select * from (select *, NTILE(3) over (order by salary desc) as NT from Empoyee) as newtable where NT=2;


-- rank functions with partioning 
select * from (select *, Row_number() over (partition by Dnum order by salary desc) as DR from Empoyee) as newtable where DR=2;

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
/*
--Data types: 
1-Numeric DT: 
bit  vs bool in programming
tinyint -128:127 unsigned 0:255
small int 2Byte 32768
int  4 byte 
bigint 5 byte
-------------
2-Decimal DT:
smalll money  4B.0000
money         8B.0000 
real          .0000000
float         .000000000000000000000000000000
decimial  mostused dec(5,2) ex: 188.29 199.23   1999.555-> wrong   
--------------
3-Char DT:
char(10)         fixed length 
varchar(10)      variable length 
nchar(10)          unicode for differnet language and special charachters
nvarchar(10)       variable unicode
nvarchar(max)       up to gigabyte 

--------------
4-DateTime  
Date MM/DD/YYYY
Time HH:MM:SS
Time(7) HH:MM:SS 12.1483264
datetime MM/DD/YYYY HH:MM:SS
datetime(7) MM/DD/YYYY HH:MM:SS 12.1483264
datetimeoffset  MM/DD/YYYY HH:MM:SS timezone
---------------------
5-Binary DT    0110100 like image in binary format 
----------
6-other  xml
*/
--------------------------------------------------------------------------------------------------------
--Case Statement

select SSN,FirstN,salary,
Case 
when Salary=10000 then 'High Salary'
when Salary>=5000 then 'Med Salary'
when Salary<5000 then 'Low salary'
else 'no value'
end as Salary_Val
from Empoyee

---IIf STATMENT---
select FirstN, iif(salary>5000,'High','Low') as Salary_val from Empoyee

--Convert Data to String-----------
select CONVERT(Varchar(10),getdate(),104) from Empoyee  --the third number represent the shape of date range from 101-102-103-104-105
OR
select Cast(getdate() as varchar(10)) from Empoyee

---Fomrat of your date is better  
select format(getdate(),'mm/dd/yyyy')
-------get date in int shape---------
select year(getdate())
---------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
--Schema is used to for grouping Tables 
create schema HumanResources
--put the table into your logiacal schema
alter schema HumanResources transfer Employee 


--create shortcut for your schema  and then use it in your Queries languages as if the schema name will be changed  in the future 
create synonym HE for  HumanResources.Employee
select * from HE

---------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
---Rule --it is shared over schema 
--it used to set cinstraint to new values not old, on otherhane constraint 
create rule r1 as @x>1000

sp_bindrule  r1,'dbo.Empoyee.salary'
sp_unbindrule  r1,'dbo.Empoyee.salary'
drop rule r1
----------------------------------------------------------------------------------------
--Defaults 
create default def1 as 500

sp_bindefault  def1,'dbo.Empoyee.salary'
-------------------------------------------------------------------------------------------
---Create dataType
sp_addtype complex,'int'

sp_bindrule r1,complex
sp_bindefault def1,complex  
---------------------------------------------------------------------------------------------
--advanced SQL
---Functions-------------------------------------
--local Variable 
declare @x int
set @x=100
select @x
--or 
select @x=100
--or 
select @x=age from Empoyee where age>10 --is used to assign value can not use with anonther column
select @x --to show the variable

--or delcare table
declare @z table(salary_yad int)
insert into @z
select salary from Empoyee
select * from @z
--global variable 
-- can not declare global variable 
-- can not assign global variable
select @@SERVERNAME  --name of server
select @@ERROR      --error number of your query 
select @@ROWCOUNT  --the last row effected 
select @@version   --type of version of sql server 
select @@IDENTITY  --show the idenetity of last inserted row in your table
--assign global variable to local variable 
select @x= @@ROWCOUNT


--take a string query and convert it to qury and run it
execute('select * from Empoyee')

--dynamic query 
declare @col varchar(50)='*',@tab varchar(50)='Empoyee'
execute('select '+@col+' from '+@tab)

-------------------------------------------------------------------------------------------------------------------------------
--control of flow statement 
--if 
declare @x int 
select @x=avg(salary) from Empoyee
declare @y int
set @y=7000
if @y > @x
	begin
	select 'his salary is high'
	end
else
	begin
	select 'his salary is low'
	end


--if exists if not exists --do execute it as it will stop the program warning
if exists(select name from sys.tables where name='emp')
	select 'the table is exists'
else
	begin
	create table emp( id int primary key,Fname varchar(50))
	end	
--try catch
begin try 
	delete from Empoyee where Dnum=1
end try
begin catch
	select 'error'
	select error_line(),error_number(),ERROR_MESSAGE()
end catch

--while 
--continue break
--case
--wait for 
--choose




create function get_age()
returns tables
as 
return(select * from emp)
go

create proc getstudent @age int
as 
execute select @age= age from emp




create trigger t1 on emp
after select 
as 
select getdate()-birthdate from emp
