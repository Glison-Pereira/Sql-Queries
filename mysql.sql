-- This SQL file contains sample data for learning purposes only. No real user information is included.
create database mysqlcourse; # it is used to create database, syntax: create database database_name;
use mysqlcourse; # it is used to switch to database you want, syntax: use database_name;
create table users(id int unsigned,name varchar(100),email varchar(150), password varchar(100),contact varchar(15), 
address text, dob date,gender enum("M","F","O"), status boolean);
/* it is used to create table,syntax: create table table_name(column_name datatype,column_name datatype);
 enum only allows those values present in its circular brackets*/
insert into users values(1,"arvind","arvind@gmail.com","1234","1234567890","mumbai,maharashtra","2023-09-11","M",0);
insert into users(id,name,email) values(2,"arvi","arvi@gmail.com");
insert into users values(3,"arv","arv@gmail.com","1234","1234567892","mumbai,maharashtra","2023-08-11","M",0),
(4,"ar","ar@gmail.com","1234","1234567891","pune,maharashtra","2023-07-11","O",1),
(5,"ka","ka@gmail.com","12345","1234567894","chennai,tamil nadu","2023-07-11","F",0),
(6,"kat","kat@gmail.com","12346","1234567896","kolkata,westbengal","2023-07-11","F",1);
/* boolean can take either 0 or 1 only. syntax: insert into table_name values(value1,value2,...),(value1,value2,...);
in insert you can add multiple rows in same query, you can also only add values to some columns also*/
select * from users; # syntax: select * from table_name; * means selecting from all rows
select * from users where id="3"; # syntax: select * from table_name where condition; 
select id,name As "student name" from users;
# As is used to change the name of column, syntax: select column_name,column_name from table_name; 
create table students(id int not null unique, name varchar(100) not null,email varchar(150) not null unique,
age tinyint check(age>=18), status boolean default 1);
/* not null is used when you can't leave a particular column value as null, unique is used to avoid repetitive values in
column, default is used to set default value, check is used to provide condition which need to be followed while inserting*/
select * from users where id="1" and id="2"; 
# and is used when you want to provide more than one condition and all conditions should satisfy
select * from users where gender="M" or gender="O"; 
# or is used when you want to provide more than one condition and either of the conditions becomes true it will do
select * from users where gender="M" and not gender="O"; 
# not is used when you want to make a condition which is true->false, basically contradict the condition
select * from users where gender In("M","O","F"); 
/* In is basically used where you have multiple condition which include lot of 'or' 
Example: select * from users where gender="M" or gender="O" or gender="F"; as you can see this query consist of 3 or's
so we can use In instead which have same functionality as or. In only works for 'or' and not 'and' */
create table employee(id int not null unique,name varchar(100) not null,age int not null,city varchar(100));
insert into employee values(1,"glen",29,"mumbai"),(2,"sonic",20,"pune"),(3,"unan",18,"chennai"),(4,"steven",16,"jodhpur"),
(5,"roy",25,"kolkata"),(6,"royal",20,"Delhi");
select * from employee;
select * from employee where age between 18 and 29;
select * from employee where age not between 18 and 29;
/* between and not between are always accompanied by 'and' and not 'or' or 'not',
syntax: select * from employee where age between val1 and val2; select * from employee where age not between val1 and val2;
also they are used when you want to find values for a particular range; */
select * from employee order by name desc;# syntax:select * from table_name order by column_name asc|desc
# asc-> ascending,desc->descending, order by is used to arrage rows in ascending or descending order, by default if 
#we don't write asc or desc it considers it to be asc
select distinct age from employee; 
# distinct is used to remove unique values basically it doesn't repeat a particular value whil displaying
select * from employee where age is null; # it gives those records which have null values in columns
select * from employee where age is not null; # it gives those records which have not null values in columns
select * from users limit 5 offset 1; 
/*limit and offset are used when we want to show only few rows from large data rows, limit by default start from 0 
position i.e. the first row inserted always and would show rows as per number mention and offset is used from position
to start*/
select count(id) from users; # count() find how many, sum(),avg(), min(), max() are aggregate function
update employee set age=65 where id=2; 
# update should always get accompanied by where clause, it is used to change value in a row
delete from employee where id=5;
# delete should always get accompanied by where clause, it is used to delete a row
select * from employee where name like '_l%'; # this is wildcard used along with like
select * from employee;
commit;
update employee set age=19 where id=1;
rollback;
/*rollback is needed when you make changes database and then realise the change made is not suitable so you want to go
back to value which is being changed, commit is basically when you are sure of the change you made and don't want to 
change afterwards, also if you forget to write commit after each query which brings change in database then if you 
write rollback all queries which are not committed will get affect
Eg:
insert query
update query
rollback now if rollback is executed then both insert and update query will not have any affect on database but 
if commit is written after insert only update will have no effect on database */
# once committed, rollback not possible
drop table students;# alternative -> truncate table students; deletes and destroys entire table(make is not existend)
#alter is used to modify table
alter table employee add gender enum("M","F","O"); # To add new column
alter table employee modify gender varchar(10); # To modify column datatype
alter table employ drop column equality; # To delete column 
alter table employee change gender equality varchar(10);# To rename a column
alter table employee rename employ; # To change name of table
select * from employ;
alter table employ rename employee;
/* while applying union and union all, select statement should have same number of column, column must have same data
type, columns must be in same order*/
select id,name from users
union
select id,name from employee;
/* same is for union all just difference is while showing 'union all' will show all entries but 'union' will not show
 duplicate entries, they are used to combine tables basically*/
select id,name,age, if(age>=18,"vote","cannot vote") as voter from employee; # basically used to apply condition
#syntax: select col1,col2 if(condition,true result,false result) as alias_name from table_name;
select id,name,age, 
case 
    when age<18 then "cannot vote"
	when age=18 then "apply for vote"
    else "vote" 
end as voter from employee;
/*syntax: select col1,col2 
         case
                when col1 then res1
				when col2 then res2
				else res alias_name
		end as alias_name from table_name; used when want multiple condition*/
create table student(id int not null ,name varchar(100), age int not null, city int not null, primary key(id),
foreign key(city) references city(cid));
create table city(cid int not null auto_increment,cityname varchar(100),primary key(cid));
insert into student values(1,"glen",18,1),(2,"tom",15,2),(3,"levi",24,1),(4,"garry",29,3);
insert into city(cityname) values("mumbai"),("chennai"),("kolkata"),("dubai");
select * from student;
select * from city; 
/* primary key is unique,not null,only single primary key, foreign key is used to link table and is used to point
primary key of other table */
select s.id,s.name,s.age,c.cityname from student s inner join city c on s.city=c.cid;
/* s.city is foreign key and c.cid is primary key, s is alias name for student and c is alias for city
 'inner join' and 'join' is same shows  records that have matching values in both tables,
 'on' keyword means where we want to match*/ 
insert into student values(5,"ross",28,4);
insert into city(cityname) values("pune"); 
select s.id,s.name,s.age,c.cityname from student s left join city c on s.city=c.cid;
select s.id,s.name,s.age,c.cityname from student s right join city c on s.city=c.cid;
/* left join returns all records from left table(table1) and the matched records from the right table(table2);
right join returns all records from right table(table2) and the matched records from the left table(table1)*/
select * from student cross join city; # it gives every row in table 1 is joined with all rows in table 2
select * from student , city; # gives same answer as cross join
select * from employee where name regexp '^g'; # regular expression using select
select cityname,count(city) from student inner join city  on student.city=city.cid group by city 
having count(city)>1;
/* group by is used with conjunction with select and aggregate functions to grp rows together by common 
column values, having is used to add extra condition (mostly comes with group by),having is optional*/ 
select name from student where city In((select cid from city where cityname In("mumbai","kolkata")));
/* If any single record exists then parent command show results in 'exist','not exists' is reverse of 'exist'*/
select name from student where exists(select cid from city where cityname In("mumbai","kolkata"));
# it shows all content when true both exists and not exists
select name from student where not exists(select cid from city where cityname In("goa"));
create view studentdata as select id,name,cityname from student s inner join city c on s.city=c.cid;
select * from studentcourse;
alter view studentdata as select id,name,age,cityname from student s inner join city c on s.city=c.cid;
rename table studentdata to studentcourse;
drop view studentcourse;
/* syntax: create view view_name as query; alter view view_name as query;
rename table previous_view_name to new_view_name; drop view view_name; it is simplify complex query, provides extra
layer of security, performance decreases, dependency on table,view works just like function in programming languages, 
it isn't table nor does it have any data, it just is used to store a complex query so that the complex query will
 not be required to write again and again when required again, we can just call view, view for itself doesn't
do anything instead just stores query*/
create index studage on student(age);
/*it reduces time and increases speed of searching and columns should be those which gives max searching and drop 
command destroys the index*/
show index from student;
drop index studage on student;
/* create index index_name on table_name(col1,col2,col3,...); searching becomes faster, indexing is permanently saved
on server, drop index index_name on table_name; automatically creates the indexes for primary key and unique 
columns so no need to be included,index columns that you frequently use to retrive the data only use those,
small tables do not require indexes, avoid columns that contain too many 'null' values, index columns that are used for
joins to improve join performance, atleast 10000+ records are require for best result of indexes*/ 
