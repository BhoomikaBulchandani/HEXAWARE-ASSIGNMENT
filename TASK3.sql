-----Aggregate Functions, GroupBy, Having, OrderBy and Joins----

use HMBank
go

--1: Average account balance for all customers

SELECT AVG(Balance) AS AvgBalance
FROM Accounts


--2: Top 10 highest account balances

SELECT Top 10 AccountID, CustomerID, Balance
FROM Accounts
ORDER BY Balance DESC


--3: Total deposits for all customers on a specific date

SELECT SUM(Amount) AS TotalDdeposits
FROM Transactions
WHERE TransactionType = 'deposit' AND TransactionDate = '2022-01-01'


--4: Oldest and newest customers

SELECT TOP 1 FirstName, LastName, DOB
FROM Customers
ORDER BY DOB ASC  -- Oldest

SELECT Top 1 FirstName, LastName, DOB
FROM Customers
ORDER BY DOB DESC  -- Newest


--5: Transaction details with account type

SELECT T.TransactionID, T.TransactionType, T.Amount, A.AccountType
FROM Transactions T
JOIN Accounts A ON T.AccountID = A.AccountID


--6: Customers with account details

SELECT C.FirstName, C.LastName, A.AccountID, A.AccountType, A.Balance
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID


--7: Transaction details with customer info for a specific account

SELECT T.TransactionID, T.TransactionType, T.Amount, C.FirstName, C.LastName, C.Email, C.PhoneNumber, C.Adress
FROM Transactions T
JOIN Accounts A ON T.AccountID = A.AccountID
JOIN Customers C ON A.CustomerID = C.CustomerID
WHERE A.AccountID = 1


--8: Customers with more than one account


select * from Accounts

SELECT C.FirstName, C.LastName, COUNT(A.AccountID) AS NumAccounts
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(A.AccountID) > 1


--9: Difference between deposit and withdrawal amounts 

--- TO BE DONE BY SUBQUERY

SELECT  
  (SELECT SUM(amount) FROM Transactions WHERE TransactionType = 'deposit') as TotalDeposit,  
   (SELECT SUM(amount) FROM Transactions WHERE TransactionType = 'withdrawal') as TotalWithdrawal,
  (SELECT SUM(amount) FROM Transactions WHERE TransactionType = 'deposit') - 
  (SELECT SUM(amount) FROM Transactions WHERE TransactionType = 'withdrawal') AS Difference


--10: Average daily balance for each account over a specified period

SELECT A.AccountID, AVG(T.amount) AS AvgDailyBalance
FROM Accounts A
JOIN Transactions T ON A.AccountID = T.AccountID
WHERE T.TransactionDate between '2022-01-01' and '2022-09-01'
GROUP BY A.AccountID


--11: Total balance for each account type

SELECT AccountType, SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType


--12: Accounts with highest number of transactions

SELECT A.AccountID, COUNT(T.AccountID) AS NumTransactions
FROM Accounts A
JOIN Transactions T ON A.AccountID = T.accountId
GROUP BY A.AccountID
ORDER BY NumTransactions DESC


--13: Customers with high aggregate account balances

SELECT C.CustomerID, C.FirstName, C.LastName, SUM(A.Balance) AS TotalBalance
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalBalance DESC


--14: Duplicate transactions

select * from Transactions


select  count(TransactionDate), Amount, AccountId, TransactionType 
from Transactions 
group by Amount, AccountId, TransactionType
order by AccountID, TransactionType

SELECT AccountID, TransactionDate, Amount
FROM Transactions										-----teacher resolved, without join
GROUP BY AccountID, TransactionDate, Amount
HAVING COUNT(*) > 1

SELECT T1.TransactionID, T1.AccountID, T1.TransactionType, T1.Amount, T1.TransactionDate
FROM Transactions T1
JOIN Transactions T2 ON T1.AccountID = T2.AccountID					----- with inner join
  AND T1.TransactionType = T2.TransactionType 
  AND T1.amount = T2.amount 
  AND T1.TransactionDate = T2.TransactionDate
WHERE T1.TransactionID < T2.TransactionID


