
#We are interested in finding information about clients such as their account numbers, their demographics (where they are from), and the loan details but only of clients that are marked as status "B". Customers with status "B" are the customers for whom the contract is finished but they have not repaid the loan.


select a.account_id, a.district_id, a.frequency, d.A2 as District, d.A3 as Region, l.loan_id, l.amount, l.payments, l.status
from bank.account a join bank.district d
on a.district_id = d.A1
join bank.loan l
on a.account_id = l.account_id
where l.status = "B"
order by a.account_id;


# stored procedure basic syntax 

drop procedure if exists number_of_rows_proc;

delimiter //
create procedure number_of_rows_proc (out param1 int)
begin
select COUNT(*) into param1 from bank.account;
end;
//
delimiter ;

#return the count from the procedure 
call number_of_rows_proc(@x);
select @x;

# how to 

#DELIMITER //
#CREATE PROCEDURE <NAME>
#BEGIN
  #SELECT field, field FROM table
  #WHERE something = n ;
#END //
#DELIMITER ;


# The customers with status "B" are the ones where the contract was finished but the loan amount was not paid. Your manager wants to keep a track of the average money not paid by such customers. We will create a stored procedure to run this query.


drop procedure if exists average_loss_proc;

delimiter //
create procedure average_loss_proc (out param1 float)
begin
  select round((sum(amount) - sum(payments))/count(*), 2) into param1
  from bank.loan
  where status = "B";
end;
//
delimiter ;

call average_loss_proc(@x);
select round(@x,2) as Average_loss_per_customer;


# Stored Procedure to return rows from query results

drop procedure if exists return_query_rows_proc;

delimiter //
create procedure return_query_rows_proc()
begin
  select *
  from bank.loan
  where status = "B";
end;
//
delimiter ;

call return_query_rows_proc();

