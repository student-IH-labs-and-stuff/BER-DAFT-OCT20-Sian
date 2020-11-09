#Keep working on the bank database.
#List districts together with total amount borrowed and average loan amount.
#need fields from 3 tables loan, district, account
#using group by to list the districts, with avg loan and total loan
select d.A2,
sum(l.amount) as totalborrowed,
avg(l.amount) as avgloan
from loan l
join account a
on l.account_id = a.account_id
join district d
on a.district_id = d.A1
group by d.A2
order by d.A2
#using window functions- to compare loans against district averages
select l.loan_id,d.A2,
sum(l.amount) over(partition by a.district_id) as totalborrowedindistrict,
avg(l.amount) over(partition by a.district_id) as avgloanperdistrict
from loan l
join account a
on l.account_id = a.account_id
join district d
on a.district_id = d.A1
order by d.A2



# if brechts suggested solution to this query didnt work have a think about SQL modes 
#https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html

#suggested solutiojn  ---- SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,‘ONLY_FULL_GROUP_BY’,‘’));

# heres a conversation about this https://stackoverflow.com/questions/23921117/disable-only-full-group-by
