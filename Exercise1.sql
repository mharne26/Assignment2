/*1.	Display the number of records in the [SalesPerson] table. (Schema(s) involved: Sales)*/
 select count(*) from sales.SalesPerson
/*

2.	Select both the FirstName and LastName of records from the Person table where the FirstName begins with the letter ‘B’. (Schema(s) involved: Person)
*/
 select FirstName , LastName  from person.Person where FirstName like 'B%'

/*3. Select a list of FirstName and LastName for employees where Title is one of Design Engineer, Tool Designer or Marketing Assistant. (Schema(s) involved: HumanResources, Person)*/
select p.FirstName,p.LastName from Person.Person as p ,HumanResources.Employee as e where p.BusinessEntityID=e.BusinessEntityID and e.JobTitle in('Design Engineer', 'Tool Designer','Marketing Assistant')

/*4. Display the Name and Color of the Product with the maximum weight. (Schema(s) involved: Production)*/
select p.Name,p.Color from Production.Product as p where p.Weight = (select max(weight) from Production.Product)

/*5. Display Description and MaxQty fields from the SpecialOffer table. Some of the MaxQty values are NULL, in this case display the value 0.00 instead. (Schema(s) involved: Sales)*/
select Description,COALESCE(MaxQty,0.00) from Sales.SpecialOffer

/*6. Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ for the year 2005 i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’. Note: The field [CurrencyRate].[AverageRate] is defined as 'Average exchange rate for the day.' (Schema(s) involved: Sales)*/
select AVG(AverageRate) as 'Average exchange rate for the day' from Sales.CurrencyRate where FromCurrencyCode='USD' 
AND ToCurrencyCode = 'GBP' AND YEAR(CurrencyRateDate) = 2005;
/*7. Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. Display an additional column with sequential numbers for each row returned beginning at integer 1. (Schema(s) involved: Person)*/
select ROW_NUMBER() over(order by FirstName, LastName) as 'Sr.no',FirstName,LastName from Person.Person 
where FirstName like '%ss%'
/*8. Display the [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band as above.*/
select BusinessEntityID as 'SalesPersonID' ,
	case WHEN CommissionPct = 0.0 then 'Band 0'
		WHEN CommissionPct > 0.0 AND CommissionPct <=0.01 then 'BAND 1'
		WHEN CommissionPct > 0.01 AND CommissionPct <=0.015 then 'BAND 2'
		WHEN CommissionPct > 0.015 then 'BAND 3'
		END AS 'Commission Band'
FROM Sales.SalesPerson;
/*9.Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez. Hint: use [uspGetEmployeeManagers] (Schema(s) involved: [Person], [HumanResources]) */
DECLARE @ID int;
SELECT @ID = BusinessEntityID
FROM Person.Person 
WHERE FirstName = 'Ruth' 
	AND LastName = 'Ellerbrock'
	AND PersonType = 'EM';
EXEC dbo.uspGetEmployeeManagers @BusinessEntityID = @ID;
/*10.10.	Display the ProductId of the product with the largest stock level. Hint: Use the Scalar-valued function [dbo]. [UfnGetStock]. (Schema(s) involved: Production)*/
SELECT MAX(dbo.ufnGetStock(ProductID)) as 'Product with largest stock level' FROM Production.Product;