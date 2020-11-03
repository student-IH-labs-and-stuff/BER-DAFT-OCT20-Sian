

-- step1:
select round(avg(amount),2) as "Avg Amount", round(avg(payments),2) as "Avg Payment", status
from bank.loan
group by status
order by status;

-- step 2:
select round(avg(amount),2) - round(avg(payments),2) as "Avg Balance", status
from bank.loan
group by status
order by status;


select round(avg(amount),2) as Average, k_symbol from bank.order
group by k_symbol
order by Average asc;


select round(avg(amount),2) as Average, k_symbol from bank.order
where k_symbol<> ' '
group by k_symbol
order by Average asc;

-- the same query with NOT operator

select round(avg(amount),2) as Average, k_symbol from bank.order
where not k_symbol = ' '
group by k_symbol
order by Average asc;

select round(avg(amount),2) - round(avg(payments),2) as "Avg Balance", status, duration
from bank.loan
group by status, duration
order by status, duration;

select round(avg(amount),2) - round(avg(payments),2) as "Avg Balance", status, duration
from bank.loan
group by status, duration
order by duration, status;

-- Query without the "order by" clause
select type, operation, k_symbol, round(avg(balance),2)
from bank.trans
group by type, operation, k_symbol;
-- Query with the "order by" clause
select type, operation, k_symbol, round(avg(balance),2)
from bank.trans
group by type, operation, k_symbol
order by type, operation, k_symbol;


select type, operation, k_symbol, round(avg(balance),2) as Average
from bank.trans
where k_symbol <> '' and k_symbol <> ' ' and  operation <> ''
group by type, operation, k_symbol
having Average > 30000
order by type, operation, k_symbol;



-- Not the most efficient way of using the HAVING clause

select type, operation, k_symbol, round(avg(balance),2) as Average
from bank.trans
where k_symbol <> '' and k_symbol <> ' '
group by type, operation, k_symbol
having operation <> ''
order by type, operation, k_symbol;



-- Using the same query as before

select round(avg(amount),2) - round(avg(payments),2) as Avg_Balance, status, duration
from bank.loan
group by status, duration
having Avg_Balance > 100000
order by duration, status;





#window fx

select loan_id, account_id, amount, payments, duration, amount-payments as "Balance",
avg(amount-payments) over (partition by duration) as Avg_Balance
from bank.loan
where amount > 100000
order by duration, balance desc;



-- You can also have ORDER BY clause followed by partition by as shown below:


select loan_id, account_id, amount, payments, duration, amount-payments as "Balance",
avg(amount-payments) over (partition by duration order by duration asc, amount desc) as Avg_Balance
from bank.loan
where amount > 100000;

