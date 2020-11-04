# CTES - common table expressions 
#https://www.mssqltips.com/sqlservertip/5118/sql-server-cte-vs-temp-table-vs-table-variable-performance-test/ 

#A very simple example to show the general syntax
#The query after the AS keyword can be any query (from a simple to a very complex)

with cte_loan as (
  select * from bank.loan
)
select * from cte_loan
where status = 'B';


#In this query, we want to find the total amount and total balance of each customer in the transactions table and then pull more information on those customers by using a join between the CTE and the account table:

with cte_transactions as (
  select account_id, sum(amount), sum(balance)
  from bank.trans
  group by account_id
)
select * from cte_transactions ct
join account a
on ct.account_id = a.account_id;


#Lets try it! CA 3.06.1 Use a CTE to display the first account opened by a district.

# Views 

#slide deck on views (3 pm 2)

#In this query, we are creating a view to find the current customers that might be risky in the future. For this we found the average balance for the current customers in category C and checked which are the customers that have balances more than the average balance for that status category:


create view running_contract_ok_balances as
with cte_running_contract_OK_balances  as (
  select *, amount-payments as Balance
  from bank.loan
  where status = 'C'
  order by Balance
)
select * from cte_running_contract_OK_balances
where Balance > (
  select avg(Balance)
  from cte_running_contract_OK_balances
)
order by Balance desc
limit 20;

#Lets try it! CA 3.06.2 In order to spot possible fraud, we want to create a view last_week_withdrawals with total withdrawals by client in the last week.






#The WITH CHECK OPTION prevents a view from updating or inserting rows that are not visible through it. In other words, whenever you update or insert a row of the base tables through a view, MySQL ensures that the insert or update operation is conformed with the definition of the view.


drop view if exists customer_status_D;

create view customer_status_D as
select * from bank.loan
where status = 'D'
with check option;
Or you can also use :

create or replace view customer_status_D as
select * from bank.loan
where status = 'D'
with check option;


#Now if we try to insert new values in the table through the view, it doesn't work as the check is not met for status D:

select * from customer_status_D;

insert into customer_status_D values (0000, 00000, 987398, 00000, 60, 00000, 'C');


#But, in this case we have removed the WITH CHECK OPTION and now, if we try to insert new values in the table through the view, it works even if the status D condition is not met:

create or replace view customer_status_D as
select * from bank.loan
where status = 'D';

select * from customer_status_D;

insert into customer_status_D values (0000, 00000, 987398, 00000, 60, 00000, 'C');

select * from  bank.loan
order by loan_id;


drop view if exists customer_status_D;


#lets try it - 3.06.3 

#The table client has a field birth_number that encapsulates client birthday and sex. The number is in the form YYMMDD for men, and in the form YYMM+50DD for women, where YYMMDD is the date of birth. Create a view client_demographics with client_id, birth_date and sex fields. Use that view and a CTE to find the number of loans by status and sex.


#Correlated subqueries - slides

#Here we will try to build on the same example that we looked at for self-contained subquery. We extracted the results only for those customers whose loan amount was greater than the average. Here is the self-contained subquery:

select * from bank.loan
where amount > (
  select avg(amount)
  from bank.loan
)
order by amount desc
limit 10;

#Now we want to find those customers whose loan amounts are greater than the average but only within the same status group; ie. we want to find those averages by each group and simultaneously compare the loan amount of that customer with its status group's average.

select * from bank.loan l1
where amount > (
  select avg(amount)
  from bank.loan l2
  where l1.status = l2.status
)
order by amount desc;

#key word is simultaneous 

