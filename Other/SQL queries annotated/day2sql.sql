select account_id, district_id, frequency, convert(date,date) from bank.account;

select account_id, district_id, frequency, CONVERT(date,datetime) from bank.account;

#next is a two step process:
select substring_index(issued, ' ', 1) from bank.card;
select convert(SUBSTRING_INDEX(issued, ' ', 1), date) from bank.card;


# converting the original format to the date format that we need:
select date_format(convert(date,date), '%Y-%M-%D') from bank.loan;

# if we just want to extract some specific part of the date
select date_format(convert(date,date), '%Y') from bank.loan;

# logical order of processing sql queries 
select * from bank.card
where type = 'classic'
order by card_id
limit 10;

select * from bank.order
where k_symbol = 'SIPO' and amount > 5000
order by order_id desc
limit 10;


select isnull('Hello');
select isnull(card_id) from bank.card;

# this is used to check all the elements of a column.
# 0 means not null, 1 means null
select sum(isnull(card_id)) from bank.card;

select * from bank.order
where k_symbol is null;

select * from bank.order
where k_symbol is not null and k_symbol = ' ';


select loan_id, account_id,
case
when status = 'A' then 'Good - Contract Finished'
when status = 'B' then 'Defaulter - Contract Finished'
when status = 'C' then 'Good - Contract Running'
else 'In Debt - Contract Running'
end as 'Status_Description'
from bank.loan;

select A3 from bank.district;
select distinct A3 from bank.district;
select * from bank.order
where k_symbol in ('leasing', 'pojistine');

select * from bank.account
where district_id in (1,2,3,4,5);
# We are trying to get the same result using the between operator.
# Note that 1 and 5 are included in the range of values compared/evaluated

select * from bank.account
where district_id between 1 and 5;

select * from bank.loan
where amount - payments between 1000 and 10000;

select * from bank.district
where A3 like 'north%';

select * from bank.district
where a3 like 'north_M%';
# This would return all the results for
# 'north  Moravia', 'northMoravia', northMiami'

select * from bank.district
where a3 regexp 'north';

# Now we will take a look at another table
# to see the difference between LIKE and REGEXP
select * from bank.order
where k_symbol regexp 's';

select * from bank.order
where k_symbol regexp '^s';

select * from bank.order
where k_symbol regexp 'o$';

# We can include multiple conditions at the same time
select distinct k_symbol from bank.order
where k_symbol regexp 'ip|is';

select * from bank.district
where a2 regexp 'cesk[ey]';

select * from bank.district
where a2 regexp 'ch[e-r]';

select distinct a2 from bank.district
order by a2;

select distinct a2 from bank.district
order by a2 asc;

select * from bank.district
order by a3;

select * from bank.district
order by a3 desc;

#Note that, by default, (if not specified) the order is ascending.
#By default, in an ascending sort, special characters appear first, followed by numbers, and then letters.
#Null values appear first if the order is ascending.
#You can use any column from the table to sort the values even if that column is not used in the select statement.

select * from bank.order
order by account_id, bank_to;

select * from bank.order
order by account_id, bank_to, k_symbol;


