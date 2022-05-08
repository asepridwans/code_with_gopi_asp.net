create proc sp_InsertProduct
(
@ProductName nvarchar(50),
@Price decimal(8,2),
@Qty int,
@Remarks nvarchar(50)=null
)
as

begin
begin try
   begin tran
	   insert into dbo.tbl_ProductMaster(ProductName,Price,Qty,Remarks)
	   values(@ProductName,@Price,@Qty,@Remarks)
   commit tran
end try
begin catch
   rollback tran
   select   ERROR_MESSAGE()
end catch
end
