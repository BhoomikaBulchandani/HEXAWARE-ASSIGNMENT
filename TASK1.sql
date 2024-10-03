------DATABASE DESIGN-----


create database HMBank
go

use HMBank
go

create table Customers
(CustomerID numeric(2) identity(1,1) primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
DOB date not null,
Email varchar(50) unique not null,
Adress varchar(100) not null)

sp_help Customers

alter table Customers
add PhoneNumber numeric(10)


create table Accounts
(AccountID numeric(2) identity(1,1) primary key,
CustomerID numeric(2) foreign key references Customers(CustomerID) not null,
AccountType varchar(20) not null,
constraint a_check check(AccountType in ('savings', 'current', 'zero_balance')),
Balance decimal(10,2) default 0.00 not null)

sp_help Accounts


create table Transactions
(TransactionID numeric identity(1,1) primary key,
AccountID numeric(2) not null foreign key references Accounts(AccountID),
TransactionType varchar(20) not null,
Amount decimal(10,2) not null,
TransactionDate date default getdate(),
constraint t_check check(TransactionType in ('deposit', 'withdrawal', 'transfer')))





