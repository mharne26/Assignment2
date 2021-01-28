/*
Exercise 3. Show the most recent five orders that were purchased from account numbers that have spent more than $70,000 with AdventureWorks.
*/

select top 5 SalesOrderID,AccountNumber,OrderDate from Sales.SalesOrderHeader where AccountNumber in
(select AccountNumber from Sales.SalesOrderHeader group by AccountNumber having sum(SubTotal)>7000)
order by OrderDate desc