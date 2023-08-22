# AdventureWorks

The provided queries cover a wide range of data manipulation and analysis tasks. Here's a brief description of the work done in each query:

1. **Sales Person YTD Sales**: Calculates various metrics related to salesperson performance, including YTD sales, bonus, commission percentage, etc.

2. **Personnel Rates Comparison**: Compares employee job titles, rates, and calculates various statistics like average and differences from average rates.

3. **Sum of Line Totals**: Computes aggregated line total values, grouped by product and order quantity.

4. **Product vs Category Delta**: Analyzes the price difference of products compared to the average price within their respective categories and subcategories.

5. **Sum of Line Totals by Sales Order ID**: Computes aggregated line total values for each sales order ID.

6. **Ranking All Records within Each Group of Sales Order IDs**: Ranks records within each sales order group based on their line total values.

7. **Price Ranking**: Ranks products based on their list prices, both overall and within categories.

8. **Ranking All Records by Line Totals - No Groups**: Ranks records by line total within each sales order ID.

9. **Ranking**: Ranks products based on list prices and provides additional ranking information within categories.

10. **Lead and Lag Due**: Uses the LEAD and LAG functions to show the next and previous total due values for sales orders.

11. **Lead and Lag Vendors**: Uses LEAD and LAG to show previous and next total due amounts for purchase orders, with additional vendor-related information.

12. **All Rank 1 of Line Total**: Lists records with line total ranking equal to 1 for each sales order ID.

13. **Total Due Ranking**: Ranks purchase orders based on total due amount, showing the top 3 ranked orders for each vendor.

14. **Above Avg Prices**: Lists products with list prices above the average list price, along with their cost and calculated differences.

15. **Vacation Hours**: Displays employees' vacation hours along with various statistics related to maximum vacation hours.

16. **Multi Order Count**: Displays the count of sales orders with more than one order quantity for each sales order ID.

17. **Non Rejected Items Count**: Shows purchase order details for each order, along with counts of non-rejected items and the most expensive item's unit price.

18. **Record ID without Duplicating**: Lists sales order header information where at least one associated sales order detail has a line total greater than 10000.

19. **Orders above 500Q and $50**: Lists purchase order header information where at least one associated purchase order detail has an order quantity greater than 500 and a unit price greater than 50.

20. **Records with RejectedQty**: Lists purchase order header information where no associated purchase order detail has a rejected quantity greater than 0.

21. **Jamming Total Lines by SalesOrderID**: Concatenates line total values for each sales order ID into a single column.

22. **Jamming Total Lines by ListPrice**: Concatenates product names based on their subcategory and list price greater than 50.

23. **Pivoting LineTotal**: Uses PIVOT to summarize line total values based on product categories.

24. **Pivoting Avg VacationHours**: Uses PIVOT to summarize average vacation hours based on job titles.

25. **Comparison between Each Month's Total Sum of Top 10 Orders against Previous Month's**: Compares total top 10 order amounts for each month against the previous month's values.

26. **Sum of Sales and Purchases Excluding Top10**: Compares total sales and purchase amounts (excluding top 10) side by side for each month.

27. **Generating Date Series**: Creates a temporary table with a date series for data analysis purposes.

28. **Recursive FirstDayofMonth**: Creates a temporary table with the first day of each month in a recursive manner.

29. **Temp Tables for EDA Purposes**: Utilizes temporary tables to store and manipulate data for exploratory data analysis (EDA).

30. **Updating Temp Tables if Needed Based on "Holiday vs Non-Holiday"**: Updates values in a temporary table based on a certain condition (holiday vs non-holiday).

31. **Updating Temp Tables if Needed Based on "CONCAT OrderCategory + OrderAmtBucket"**: Updates values in a temporary table by concatenating two columns.

32. **Optimizing Data When Needed**: Utilizes temporary tables to optimize and store data efficiently for analysis.

33. **Lookup Tables "Creating a Calendar Table"**: Creates a calendar table for date-related analysis.

34. **Variable #1 "Getting Data for Previous Month"**: Uses variables to calculate and select data for the previous month.

Please note that these descriptions provide an overview of the queries' objectives. The exact interpretation may vary based on the context of the database schema and the specific data used in the queries.
