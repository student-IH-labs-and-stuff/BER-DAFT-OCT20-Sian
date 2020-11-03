#inner joins as lookups

select * from bank.loan l
join bank.account a
on l.account_id = a.account_id;

select l.loan_id, l.account_id, l.amount, l.payments, a.district_id, a.frequency, a.date
from bank.loan l
join bank.account a
on l.account_id = a.account_id;

select * from bank.account a
join bank.loan l
on a.account_id = l.account_id;

# left joins 

select * from bank.loan l
left join bank.account a
on l.account_id = a.account_id;

select * from bank.account a
left join bank.loan l
on a.account_id = l.account_id;


# Write a query to extract information from the client and the district tables to get information for all the clients of the city and region they are from.



-- Step 1
select * from bank.client c join district d
on c.district_id = d.A1;

-- Step 2
select c.client_id, c.birth_number, c.district_id, d.A2, d.A3
from bank.client c join bank.district d
on c.district_id = d.A1;

#Write queries to extract information about the accounts:
#a) returning account_id, operation, frequency, sum of amount, sum of balance, b) where the balance is over 1000, c) operation type is VKLAD and d) that have an aggregated amount of over 500,000.

-- step1

select * from bank.trans t
left join bank.account a
on t.account_id = a.account_id;

-- step 2
select * from bank.trans t left join bank.account a on t.account_id = a.account_id
where t.operation = 'VKLAD' and balance > 1000;

-- step 3
select t.account_id, t.operation, a.frequency, sum(amount) as TotalAmount, sum(balance) as TotalBalance
from bank.trans t left join bank.account a on t.account_id = a.account_id
where t.operation = 'VKLAD' and balance > 1000
group by t.account_id, t.operation, a.frequency;

-- step 4
select t.account_id, t.operation, a.frequency, sum(amount) as TotalAmount, sum(balance) as TotalBalance
from bank.trans t left join bank.account a on t.account_id = a.account_id
where t.operation = 'VKLAD' and balance > 1000
group by t.account_id, t.operation, a.frequency
having TotalAmount > 500000
order by TotalAmount desc
limit 10;






#Get all the columns from 3 tables

select * from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.card ca
on d.disp_id = ca.disp_id;

select d.disp_id, d.type, d.client_id, c.birth_number, ca.type from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.card ca
on d.disp_id = ca.disp_id
where ca.type = 'gold';


# One more example - demo how to extract all the information from three tables (disp, client, and district):

select * from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.district da
on da.A1 = c.district_id;


#temporary tables 

create temporary table bank.loan_and_account
select l.loan_id, l.account_id, a.district_id, l.amount, l.payments, a.frequency
from bank.loan l
join bank.account a
on l.account_id = a.account_id;

select * from bank.loan_and_account;


create temporary table bank.disp_and_account
select d.disp_id, d.client_id, d.account_id, a.district_id, d.type
from disp d
join account a
on d.account_id = a.account_id;

select * from bank.disp_and_account;

select * from bank.loan_and_account la
join bank.disp_and_account da
on la.account_id = da.account_id
and la.district_id = da.district_id;


#outer joins, more than 2 tables 

select a.account_id, a.district_id, a.frequency, d.A2, d.A3, l.loan_id, l.amount, l.payments
from bank.account a left join bank.district d
on a.district_id = d.A1
left join bank.loan l
on a.account_id = l.account_id
order by a.account_id;


# Notice the difference in the results if we remove the keyword left from the query above. The query with only inner joins for the same tables as above is shown below:

select a.account_id, a.district_id, a.frequency, d.A2, d.A3, l.loan_id, l.amount, l.payments
from bank.account a join bank.district d
on a.district_id = d.A1
join bank.loan l
on a.account_id = l.account_id
order by a.account_id;

#self joins - Here in this example we are trying to find the customers that are from the same district.

select * from bank.account a1
join bank.account a2
on a1.account_id <> a2.account_id
and a1.district_id = a2.district_id
order by a1.district_id;

select a1.account_id, a2.account_id, a1.district_id
from bank.account a1
join bank.account a2
on a1.account_id <> a2.account_id
and a1.district_id = a2.district_id
order by a1.district_id, a1.account_id;

# Here in this example we are trying to find the customers that are both the OWNER and DISPONENT (look at the table disp)

select * from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type;


select d1.account_id, d1.type as Type1, d2.type as Type2
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type;


# As you will see, there are repeated values for each of the account ids. Lets try to solve this problem now.

select d1.account_id, d1.type as Type1, d2.type as Type2
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id and d1.type <> d2.type
where d1.type = 'DISPONENT';

#or alt method 

drop temporary table if exists combo;

create temporary table combo
select d1.account_id, d1.type as Type1, d2.type as Type2, row_number() over(order by account_id) as RowNumber
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id and d1.type <> d2.type;

select * from combo
where RowNumber % 2 = 1;

# Lets say we want to find all the combinations of different card types and ownership of account. We have not talked about sub queries yet. We will cover sub queries in greater detail later.

select * from (
  select distinct type from bank.card
) sub1
cross join (
  select distinct type from bank.disp
) sub2;

# The CROSS JOIN is used to generate a paired combination of each row of the first table with each row of the second table. This join type is also known as cartesian join.

create temporary table bank.distinct_cards select distinct type from bank.card;

create temporary table bank.distinct_frequency select distinct frequency from bank.account;

select * from distinct_cards
cross join distinct_frequency;

# nb The CROSS JOIN have a high potential to consume more resources and they can cause performance issues as they are computationally very expensive. This is because it produces the number of rows that are returned is the product of number of rows in table 1 times the number of rows in the other table



#subqueries!!

#'way easier than they sound'

#Lets use the loan table from the bank database. We want to identify the customers who have borrowed amount which are more than the average amount of all customers. This would not be possible to achieve through simple queries that have used before (without using variables which we will take a look at, later in the course). For this we will use a subquery.

-- step 1: calculate the average
select avg(amount) from bank.loan;

-- step 2 --> pseudo code the main goal of this step ....
select * from bank.loan
where amount > "AVERAGE";

-- step 3 ... create the query
select * from bank.loan
where amount > (
  select avg(amount)
  from bank.loan
);
-- step 4 - Prettify the result. Let's find top 10 such customers
select * from bank.loan
where amount > (select avg(amount)
from bank.loan)
order by amount desc
limit 10;

#This

#Sample A: The result from this query will be used again in later session to build further in the other topic we will cover.
#In this query we are trying to find those banks from the trans table where the average amount of transactions is over 5500.
#If we try to find this result directly, it would not be possible as we need only the names of the banks and not the averages in this case.
select bank from (
  select bank, avg(amount) as Average
  from bank.trans
  where bank <> ''
  group by bank
  having Average > 5500) sub1;
#Sample B : The result from this query will be used again in later session to build further in the other topic we will cover.
#In this query we are trying to find the k_symbols based on the average amount from the table order. The average amount should be more than 3000.
select k_symbol from (
  select avg(amount) as Average, k_symbol
  from bank.order
  where k_symbol <> ' '
  group by k_symbol
  having Average > 3000
  order by Average desc
) sub1; is a simple example where we are trying to show how subqueries are used. The same could also be achieved by using HAVING clause and no subquery.

select * from (
  select account_id, bank_to, account_to, sum(amount) as Total
  from bank.order
  group by account_id, bank_to, account_to
) sub1
where total > 10000;


#In this query we will use the results from Sample A. In that query we found the banks from the trans table where the average amount of transactions is over 5500. Now we will use those results to filter the results from the order table where bank_to is in the list of banks found previously.
select * from bank.order
where bank_to in (
  select bank from (
    select bank, avg(amount) as Average
    from bank.trans
    where bank <> ''
    group by bank
    having Average > 5500
    ) sub1
)
and k_symbol <> ' ';



#In this query we will use the results from Sample B. In that query we found the k_symbols based on the average amount from the table order. The average amount was more than 3000. Now we will use the results from the query above to only see the transactions from the trans table where the k_symbol value is the result from the above query.
select * from bank.trans
where k_symbol in (
  select k_symbol as symbol from (
    select avg(amount) as Average, k_symbol
    from bank.order
    where k_symbol <> ' '
    group by k_symbol
    having Average > 3000
    order by Average desc
  ) sub1
);