------ SUB QUERY AND ITS TYPE------


USE HMBank
GO


--1: Retrieve the customer(s) with the highest account balance.

SELECT TOP 1 C.CustomerID, C.FirstName, C.LastName, A.Balance
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID
ORDER BY A.Balance DESC


SELECT C.CustomerID, C.FirstName, C.LastName, A.Balance
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID
WHERE A.Balance = (
  SELECT MAX(Balance)
  FROM Accounts
)


--2: Calculate the average account balance for customers who have more than one account.

SELECT CustomerID
  FROM Accounts
  GROUP BY CustomerID
  HAVING COUNT(AccountID) > 1

SELECT CustomerID, AVG(Balance) AS AverageBalance
FROM Accounts 
GROUP BY CustomerID
HAVING COUNT(AccountID) > 1

select * from Accounts


--3: 1. Retrieve accounts with transactions whose amounts exceed the average transaction amount.

SELECT A.AccountID, T.TransactionDate, T.Amount
FROM Accounts A
JOIN Transactions T ON A.AccountID = T.AccountID
WHERE T.Amount > (
  SELECT AVG(Amount)
  FROM Transactions
)



--4: Identify customers who have no recorded transactions.

SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C JOIN Accounts A ON A.CustomerID = C.CustomerID
WHERE A.AccountID NOT IN (
  SELECT T.AccountID
  FROM Transactions T
  )


select * from Transactions


--5: Calculate the total balance of accounts with no recorded transactions.

SELECT AccountID, SUM(A.Balance) AS TotalBalance
FROM Accounts A 
WHERE A.AccountID NOT IN (
  SELECT T.AccountID
  FROM Transactions T
)
GROUP BY AccountID


--6: Retrieve transactions for accounts with the lowest balance.

SELECT T.*
FROM Transactions T
JOIN Accounts A ON T.AccountID = A.AccountID
WHERE A.Balance = (SELECT MIN(Balance) FROM Accounts)


--7: Identify customers who have accounts of multiple types.

SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(DISTINCT A.AccountType) > 1


SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
WHERE C.CustomerID IN (
  SELECT A.CustomerID
  FROM Accounts A
  GROUP BY A.CustomerID
  HAVING COUNT(DISTINCT A.AccountType) > 1
)


--8: Calculate the percentage of each account type out of the total number of accounts.

select count(AccountType) from Accounts
group by AccountType

SELECT AccountType, COUNT(AccountType) AS Count,
  COUNT(*)*100.0 / (SELECT COUNT(*) FROM Accounts) AS Percentage
FROM Accounts 
GROUP BY AccountType


--9: Retrieve all transactions for a customer with a given customer_id.

SELECT T.* 
FROM Transactions T
WHERE T.AccountID IN (
SELECT A.AccountID
FROM Accounts A
WHERE A.CustomerID = 7
)


--10: Calculate the total balance for each account type, including a subquery within the SELECT clause

SELECT A.AccountType, (
SELECT SUM(B.Balance) 
FROM Accounts B
WHERE B.AccountType = A.AccountType
) AS TotalBalance
FROM Accounts A
GROUP BY A.AccountType