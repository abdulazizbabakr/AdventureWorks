-- Sales person YTD sales

	select
		BusinessEntityID,
		TerritoryID,
		SalesQuota,
		Bonus,
		CommissionPct,
		SalesYTD,
		SalesLastYear,
		[Total YTD Sales] = SUM(salesYTD) over(),
		[Max YTD Sales] = MAX(salesYTD) over(),
		[% of Best Performer] = (SalesYTD/MAX(salesYTD) over()) * 100
	from AdventureWorks2019.Sales.SalesPerson


-- Personnel Rates comparison
	select
		A.FirstName,
		A.LastName,
		B.JobTitle,
		C.Rate,
		AVG(c.rate) over() as AverageRate,
		MAX(c.rate) over() as MaximumRate,
		c.Rate - AVG(c.rate) over() as DiffFromAvgRate,
		(c.Rate / MAX(c.rate) over()) * 100 as PercentofMaxRate
	from 
		AdventureWorks2019.Person.Person a
			join HumanResources.Employee b
				on a.BusinessEntityID = b.BusinessEntityID

			join AdventureWorks2019.HumanResources.EmployeePayHistory c
				on a.BusinessEntityID = c.BusinessEntityID

-------------------------

-- Sum of line totals

	Select
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal,
	ProductIDLineTotal = sum(linetotal) over( partition by ProductID, OrderQty)
	from
		[AdventureWorks2019].[Sales].[SalesOrderDetail]

	order by
		ProductID, OrderQty desc


-- Product vs Category Delta
	select
		A.Name as ProductName,
		A.ListPrice,
		B.Name as ProductSubcategory,
		C.Name as ProductCategory,
		AVG(A.ListPrice) over(partition by C.Name) as AvgPriceByCategory,
		AVG(A.ListPrice) over(partition by C.Name, B.Name) as AvgPriceByCategoryAndSubcategory,
		(A.ListPrice - AVG(A.ListPrice) over(partition by C.Name)) as ProductVsCategoryDelta 

	from 
		AdventureWorks2019.Production.Product A
			join AdventureWorks2019.Production.ProductSubcategory B
				on A.ProductSubcategoryID = B.ProductSubcategoryID

			join AdventureWorks2019.Production.ProductCategory C
				on B.ProductCategoryID = C.ProductCategoryID

-------------------------


-- Sum of line totals by sales order ID

	select
		SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		SalesOrderIDLineTotal = sum([LineTotal]) over (partition by SalesOrderID)
	from 
		[AdventureWorks2019].[Sales].[SalesOrderDetail]

	order by
		SalesOrderID

-- Ranking all records within each group of sales order IDs

	select
		SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		SalesOrderIDLineTotal = sum([LineTotal]) over (partition by SalesOrderID),
		Ranking = ROW_NUMBER() over (order by LineTotal desc)

	from 
		[AdventureWorks2019].[Sales].[SalesOrderDetail]

	order by
		5	


-- Price Ranking

	select
		A.name as ProductName,
		A.ListPrice,
		B.name as ProductSubcategory,
		C.name as ProductCategory,
		[Price Rank] = ROW_NUMBER() over( order by a.ListPrice desc),
		[Category Price Rank] = ROW_NUMBER() over( partition by c.name order by a.ListPrice desc),
		[Top 5 Price In Category] =
			CASE 
				when 
					ROW_NUMBER() over( partition by c.name order by a.ListPrice desc) <= 5 then 'Yes'
				else 'No'
			end 

	from
		[AdventureWorks2019].[Production].[Product] A
			join AdventureWorks2019.Production.ProductSubcategory B
				on A.ProductSubcategoryID = B.ProductSubcategoryID

			join AdventureWorks2019.Production.ProductCategory C
				on B.ProductCategoryID = C.ProductCategoryID

-- Ranking all records by line totals - no groups

	select
		SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		Ranking = ROW_NUMBER() over (partition by SalesOrderID order by LineTotal desc),
		[Ranking with Rank] = RANK() over (partition by SalesOrderID order by LineTotal desc),
		[Ranking with Dense_Rank] = DENSE_RANK() over (partition by SalesOrderID order by LineTotal desc)

	from 
		[AdventureWorks2019].[Sales].[SalesOrderDetail]

	order by
		SalesOrderID, LineTotal desc

-- Ranking

	select
		A.name as ProductName,
		A.ListPrice,
		B.name as ProductSubcategory,
		C.name as ProductCategory,
		[Price Rank] = ROW_NUMBER() over( order by a.ListPrice desc),
		[Category Price Rank] = ROW_NUMBER() over( partition by c.name order by a.ListPrice desc),
		[Category Price Rank With Rank] = RANK() over( partition by c.name order by a.ListPrice desc),
		[Category Price Rank With Dense Rank] = Dense_RANK() over( partition by c.name order by a.ListPrice desc),
		[Top 5 Price In Category] =
			CASE 
				when 
					Dense_Rank() over( partition by c.name order by a.ListPrice desc) <= 5 then 'Yes'
				else 'No'
			end

	from
		[AdventureWorks2019].[Production].[Product] A
			join AdventureWorks2019.Production.ProductSubcategory B
				on A.ProductSubcategoryID = B.ProductSubcategoryID

			join AdventureWorks2019.Production.ProductCategory C
				on B.ProductCategoryID = C.ProductCategoryID

----------------------

-- Lead and Lag Due	

	select
		SalesOrderID,
		OrderDate,
		CustomerID,
		TotalDue,
		[NextTotalDue] = LEAD(totaldue, 1) over(partition by CustomerID order by SalesOrderID),
		[PrevtotalDue] = lag(totaldue,1) over(partition by CustomerID order by SalesOrderID)
	from
		AdventureWorks2019.Sales.SalesOrderHeader

	order by
		3,1

-- Lead and Lag vendors

	select
		a.PurchaseOrderID,
		a.OrderDate,
		a.TotalDue,
		b.name as VendorName,
		[PrevOrderFromVendorAmt] = LAG(a.totaldue,1) over(partition by a.vendorID order by a.OrderDate),
		[NextOrderByEmployeeVendor] = lead(b.name) over( partition by a.employeeID order by a.OrderDate),
		[Next2OrderByEmployeeVendor] = lead(b.name,2) over( partition by a.employeeID order by a.OrderDate)
		
	from
		AdventureWorks2019.Purchasing.PurchaseOrderHeader a
		join Purchasing.Vendor b
			on a.VendorID = b.BusinessEntityID

	where
		a.TotalDue > 500 and 
		YEAR(a.OrderDate) >= 2013

	order by
	a.EmployeeID,
	a.OrderDate

-- All rank 1 of line total
	select 
		*
	from
		(
			select
				SalesOrderID,
				SalesOrderDetailID,
				LineTotal,
				[LineTotalRanking] = ROW_NUMBER() over( partition by SalesOrderID order by linetotal desc)

			from
				AdventureWorks2019.Sales.SalesOrderDetail
		) A

	where LineTotalRanking =1

-- Total Due Ranking

	select
		PurchaseOrderID,
		VendorID,
		OrderDate,
		TaxAmt,
		Freight,
		TotalDue
	from
		(
			select
				PurchaseOrderID,
				VendorID,
				OrderDate,
				TaxAmt,
				Freight,
				TotalDue,
				dense_rank() over( partition by vendorID order by totalDue desc) as PurchaseOrderRank

			from
				AdventureWorks2019.Purchasing.PurchaseOrderHeader
		) A

	where PurchaseOrderRank in (1,2,3)

-----------------------

-- Above Avg Prices

	select
		ProductID,
		Name,
		StandardCost,
		ListPrice,
		AvgListPrice = (select AVG(listprice) from AdventureWorks2019.Production.Product),
		AvgListPriceDiff = ListPrice - (select AVG(listprice) from AdventureWorks2019.Production.Product)
	from 
		AdventureWorks2019.Production.Product
	where
		ListPrice > (select AVG(listprice) from AdventureWorks2019.Production.Product)
	Order by
		4

-- Vacation Hours

	select
		BusinessEntityID,
		JobTitle,
		VacationHours,
		MaxVacationHours = (select MAX(VacationHours) from AdventureWorks2019.HumanResources.Employee),
		PercentOfMaxVacationHours = (VacationHours * 1.0) / (select MAX(VacationHours) from AdventureWorks2019.HumanResources.Employee)
	from
		AdventureWorks2019.HumanResources.Employee
	where (VacationHours * 1.0) / (select MAX(VacationHours) from AdventureWorks2019.HumanResources.Employee) >= 0.80

-------------------

-- Multi Order Count

	select
		SalesOrderID,
		OrderDate,
		SubTotal,
		TaxAmt,
		Freight,
		TotalDue,
		MultiOrderCount =
			(
				select
				COUNT(*)
				from
					AdventureWorks2019.Sales.SalesOrderDetail b
				where
					a.SalesOrderID = b.SalesOrderID
					AND b.OrderQty > 1
			)
	from
		AdventureWorks2019.Sales.SalesOrderHeader a

-- Non Rejected Items Count

	select
		PurchaseOrderID,
		VendorID,
		OrderDate,
		TotalDue,
		NonRejectedItems =
			(
				select
					count(*)
				from
					AdventureWorks2019.Purchasing.PurchaseOrderDetail b
				where
					a.PurchaseOrderID = b.PurchaseOrderID
					AND b.RejectedQty = 0
			),
		MostExpensiveItem =
			(
				select
					MAX(UnitPrice)
				from
					AdventureWorks2019.Purchasing.PurchaseOrderDetail b
				where a.PurchaseOrderID = b.PurchaseOrderID
			)
	from
		AdventureWorks2019.Purchasing.PurchaseOrderHeader a