![IronHack Logo](https://s3-eu-west-1.amazonaws.com/ih-materials/uploads/upload_d5c5793015fec3be28a63c4fa3dd4d55.png)

# Lab | SQL - Queries 5

## Introduction

In this lab, you will be using the Sakila database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official installation link.

It helps to run SELECT * FROM sakila.tablename; before and after the changes you running to see the differences. 

### 1. Drop column picture from staff.?

Result:

```
1	Mike	Hillyer	3	Mike.Hillyer@sakilastaff.com	1	1	Mike	8cb2237d0679ca88db6464eac60da96345513964	2006-02-15 03:57:16
2	Jon	Stephens	4	Jon.Stephens@sakilastaff.com	2	1	Jon		2006-02-15 03:57:16
```
select * from staff;

### 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
Result:

```
1	Mike	Hillyer	3	Mike.Hillyer@sakilastaff.com	1	1	Mike	8cb2237d0679ca88db6464eac60da96345513964	2006-02-15 03:57:16
2	Jon	Stephens	4	Jon.Stephens@sakilastaff.com	2	1	Jon		2006-02-15 03:57:16
3	TAMMY	SANDERS	79	TAMMY.SANDERS@sakilacustomer.org	2	1	tammy		2020-10-28 10:06:43
									
```
select * from staff;


### 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1 today.
Result:

```

1	2005-05-24 22:53:30	367	130	2005-05-26 22:04:30	1	2006-02-15 21:30:53
2	2005-05-24 22:54:33	1525	459	2005-05-28 19:40:33	1	2006-02-15 21:30:53
3	2005-05-24 23:03:39	1711	408	2005-06-01 22:12:39	1	2006-02-15 21:30:53
4	2005-05-24 23:04:41	2452	333	2005-06-03 01:43:41	2	2006-02-15 21:30:53
5	2005-05-24 23:05:21	2079	222	2005-06-02 04:33:21	1	2006-02-15 21:30:53
						
```
select * from rental limit 5;

### 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date the user was deleted.?
Result:

```
1	1	MARY	SMITH	MARY.SMITH@sakilacustomer.org	5	1	2006-02-14 22:04:36	2006-02-15 04:57:20
2	1	PATRICIA	JOHNSON	PATRICIA.JOHNSON@sakilacustomer.org	6	1	2006-02-14 22:04:36	2006-02-15 04:57:20
3	1	LINDA	WILLIAMS	LINDA.WILLIAMS@sakilacustomer.org	7	1	2006-02-14 22:04:36	2006-02-15 04:57:20
4	2	BARBARA	JONES	BARBARA.JONES@sakilacustomer.org	8	1	2006-02-14 22:04:36	2006-02-15 04:57:20
5	1	ELIZABETH	BROWN	ELIZABETH.BROWN@sakilacustomer.org	9	1	2006-02-14 22:04:36	2006-02-15 04:57:20
```
select * from customer_active limit 5; -- if you create a new table only with active = 0
OR
select * from customer limit 5; -- if you delete the rows from customer table 

```
