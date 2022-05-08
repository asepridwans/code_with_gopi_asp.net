exec sp_GetProductByID 16
exec sp_GetAllProduct 

create proc	sp_GetProductByID
(
@ProductID int
)
as
begin
   select 
			tbl_ProductMaster.ProductID,
			tbl_ProductMaster.ProductName,
			tbl_ProductMaster.Price,
			tbl_ProductMaster.Qty,
			tbl_ProductMaster.Remarks

	from	tbl_ProductMaster

	where	tbl_ProductMaster.ProductID=@ProductID

end


