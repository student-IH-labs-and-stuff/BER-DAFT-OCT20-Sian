-- Lesson 1
-- Get for each transactions, and the corresponding date, year and month
create or replace view user_activity as
select account_id, convert(date, date) as Activity_date,
date_format(convert(date,date), '%m') as Activity_Month,
date_format(convert(date,date), '%Y') as Activity_year
from bank.trans;

select * from bank.user_activity;

-- Get for each year and month, how many unique users made transactions.
create or replace view Monthly_active_users as
select Activity_year, Activity_Month, count(distinct account_id) as Active_users 
from user_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

select * from bank.Monthly_active_users;

-- Get the same table again with another column showing the number of active users in the previous month, on each row eg for a feb 1995, we would see also jan 1995 in the last column
with cte_activity as (
  select Activity_year, Activity_Month, Active_users, lag(Active_users,1) over (partition by Activity_year) as previous_month 
  from Monthly_active_users
)
select * from cte_activity
where last_month is not null;

-- Lesson 2
-- Get which "Active customers" where still active the next month.
with distinct_users as (
  select distinct account_id , Activity_Month, Activity_year
  from user_activity
)
select d1.Activity_year, d1.Activity_Month, count(distinct d1.account_id) as Retained_customers
from distinct_users d1
join distinct_users d2
on d1.account_id = d2.account_id and d1.activity_Month = d2.activity_Month + 1
group by d1.Activity_Month, d1.Activity_year
order by d1.Activity_year, d1.Activity_Month;

-- We get a view of the previous query.
create or replace view retained_customers_view as
with distinct_users as (
  select distinct account_id , Activity_Month, Activity_year
  from user_activity
)
select d1.Activity_year, d1.Activity_Month, count(distinct d1.account_id) as Retained_customers
from distinct_users d1
join distinct_users d2 on d1.account_id = d2.account_id
and d1.activity_Month = d2.activity_Month + 1
group by d1.Activity_Month, d1.Activity_year
order by d1.Activity_year, d1.Activity_Month;

select * from bank.retained_customers_view;

-- Lesson 3
-- List retained customers by year and month 
select * from retained_customers_view;

-- Get a month to month comparison of Retained customers
select
	Activity_year,
	Activity_month, 
	Retained_customers, 
    lag(Retained_customers, 1) over(partition by Activity_year) as Last_month_retained_customers
from bank.retained_customers_view;

-- Now we get the difference in a new column called "Diff"
select
    Activity_year,
    Activity_month,
	(Retained_customers-lag(Retained_customers, 1) over(partition by Activity_year)) as Diff
from bank.retained_customers_view;