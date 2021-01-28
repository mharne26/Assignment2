/*Exercise 4.Create a function that takes as inputs a SalesOrderID, a Currency Code, and a date, and returns 
a table of all the SalesOrderDetail rows for that Sales Order including Quantity, ProductID, UnitPrice,
and the unit price converted to the target currency based on the end of day rate for the date provided.
Exchange rates can be found in the Sales.CurrencyRate table. ( Use AdventureWorks)

*/
--function
create function fn_GetProductDetails(@SalesOrderID int,@CurrencyCode varchar(3),@Date datetime)
returns table
as 
return 
with ProductDetails
as(
select * from Sales.SalesOrderDetail where Sales.SalesOrderDetail.SalesOrderDetailID=@SalesOrderID)
select ProductDetails.ProductID,ProductDetails.OrderQty,ProductDetails.UnitPrice,
ProductDetails.UnitPrice*Sales.CurrencyRate.EndOfDayRate as 'Converted price' from ProductDetails, Sales.CurrencyRate
where Sales.CurrencyRate.ToCurrencyCode=@CurrencyCode and Sales.CurrencyRate.CurrencyRateDate=@Date

--open function
select * from fn_GetProductDetails(43668,'ARS','2005-07-01 00:00:00.000')