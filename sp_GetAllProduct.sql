create procedure sp_GetAllProduct
as 
begin

select ProductID,ProductName,Price,Qty,Remarks from dbo.tbl_ProductMaster with (nolock)

end;