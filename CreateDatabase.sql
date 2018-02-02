use master
go
drop database if exists PRSTEST
go
create database PRSTEST
go
use PRSTEST
go
drop table if exists PurchaseRequestLineItems
drop table if exists Product
drop table if exists PurchaseRequest
drop table if exists Vendor
drop table if exists [User]
go

create Table [User] (
	Id int primary key identity(1,1),
	UserName nvarchar(30) not null unique,
	Password nvarchar(30) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	Phone nvarchar(12),
	Email nvarchar(80),
	isReviewer bit not null default 0,
	isAdmin bit not null default 0
	Active bit not null default 1
)
go
create Table Vendor (
	Id int primary key identity(1,1),
	Code nvarchar(10) not null unique,
	Name nvarchar(30) not null,
	Address nvarchar(30) not null,
	City nvarchar(30) not null,
	State nvarchar(2) not null,
	Zip nvarchar(10) not null,
	Phone nvarchar(12),
	Email nvarchar(80),
	isRecommended bit not null default 0,
	Active bit not null default 1
)
go
create Table Product (
	Id int primary key identity(1,1),
	Name nvarchar(130) not null,
	VendorPartNumber nvarchar(50) not null,
	Price money not null,
	Unit nvarchar(10) not null,
	PhotoPath nvarchar(255),
	VendorId int not null foreign key references Vendor(Id),
	Active bit not null default 1
)
go
create Table PurchaseRequest (
	Id int primary key identity(1,1),
	Description nvarchar(80) not null,
	Justification nvarchar(255),
	DateNeeded date not null default DATEADD(wk, 1, GETDATE()),
	DeliveryMode nvarchar(25),
	Status nvarchar(10) not null default 'NEW',
	Total money not null,
	UserId int not null foreign key references [User](Id)
)
go
create Table PurchaseRequestLineItems (
	Id int primary key identity(1,1),
	PurchaseRequestId int not null foreign key references PurchaseRequest(Id),
	ProductId int not null foreign key references Product(Id),
	Quantity int not null default 1
)
go

insert into [User] (UserName, Password, FirstName, LastName, Phone, Email, isReviewer, isAdmin) values
	('mbaugus', 'test123', 'Mike', 'Baugus', '513-940-8435', 'mbaugus@gmail.com', 1, 1)
insert into [Vendor] (Code, Name, Address, City, State, Zip, Phone, Email, isRecommended, Active) values
	('USB', 'Union Savings Bank', '8534 E Kemper',
	 'Cincinnati', 'OH', '45203', '513-791-3400',
	  'info@usavingsbank.com', 1, 1 )

insert into [Product] (Name, VendorPartNumber, Price, Unit, PhotoPath, VendorId, Active) values
	('Pencils 50 pack', 'pencil2521', 4.99, 'single',
	 'https://www.photoplace.com/2323829893823.jpg',
	  1, 1)

insert into [PurchaseRequest] (Description, Justification, DeliveryMode, Total, UserId) values
	('I need a lot of pencils man', 'see description', 'UPS', 249.50, 1)

insert into [PurchaseRequestLineItems] (PurchaseRequestId, ProductId, Quantity) values
	(1, 1, 10)

select * from [User]
select * from [Vendor]
select * from [Product]
select * from [PurchaseRequest]
select * from [PurchaseRequestLineItems]