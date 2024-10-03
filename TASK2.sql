-----SELECT, WHERE, BETWEEN, AND, LIKE------


insert into Customers (FirstName, LastName, DOB, Email, PhoneNumber, Adress)
values
('Rohan', 'Sharma', '1990-01-12', 'rohan.sharma@example.com', '9812345678', 'Delhi'),
('Priya', 'Jain', '1991-08-25', 'priya.jain@example.com', '9998887774', 'Mumbai'),
('Karan', 'Singh', '1992-03-10', 'karan.singh@example.com', '9876543210', 'Bangalore'),
('Aisha', 'Kumar', '1993-11-02', 'aisha.kumar@example.com', '9333222111', 'Hyderabad'),
('Rahul', 'Gupta', '1994-05-15', 'rahul.gupta@example.com', '9555443322', 'Chennai'),
('Sonia', 'Rao', '1995-09-28', 'sonia.rao@example.com', '9777446611', 'Kolkata'),
('Vikram', 'Patel', '1996-02-20', 'vikram.patel@example.com', '9666338811', 'Ahmedabad'),
('Nalini', 'Shah', '1997-07-01', 'nalini.shah@example.com', '9887766554', 'Pune'),
('Rajesh', 'Joshi', '1998-04-12', 'rajesh.joshi@example.com', '9222110099', 'Lucknow'),
('Deepa', 'Chandra', '1999-06-25', 'deepa.chandra@example.com', '9444888222', 'Jaipur')

select * from Customers

insert into Accounts (CustomerID, AccountType, Balance)
values
(4, 'current', 20000.00),
(5, 'savings', 100000.00),
(6, 'current', 50000.00),
(7, 'savings', 150000.00),
(8, 'current', 100000.00),
(9, 'savings', 200000.00),
(10, 'current', 150000.00),
(11, 'savings', 250000.00),
(12, 'current', 200000.00),
(13, 'savings', 300000.00)

select * from Accounts

insert into Transactions (AccountID, TransactionType, Amount, TransactionDate)
values
(1, 'deposit', 50000.00, '2022-01-01'),
(2, 'withdrawal', 20000.00, '2022-01-15'),
(3, 'deposit', 100000.00, '2022-02-01'),
(4, 'transfer', 50000.00, '2022-03-01'),
(5, 'withdrawal', 100000.00, '2022-04-01'),
(6, 'deposit', 150000.00, '2022-05-01'),
(7, 'transfer', 100000.00, '2022-06-01'),
(8, 'withdrawal', 150000.00, '2022-07-01'),
(9, 'deposit', 200000.00, '2022-08-01'),
(10, 'transfer', 150000.00, '2022-09-01')


select * from Transactions



--1: Retrieve name, account type, and email of all customers

SELECT C.FirstName, C.LastName, A.AccountType, C.Email
FROM Customers C, Accounts A
WHERE C.CustomerID = A.CustomerID
--OR--
SELECT C.FirstName, C.LastName, A.AccountType, C.Email
FROM Customers C JOIN Accounts A 
ON C.CustomerID = A.CustomerID


--2 List all transactions corresponding to customers

SELECT C.FirstName, C.LastName, T.TransactionType, T.Amount, T.TransactionDate
FROM Customers C
JOIN Accounts A ON C.CustomerID = A.CustomerID
JOIN Transactions T ON A.AccountID = T.AccountID


--3: Increase balance of a specific account

UPDATE Accounts
SET balance = balance + 1000.00
WHERE AccountID = 1


--4: Combine first and last names as full_name

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers


--5: Remove accounts with zero balance (savings)

DELETE FROM Accounts
WHERE AccountType = 'savings' AND balance = 0


--6:  Find customers living in a specific city

SELECT *
FROM Customers
WHERE Adress LIKE '%Delhi%'


--7: Get account balance for a specific account

SELECT Balance
FROM Accounts
WHERE AccountID = 1


--8: List current accounts with balance > $1,000

SELECT *
FROM Accounts
WHERE AccountType = 'current' AND Balance > 10000.00


--9: Retrieve transactions for a specific account

SELECT *
FROM Transactions
WHERE AccountID = 1


--10: Calculate interest on savings accounts

SELECT AccountID, Balance * 0.05 AS Interest
FROM Accounts
WHERE AccountType = 'savings'


--11:  Identify accounts below overdraft limit

SELECT *
FROM Accounts
WHERE balance < 150000.00


--12: Find customers not living in a specific city

SELECT *
FROM Customers
WHERE Adress NOT LIKE '%Delhi%'