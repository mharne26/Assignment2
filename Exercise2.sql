/* Exercise 2. Write separate queries using a join, a subquery, a CTE, and then an EXISTS to list all 
AdventureWorks customers who have not placed an order.*/

--Join query
select c.CustomerID from Sales.SalesOrderHeader s right join Sales.Customer c on s.CustomerID=c.CustomerID 
where s.SalesOrderID is null

--SubQuery
select c.CustomerID from Sales.Customer c
where c.CustomerID not in (select CustomerID from Sales.SalesOrderHeader);

--CTE(Comman Table Expersion)
use AdventureWorks2008R2
with  CustomersWithNoOrder
AS 
(
	select c.CustomerID from Sales.SalesOrderHeader s right join Sales.Customer c on s.CustomerID=c.CustomerID 
	where s.SalesOrderID is null
)
SELECT * FROM CustomersWithNoOrder;

--EXISTS 
select c.CustomerId from Sales.Customer c where not exists(select s.CustomerID FROM Sales.SalesOrderHeader AS s
				WHERE s.CustomerID = c.CustomerID);
