-- Show Customers (their full names, customer ID, and country) who are not in the US. (Hint: != or <> can be 
    -- used to say "is not equal to").
SELECT
    FirstName || ' ' || LastName AS Name, -- || concatenates 2 strings instead of using CONCAT()
    CustomerId,
    Country
FROM chinook.customers
WHERE country != 'USA';

-- Show only the Customers from Brazil.
SELECT
    CustomerId,
    LastName
FROM chinook.customers
WHERE Country = 'Brazil';

-- Find the Invoices of customers who are from Brazil. The resulting table should show the customer's full name, 
    -- Invoice ID, Date of the invoice, and billing country.
SELECT
    cust.FirstName || ' ' || cust.LastName AS 'Name',
    inv.InvoiceId AS 'Invoice',
    DATE(inv.InvoiceDate) AS 'Date',
    inv.BillingCountry AS 'Country'
FROM customers cust
LEFT JOIN invoices inv
ON cust.CustomerID = inv.CustomerId
WHERE cust.Country = 'Brazil';

-- Show the Employees who are Sales Agents.
SELECT *
FROM employees
WHERE Title = 'Sales Support Agent'

-- Find a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry
FROM invoices;

-- Provide a query that shows the invoices associated with each sales agent. The resulting table should include 
    -- the Sales Agent's full name.
-- need to join invoices, employees, and customers tables
    -- customers.SupportRepId, employees.LastName & employees.FirstName, invoices.InvoiceId

SELECT
    employees.FirstName ||' ' || employees.LastName AS 'Sales Rep',
    invoices.InvoiceId AS 'Invoice ID'
FROM employees
JOIN customers
ON employees.EmployeeId = customers.SupportRepId
JOIN invoices
ON invoices.CustomerId = customers.CustomerId;
-- Show the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers.
SELECT
    invoices.InvoiceId AS 'Invoice ID',
    invoices.Total AS 'Invoice Total',
    customers.FirstName || ' ' || customers.LastName AS 'Customer',
    customers.Country AS 'Customer Country',
    employees.FirstName || ' ' || employees.LastName AS 'Sales Rep'
FROM customers
LEFT JOIN invoices
ON customers.CustomerId = invoices.CustomerId
LEFT JOIN employees
ON customers.SupportRepId = employees.EmployeeId

-- How many Invoices were there in 2009?
SELECT COUNT(InvoiceDate)
FROM invoices
WHERE InvoiceDate LIKE '2009%';

-- What are the total sales for 2009?
SELECT ROUND(SUM(Total), 2)
FROM invoices
WHERE InvoiceDate LIKE '2009%';

-- Write a query that includes the purchased track name with each invoice line ID.
SELECT
    items.InvoiceLineId,
    tracks.Name
FROM invoice_items items
LEFT JOIN tracks
ON items.TrackId = tracks.TrackId
ORDER BY items.InvoiceLineID;

-- Write a query that includes the purchased track name AND artist name with each invoice line ID.
SELECT
    tracks.Name AS 'Track',
    artists.Name AS 'Artist',
    invoice_items.InvoiceLineId AS 'Invoice Line ID'
FROM tracks
JOIN invoice_items
ON invoice_items.TrackId = tracks.TrackId
JOIN albums
ON tracks.AlbumId = albums.AlbumId
JOIN artists
ON albums.ArtistId = artists.ArtistId
ORDER BY 3;

-- Provide a query that shows all the Tracks, and include the Album name, Media type, and Genre.
SELECT
   tracks.Name AS 'track',
   albums.Title AS 'album', 
   media_types.Name AS 'media type', 
   genres.Name AS 'genre'
FROM tracks
JOIN albums
ON tracks.AlbumId = albums.AlbumId
JOIN media_types
ON tracks.MediaTypeId = media_types.MediaTypeId
JOIN genres
ON tracks.GenreId = genres.GenreId;

-- Show the total sales made by each sales agent.
SELECT
    employees. FirstName || ' ' || employees.LastName AS 'Sales Agent',
    ROUND(SUM(invoices.Total), 2) AS 'Total Sales'
FROM customers
JOIN employees
ON customers.SupportRePId = employees.EmployeeId
JOIN invoices
ON invoices.CustomerId = customers.CustomerId
GROUP BY 1
ORDER BY 2 DESC;

-- Which sales agent made the most dollars in sales in 2009?
SELECT
    employees. FirstName || ' ' || employees.LastName AS 'Sales Agent',
    ROUND(SUM(invoices.Total), 2) AS 'Total Sales'
FROM customers
JOIN employees
ON customers.SupportRepId = employees.EmployeeId
JOIN invoices
ON invoices.CustomerId = customers.CustomerId
WHERE invoices.InvoiceDate LIKE '2009%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;