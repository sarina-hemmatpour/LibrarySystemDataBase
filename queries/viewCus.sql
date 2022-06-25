use [Clothing Strore] 
go

create view CustomerV (PName,PPrice,CatTitle)
	as select Product.PName,Product.PPrice , Category.CatTitle
	from Product , Category
	where (Product.PQuantity>0) and Product.CatId=Category.CatId