use [Clothing Strore] 
go


--مسئول ارسال
create view postV (CName ,CLastname 
					,CPhoneNumber ,CAddress ,CPostalCode)
	as select CName ,CLastname ,CPhoneNumber 
				,CAddress ,CPostalCode
				from Customer
				where CUserName in (select distinct CUserName from CP
												where CPIsSent=0)