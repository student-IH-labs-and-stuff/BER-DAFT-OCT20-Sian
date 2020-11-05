

#3.06.2 In order to spot possible fraud, we want to create a view last_week_withdrawals with 
#total withdrawals by client in the last week.

#first stage - find the latest transaction date for each account - so we can see what was the last date of transactions per each account. 
select account_id, max(date) from trans
group by account_id

 
# next, lets put the max date into a table against each account record using a subquery and check it works out
#- i can show all account fields here or select those i care about. note its quite a slow query


  select *,
  (
    select max(date) from trans
  ) as max_date from bank.trans
  
#NOTE as i am going to be referring to this derived table later i will treat this like a reusable function and create as a CTE, which should improve the performance too


#the columns i want to see in my final view
 #- something about the client - lets use account_id to keep things simple
 #the sum of the trans amount - which means i need to group by account
 
# pseudo code looks like: NB dont run this you will get an error 
 select account_id, round(sum(amount)) as total_withdrawal
from "transaction table"
group by account_id
where date of transaction is UP TO 7 days smaller than max date;

#date filtering - i want to see everything each account did in their last week, so i will use DATE_SUB with 
#interval 7 to get max day - 7 days. could also have used between or in with dates... there are other ways!

date(date) > date_sub(max_date, interval 7 day)


#full view create query

create view last_week_withdrawals as
with cte_transactions as
 (
  select *,
  (
    select max(date) from trans
  ) as max_date from bank.trans
)
select account_id, round(sum(amount)) as total_withdrawal
from cte_transactions
where date(date) > date_sub(max_date, interval 7 day)
group by account_id;



#with client in place of account - we need to join to the disp table which contains client and account ids
create or replace view last_week_withdrawals as
with cte_transactions as
 (
  select *, 
  (
    select max(date) from trans
  ) as max_date from bank.trans
)
select d.client_id, round(sum(t.amount)) as total_withdrawal
from bank.disp d
join cte_transactions t
using (account_id)
where date(t.date) > date_sub(t.max_date, interval 7 day)
group by d.client_id;