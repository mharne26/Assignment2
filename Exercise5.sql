/*Exercise 5. rite a Procedure supplying name information from 
the Person.Person table and accepting a filter for the first name.
Alter the above Store Procedure to supply Default Values if user does not enter any value.
( Use AdventureWorks)*/

--Store Procedure
Alter proc uspSupplyName 
@FirstName varchar(200) ='Terri'
as
begin 
select * from Person.Person where FirstName=@FirstName;
end

--execute procedure
exec uspSupplyName 'kim'
--select FirstName from Person.Person