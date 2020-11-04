#subquery - reminder of syntax 


select * from (
  select account_id, bank_to, account_to, sum(amount) as Total
  from bank.order
  group by account_id, bank_to, account_to
) sub1
where total > 10000;


# join - reminder of syntax 

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

#more than 2 tables

select * from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.card ca
on d.disp_id = ca.disp_id;



#3.05.2 Get a list of accounts from Central Bohemia using a subquery.
#Rewrite the previous as a join query.
#Discuss which method will be more efficient 
#how ? - do some google research on efficiency of subqueries v joins, have a look at the time taken to return the results in your sql client 



#https://www.geeksforgeeks.org/sql-join-vs-subquery/





#NESTED subqueries 

#first lets think about what can be described as child and parent queries - using the results of one query to filter another 

#step 1 define the Child query: which banks have average transaction amounts over 5500? this gives us a very short list of banks and their avg trans amount

select bank, avg(amount) as Average from bank.trans
where bank not in  ('',' ')
group by bank
having Average > 5500;

#step 2 define the parent query : which banks have big transactions AND are not 'ST', which we want to exclude too

select distinct bank from bank.trans
 #from "list of banks with >5500 avg trans" 
 where bank <> 'ST' ;
 
#step 3 build the whole query 

select bank from 
(select bank, round(avg(amount),2) as Average from bank.trans
where bank not in  ('',' ')
group by bank
having Average > 5500) as sub1
where bank <> 'ST';


#summarise rules about subqueries - ppt slides 


#nested - starts to get very messy - check the brackets!

# 1 subquery 

select bank, round(avg(amount),2) as Average from bank.trans
where bank <> ''
group by bank
having Average > 5500;


select bank from (
      select bank, round(avg(amount),2) as Average
      from bank.trans
      where bank <> ''
      group by bank
      having Average > 5500
) as sub1;


# 2 subqueries 

select k_symbol, round(avg(amount),2) as mean from bank.order
where bank_to in 
(
    select bank from 
    (
      select bank, round(avg(amount),2) as Average
      from bank.trans
      where bank <> ''
      group by bank
      having Average > 5500
    ) 
    as sub1
)
  and k_symbol <> ' '
  group by k_symbol
  having mean > 2000;

#3 subqueries 

select k_symbol from 
(
  select avg(amount) as mean, k_symbol
  from bank.order
  where bank_to in 
  (
    select bank
    from 
    (
      select bank, avg(amount) as Average
      from bank.trans
      where bank <> ''
      group by bank
      having Average > 5500
    ) 
    as sub1
  )
  and k_symbol <> ' '
  group by k_symbol
  having mean > 2000
) as sub;

#another example 

select operation from (
  select operation, round(avg(balance),2) as Avg_balance from bank.trans
  where k_symbol in (
    select k_symbol as symbol from (
		select k_symbol, round(avg(amount),2) as Average from bank.order
		where k_symbol <> ' '
		group by k_symbol
		having Average > 3000
		order by Average desc
    ) sub1
  )
  group by operation
) sub2
order by Avg_balance
limit 1;

# CA 3.05.3 Find the most active customer for each district in Central Bohemia- using subquery to find the position 1 in each district


#which tables do we need? how can i join them?
#which fields do i want back in the end?

# which window function should we use? what will be the partition and order by clauses?

select district.A2 district_name, account_id, round(total) as total
from 
(
  select ac.account_id, ac.district_id, sum(tr.amount) as total, 
  rank() over (partition by district_id order by sum(tr.amount) desc) as position
  from bank.account ac
  inner join bank.trans tr
  using (account_id)
  group by ac.account_id
) as t
inner join district on t.district_id = district.A1
where position = 1
order by district_id;

# watch out for the joins inside and outside the subquery- last part we are joining the results of a subquery as a temp table to an actual table 