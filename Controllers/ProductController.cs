using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ADO_Example.DAL;
using ADO_Example.Models;

namespace ADO_Example.Controllers
{ 
    public class ProductController : Controller
    {
        Product_DAL product_DAL = new Product_DAL();
        // GET: Product
        public ActionResult Index()
        {
            var productList = product_DAL.GetAllProducts();
            if (productList.Count==0)
            {
                TempData["im"] = "Currently product not available in the Database...!";
            }

            return View(productList);
        }

        // GET: Product/Details/5
        public ActionResult Details(int id)
        {
            try
            {
                var products = product_DAL.GetProductByID(id).FirstOrDefault();
                if (products == null)
                {
                    TempData["em"] = "No product with id " + id;
                    return RedirectToAction("Index");
                }

                return View(products);
            }
            catch (Exception ex)
            {
                TempData["em"] = ex.Message;
                return View();
            }
        }

        // GET: Product/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Product/Create
        [HttpPost]
        public ActionResult Create(Product product)
        {
           int id = 0;
            try
            {
                if (ModelState.IsValid)
                {
                    id = product_DAL.InsertProduct(product);
                    if (id > 0)
                    {
                        TempData["sm"] = "Product details saved successfully...!";
                    }
                    else
                    {
                        TempData["em"] = "Unable to save product details.";
                    }
                }
                if (id>0)
                {
                return RedirectToAction("Index");

                }
                else
                {
                return View();

                }
            }
            catch (Exception ex)
            {
                TempData["em"] =ex.Message ;
                return View();
            }

         }

        // GET: Product/Edit/5
        public ActionResult Edit(int id)
        {
            var product = product_DAL.GetProductByID(id).FirstOrDefault();
            if (product ==null)
            {
                TempData["em"] = "No product with id " + id;
                return RedirectToAction("Index");
            }
            return View(product);
        }   

        // POST: Product/Edit/5
        [HttpPost,ActionName("Edit")]
        public ActionResult UpdateProduct(Product product)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    bool isUpdated = product_DAL.UpdateProduct(product);
                    TempData["sm"] = "Product details update successfully...!";
                }
                else
                {
                    TempData["em"] = "Unable to update product details.";

                }

                return RedirectToAction("index");

            }
            catch (Exception ex)
            {
                TempData["em"] = ex.Message;
                return View();
            }
        }

        // GET: Product/Delete/5
        public ActionResult Delete(int id)
        {
            try
            {
                var product = product_DAL.GetProductByID(id).FirstOrDefault();
                if (product == null)
                {
                    TempData["em"] = "Product not available with id " + id.ToString();//  & " not available.";
                    return RedirectToAction("Index");
                }
                return View(product);
            }
            catch (Exception ex)
            {
                TempData["em"] = ex.Message;
                return View();
            }
        }

        // POST: Product/Delete/5
        [HttpPost,ActionName("Delete")]
        public ActionResult DeleteConfirmation(int id )
        {
            try
            {
                string res = product_DAL.DeleteProduct(id);
                if (res.Contains("deleted"))
                {
                    TempData["sm"] =res;
                }
                else
                {
                    TempData["em"] =res;
                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["em"] = ex.Message;
                return View();
            }
        }
    }
}
