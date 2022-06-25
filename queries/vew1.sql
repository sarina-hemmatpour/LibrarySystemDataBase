use [Clothing Strore] 
go

--دید پشتیبان سایت
create view suportV (CUserName ,CPassword,CName ,CLastname 
					,CPhoneNumber ,CAddress ,CPostalCode,CEmail)
	as select Customer.CUserName ,Customer.CPassword,CName 
				,Customer.CLastname ,Customer.CPhoneNumber ,Customer.CAddress
				,Customer.CPostalCode,Customer.CEmail
	from Customer
