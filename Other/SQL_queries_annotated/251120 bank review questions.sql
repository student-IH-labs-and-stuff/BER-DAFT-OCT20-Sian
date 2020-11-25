/*

Explore the bank database

*/

use bank;


-- How many clients and accounts are there, overall?


-- How many clients are "owners" and how many "disponents" of the accounts?

select type, count(type) from disp 
group by type;


-- How many clients & accounts are there by region?

select count(distinct(d.account_id)) as Accounts, count(distinct(d.client_id)) as Clients, a.A3  as District from disp d 
join district a 
on d.disp_id = a.A1
group by a.A3;


select d.A3 as District,  count(distinct(a.account_id))  as Accounts,  count(distinct(c.client_id)) as Clients
from district d
join account a
on a.district_id = d.A1
join client c 
on c.district_id = d.A1
group by d.A3 ;


-- Explore the loans given to clients

select d.client_id, l.Loan_id, l.account_id, l.amount , l.duration, l.status 
from loan l 
join disp d
using(account_id);


-- How could we define clients as valuable / not valuable?

select l.status, d.client_id, sum(l.amount) as totalloanamount
from loan l 
join disp d
using(account_id)
where status in ('B','D')
group by l.status, d.client_id ; 



-- Once you've defined how to classify clients as valuable / not valuable:
	-- describe both groups of clients based on information you'll find accross all tables
    -- (what type of client they are, where do they live, what type of card, etc.)
    
    
    
    select t. transaction date from trans t 
    
    where client_id in (SUBQUERY) 