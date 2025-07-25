-- SQL ANALYSIS OF THE CHINOOK MUSIC STORE DATABASE


-- Question 1: What are the top 3 countries for sales?

SELECT BillingCountry,
sum(Total) AS TotalSales
FROM Invoice
Group by
BillingCountry
order by
TotalSales DESC
Limit 3;



-- Question 2: Which city has the highest sales?

SELECT BillingCity,
sum(Total) AS TotalSales
FROM Invoice
Group by
BillingCity
order by
TotalSales DESC
Limit 1;



-- Question 3: Who is our best customer?

SELECT 
CONCAT( c.FirstName , ' ' , c.LastName) AS Customer_Name,
sum(i.Total) AS Spend
FROM Customer as c
JOIN Invoice as i ON c.CustomerID = i.CustomerID
GROUP BY Customer_Name
Order by Spend DESC
Limit 1;



-- Question 4: Find all customers who listen to Rock music.

SELECT DISTINCT
c.Email,
c.FirstName,
c.LastName
FROM Customer as c
JOIN Invoice as i ON c.CustomerID = i.CustomerID
JOIN InvoiceLine as il ON i.InvoiceID = il.InvoiceID
JOIN Track as t ON il.TrackId = t.TrackId
JOIN Genre AS  g ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock';



-- Bonus Question 5: Which sales agent generated the most sales?

SELECT
CONCAT(e.FirstName, ' ', e.LastName) AS Agent_Name,
SUM(i.Total) AS Total_Sales
FROM Employee AS e
JOIN Customer AS c ON e.EmployeeId = c.SupportRepId
JOIN Invoice AS i ON c.CustomerId = i.CustomerId
WHERE e.Title = 'Sales Support Agent' 
GROUP BY Agent_Name
ORDER BY Total_Sales DESC;



-- Bonus Question 6: What is the average spend per customer?

SELECT 
AVG(TotalSpend) AS AverageSpend
FROM (
SELECT 
c.CustomerID,
SUM(i.Total) AS TotalSpend                  
FROM Customer AS c
JOIN Invoice AS i ON c.CustomerID = i.CustomerID
GROUP BY c.CustomerID
) AS CustomerSpend;



-- Bonus Question 7: What is the total number of tracks sold by genre?
SELECT
g.Name AS Genre,
COUNT(il.TrackId) AS TotalTracksSold
FROM InvoiceLine AS il
JOIN Track AS t ON il.TrackId = t.TrackId
JOIN Genre AS g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY TotalTracksSold DESC;

