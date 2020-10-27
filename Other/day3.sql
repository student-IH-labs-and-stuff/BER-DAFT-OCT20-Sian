--  create database
create database if not exists bank_demo;
use bank_demo;
-- create tables (table with only primary key)

drop table if exists district_demo;

CREATE TABLE district_demo (
  `A1` int(11) UNIQUE NOT NULL,
  `A2` char(20) DEFAULT NULL,
  `A3` varchar(20) DEFAULT NULL,
  `A4` int(11) DEFAULT NULL,
  `A5` int(11) DEFAULT NULL,
  `A6` int(11) DEFAULT NULL,
  `A7` int(11) DEFAULT NULL,
  `A8` int(11) DEFAULT NULL,
  `A9` int(11) DEFAULT NULL,
  `A10` float DEFAULT NULL,
  `A11` int(11) DEFAULT NULL,
  `A12` float DEFAULT NULL,
  `A13` float DEFAULT NULL,
  `A14` int(11) DEFAULT NULL,
  `A15` int(11) DEFAULT NULL,
  `A16` int(11) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (A1)  -- constraint keyword is optional but its a good practice
);
-- create a table (table with foreign key)
drop table if exists account_demo;

CREATE TABLE account_demo (
  account_id int(11) UNIQUE NOT NULL,
  district_id int(11) DEFAULT NULL,
  frequency text,
  date int(11) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (account_id),
  CONSTRAINT FOREIGN KEY (district_id) REFERENCES district_demo(A1)
) ;
-- populating tables
insert into district_demo
values (1,'Hl.m. Praha','Prague',1204953,0,0,0,1,1,100,12541,0.29,0.43,167,85677,99107),
(2,'Benesov','central Bohemia',88884,80,26,6,2,5,46.7,8507,1.67,1.85,132,2159,2674),
 (3,'Beroun','central Bohemia',75232,55,26,4,1,5,41.7,8980,1.95,2.21,111,2824,2813),
 (4,'Kladno','central Bohemia',149893,63,29,6,2,6,67.4,9753,4.64,5.05,109,5244,5892);

#Note the below code will give a referential integrity error. Ask the students why this error is there.
#Reason: Second column in the account_demo table is the foreign key that refers to A1 in the district_demo table. Since we don't have any A1 value as 5, it can't accept that value for district_id.
insert into account_demo values
(1,4,'POPLATEK MESICNE',950324),
(2,1,'POPLATEK MESICNE',930226),
(3,5,'POPLATEK MESICNE',970707);

#Correct Code
insert into account_demo values
(1,4,'POPLATEK MESICNE',950324),
(2,1,'POPLATEK MESICNE',930226),
(3,2,'POPLATEK MESICNE',970707);

#In the table definition of account_demo, the column date was defined as integer type. We will modify the column to date type.
alter table account_demo
modify date date;
select * from account_demo;
#Drop a column
alter table district_demo
drop column A15;

select * from district_demo;

#Rename table name
alter table account_demo
rename to accountDemo;

#Rename column name in a table
alter table district_demo
rename column A1 to dist_id;

#Add a new column
alter table accountDemo
add column balance int(11) after date;



-- deletes the record where the condition is met
delete from account_demo where account_id = 1;

-- deletes all the contents from the table without deleting the table
delete from account_demo;


show variables like 'local_infile';
set global local_infile = 1;
delete from district_demo;

load data local infile './district.csv' -- this file is at files_for_lesson_and_activities folder
into table district_demo
fields terminated by ',';

delete from account_demo;

load data local infile './account.csv' -- this file is at files_for_lesson_and_activities folders
into table account_demo
fields terminated BY ',';


update district_demo
set A4 = 0, A5 = 0, A6 = 0
where A2 = 'Kladno';


-- what is the total amount loaned by the bank so far
select sum(amount) from bank.loan;

-- what is the total amount that the bank has recovered/received from the customers
select sum(payments) from bank.loan;

-- what is the average loan amount taken by customers in Status A
select avg(amount) from bank.loan
where Status = 'A';


select avg(amount) from bank.loan
group by Status;
select avg(amount) as Average, status from bank.loan
group by Status
order by Average asc;



