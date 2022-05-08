alter proc [dbo].[sp_UpdateProduct]
(
@ProductID int,
@ProductName nvarchar(50),
@Price decimal(8,2),
@Qty int,
@Remarks nvarchar(50)=null
)
as

begin
begin try
   begin tran
       update dbo.tbl_ProductMaster 
		   set 
		   ProductName	= @ProductName,
		   Price		= @Price,
		   Qty			= @Qty,
		   Remarks		= @Remarks 
	   where ProductID=@ProductID
   commit tran
end try
begin catch
   rollback tran
   select   ERROR_MESSAGE()
end catch
end
