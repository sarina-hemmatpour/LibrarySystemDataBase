use [Clothing Strore] 
go


-- دسته بندی
create table Category(
	CatId int Not Null ,
	CatTitle varchar(50) not null

	PRIMARY KEY (CatId)
);





--تولید کننده
create table Supplier(
	SupId int Not null,
	SupBrand varchar(50) not null,
	SupAddress varchar(100) not null,
	SupSite varchar(100) not null,

	primary key(SupId)
);

create table SupProduct(
	SupId int Not null,
	SupPName varchar(50) not null ,

	primary key (SupId , SupPname),
	foreign key (SupId) references Supplier (SupId)
);





-- انبار
create table StoreRoom(
	SRId int not null,
	SRAddress varchar(100) not null,

	primary key(SRId)
);





--محصولات
create table Product(
	PId int not null,
	PName varchar(30) not null,
	PPrice int not null,
	CatId int Not Null ,
	SupId int Not null,
	SRId int not null,
	PQuantity int default 0 not null ,

	primary key(PId),
	foreign key (CatId) references Category (CatId),
	foreign key (SupId) references Supplier (SupId),
	foreign key (SRId) references StoreRoom (SRId),
	check (0<= PPrice and 0<=PQuantity)

);

create table PreviousPrice(
	PId int not null,
	PPAmount int not null ,

	primary key (PId , PPAmount),
	foreign key (PId) references Product (PId)
);




--مشتری
create table Customer(
	CUserName varchar(10) not null unique ,
	CPassword varchar(8) not null,
	CName varchar (30) not null,
	CLastname varchar (40) not null,
	CPhoneNumber varchar(13) not null,
	CAddress varchar(100) not null,
	CPostalCode varchar(10) not null,
	CEmail varchar(100),

	primary key (CUserName)
);




--کارمندان
create table Employee(
	EId int not null,
	EName varchar(30) not null,
	ELastname varchar(50) not null,
	ENationalCode varchar (20) not null,
	EPhoneNumber varchar(13) not null,
	EAddress varchar(100) not null,
	EEmail varchar(30) not null,
	ESalary int not null,
	EType varchar(15) ,

	primary key(EId),
	check( (EType in ('admin' , 'supporter' , 'post' ) )
			and (ESalary>0) )
);



--بن تخفیف 
create table Discount(
	DCode int not null,
	DPercentage int not null,
	EId int not null,

	primary key(DCode),
	foreign key(EId) references Employee(EId),
	check ( (0<DPercentage and DPercentage<=100))

);







--فاکتور
create table Receipt(
	RecID int not null,
	RecTotalAmount int not null,
	DCode int not null,
	RecPayment int not null,

	primary key (RecId),
	foreign key (DCode) references Discount (DCode),
	check (RecTotalAmount>0 and RecPayment>0 and RecPayment<RecTotalAmount )
);




--انتخاب 
create table CP(
	CUserName varchar(10) not null,
	PId int not null,
	CPIsSent int default 0 not null,
	CPQuantity int default 1 not null,
	CPTotalAmount int not null,

	primary key (CUserName,PId , CPIsSent),
	foreign key (CUserName) references Customer (CUserName),
	foreign key (PId) references Product (PId),
	check ( (CPIsSent=1 or CPIsSent=0) and (CPQuantity>=1) and (CPTotalAmount>0) )
);


