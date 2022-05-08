using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using ADO_Example.Models;
namespace ADO_Example.DAL
{
    public class Product_DAL
    {
        string conString = ConfigurationManager.ConnectionStrings["adoConnectionString"].ToString();
        // Get All PRoducts
        public List<Product> GetAllProducts()
            {
            List<Product> productList = new List<Product>();
            using (SqlConnection connection = new SqlConnection(conString)) 
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "sp_GetAllProduct";
                SqlDataAdapter sqlDA = new SqlDataAdapter(command);
                DataTable dtProducts = new DataTable();

                connection.Open();
                sqlDA.Fill(dtProducts);
                connection.Close();

                foreach (DataRow dr in dtProducts.Rows)
                {
                    productList.Add(new Product
                    {
                        ProductID = Convert.ToInt32(dr["ProductID"]),
                        ProductName = dr["ProductName"].ToString(),
                        Price = Convert.ToInt64 (dr["Price"]),
                        Qty = Convert.ToInt32(dr["Qty"]),
                        Remarks = dr["Remarks"].ToString()
                    });
                }

            }
             
            return productList;
            }

        public int InsertProduct(Product product)
        {
            int id = 0;
            using (SqlConnection connection=new SqlConnection(conString))
            {
                SqlCommand sqlCommand = new SqlCommand("sp_InsertProduct");
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@ProductName", product.ProductName);
                sqlCommand.Parameters.AddWithValue("@Price", product.Price);
                sqlCommand.Parameters.AddWithValue("@Qty", product.Qty);
                sqlCommand.Parameters.AddWithValue("@Remarks", product.Remarks);
                sqlCommand.Connection = connection;
                connection.Open();
                id = sqlCommand.ExecuteNonQuery();
                connection.Close();
            }
            return id;
        }

        // Get PRoducts by ID
        public List<Product> GetProductByID(int id)
        {
            List<Product> productList = new List<Product>();
            using (SqlConnection connection = new SqlConnection(conString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "sp_GetProductByID";
                command.Parameters.AddWithValue("@ProductID", id);
                SqlDataAdapter sqlDA = new SqlDataAdapter(command);
                DataTable dtProducts = new DataTable();

                connection.Open();
                sqlDA.Fill(dtProducts);
                connection.Close();

                foreach (DataRow dr in dtProducts.Rows)
                {
                    productList.Add(new Product
                    {
                        ProductID = Convert.ToInt32(dr["ProductID"]),
                        ProductName = dr["ProductName"].ToString(),
                        Price = Convert.ToInt64(dr["Price"]),
                        Qty = Convert.ToInt32(dr["Qty"]),
                        Remarks = dr["Remarks"].ToString()
                    });
                }

            }

            return productList;
        }

        public bool UpdateProduct(Product product)
        {
            int id = 0;
            using (SqlConnection connection = new SqlConnection(conString))
            {
                SqlCommand sqlCommand = new SqlCommand("sp_UpdateProduct");
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@ProductID", product.ProductID);
                sqlCommand.Parameters.AddWithValue("@ProductName", product.ProductName);
                sqlCommand.Parameters.AddWithValue("@Price", product.Price);
                sqlCommand.Parameters.AddWithValue("@Qty", product.Qty);
                sqlCommand.Parameters.AddWithValue("@Remarks", product.Remarks);
                sqlCommand.Connection = connection;
                connection.Open();
                id = sqlCommand.ExecuteNonQuery();
                connection.Close();
            }
            return id>0;
        }
        public string DeleteProduct(int id)
        {
            string res = "";

            using (SqlConnection connection=new SqlConnection(conString))
            {
                SqlCommand command = new SqlCommand("sp_DeleteProduct",connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@ProductID", id);
                command.Parameters.Add("@ReturnMessage", SqlDbType.VarChar,50).Direction=ParameterDirection.Output;

                connection.Open();
                command.ExecuteNonQuery();
                res = command.Parameters["@ReturnMessage"].Value.ToString();
                connection.Close();

            }

            return res;
        }

    }
}