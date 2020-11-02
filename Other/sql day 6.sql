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


