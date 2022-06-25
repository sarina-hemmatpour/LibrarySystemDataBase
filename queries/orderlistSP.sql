use [Clothing Strore] 
go


--رویه: لیست سفارشات ارسال نشده ی کاربر ورودی

create procedure OrderList @CustomerId int
as 
	select table1.PId , PName , PQuantity
	from ((select PID , CPQuantity from CP
					where @CustomerId=CUserName and CPIsSent=0) as table1 
					inner join Product
					on table1.PId=Product.PId);