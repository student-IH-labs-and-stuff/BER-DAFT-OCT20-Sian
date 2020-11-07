-- Goal is to rank the customers based on the amount of loan borrowed.
-- This will help us to find the nth highest amount in the table

select *, rank() over (order by amount desc) as 'Rank'
from bank.loan;

select *, row_number() over (order by amount desc) as 'Row Number'
from bank.loan;
-- In this query, we are trying to rank the customers based on the amount of loan
-- they have borrowed, in each of the "k_symbol" categories

select * , rank() over (partition by k_symbol order by amount desc) as "Ranks"
from bank.order
where k_symbol <> " ";

select *, rank() over(order by amount asc) as 'RANK'
from bank.order
where k_symbol <> ' ';

#or 

select *, dense_rank() over(order by amount asc) as 'RANK'
from bank.order
where k_symbol <> ' ';

select * from bank.account a
join bank.loan l on a.account_id = l.account_id
limit 10;

-- Building on the same query to add some filters and order by

select * from bank.account a
join bank.loan l on a.account_id = l.account_id
where l.duration = 12
order by l.payments
limit 10;
-- Using an alias to select some columns

select a.account_id, a.frequency, l.loan_id, l.amount, l.duration, l.payments, l.status
from bank.account a
join bank.loan l on a.account_id = l.account_id
where l.duration = 12
order by l.payments
limit 10;

-- Some test code

select count(distinct account_id) from bank.account;
select count(distinct account_id) from bank.loan;

-- Left Join

select a.account_id, a.frequency, l.loan_id, l.amount, l.duration, l.payments, l.status
from bank.account a
left join bank.loan l on a.account_id = l.account_id
order by a.account_id;


select a.account_id, a.frequency, l.loan_id, l.amount, l.duration, l.payments, l.status
from bank.account a
right join bank.loan l on a.account_id = l.account_id
order by a.account_id;



