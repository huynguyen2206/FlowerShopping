using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class ProductsController : Controller
    {
        private ProductRepository productRepository = new ProductRepository();
        //private GenericRepository<Product> productRepository = new GenericRepository<Product>();
        private FlowerShoppingEntities db = new FlowerShoppingEntities();
        Products_Categories_Mapping p_c_m;

        // UPLOAD PICTURES
        public void UploadPicture(int id)
        {
            // tạo đường dẫn
            string path = Server.MapPath("~/Uploads/Products/") + id;
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            // add pictures
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFileBase file = Request.Files[i];
                string filename = file.FileName.Split('\\').Last();

                try
                {
                    file.SaveAs(path + "\\" + filename);

                    Picture pic = new Picture()
                    {
                        ProductId = id,
                        PictureUrl = filename
                    };

                    db.Pictures.Add(pic);
                }
                catch { }
            }

            db.SaveChanges();

        }


        // DELETE PICTURE
        public ActionResult Deletepic(int id)
        {
            try
            {
                var pic = db.Pictures.Find(id);
                string path = Server.MapPath("/Uploads/Products/") + pic.ProductId + "\\" + pic.PictureUrl;

                if (System.IO.File.Exists(path))
                {
                    System.IO.File.Delete(path);
                }

                db.Pictures.Remove(pic);
                db.SaveChanges();

                return Content("OK");
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

        }


        // INDEX SHOW PRODUCT
        public ActionResult Index(int? page, string kw_price, string kw_productname, string sort)
        {
            int pagesize = 10;
            int pagenumber = page ?? 1;

            var products = productRepository.GetModel();

            // lọc qua keywork để search
            if (!string.IsNullOrEmpty(kw_productname))
            {
                products = products.Where(x => x.ProductName.ToLower().Contains(kw_productname.ToLower()));
                ViewBag.kw = kw_productname;
            }

            if (!string.IsNullOrEmpty(kw_price))
            {
                products = products.Where(x => x.UnitPrice.ToString().Equals(kw_price));
                ViewBag.kw_price = kw_price;
            }


            if (string.IsNullOrEmpty(sort))
            {
                ViewBag.sort = "price_asc";
            }
            else
            {
                ViewBag.sort = sort;
            }

            switch (sort)
            {
                case "price_asc":
                    products = products.OrderBy(x => x.UnitPrice);
                    ViewBag.sortprice = "price_desc";
                    break;
                case "price_desc":
                    products = products.OrderByDescending(x => x.UnitPrice);
                    ViewBag.sortprice = "price_asc";
                    break;
                case "quan_asc":
                    products = products.OrderBy(x => x.QuantityAvailable);
                    ViewBag.sortquan = "quan_desc";
                    break;
                case "quan_desc":
                    products = products.OrderByDescending(x => x.QuantityAvailable);
                    ViewBag.sortquan = "quan_asc";
                    break;
            }

            ViewBag.sortprice = ViewBag.sortprice ?? "price_desc";
            ViewBag.sortquan = ViewBag.sortquan ?? "quan_asc";

            //var categories = db.Products_Categories_Mapping.Where(x => x.ProductId.Equals(id));

            return View(products.ToPagedList(pagenumber, pagesize));
        }

        // CREATE PRODUCT
        public ActionResult Create()
        {
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "CategoryName");
            ViewBag.PictureId = new SelectList(db.Pictures, "Id", "PictureUrl");
            ViewBag.VendorId = new SelectList(db.Vendors, "Id", "VendorName");
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Create(Product product, string[] CategoryId, HttpPostedFileBase img)
        {
            if (ModelState.IsValid)
            {
                // Add product
                product.ShowHomePage = false;
                product.View = 0;
                product.CreateDate = DateTime.Now;
                product.IsActive = true;
                db.Products.Add(product);
                db.SaveChanges();
                
                // Add Categories
                foreach (var c in CategoryId)
                {
                    p_c_m = new Products_Categories_Mapping()
                    {
                        ProductId = product.Id,
                        CategoryId = int.Parse(c),
                    };
                    db.Products_Categories_Mapping.Add(p_c_m);
                }
                db.SaveChanges();

                string path = Server.MapPath("~/Uploads/Products/" + product.Id);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                img = Request.Files[0];
                string ImageName = img.FileName.Split('\\').Last();
                img.SaveAs(path + "\\" + ImageName);

                var product_img = db.Products.Find(product.Id);
                product_img.PictureUrl = ImageName;

                db.SaveChanges();

                // ghi Log
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = 4,
                    Log_Type_Id = 1,
                    Message = "Create new product: " + product.ProductName,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);

                // Add picture
                UploadPicture(product.Id);

                return RedirectToAction("Index");
            }

            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "CategoryName");
            ViewBag.VendorId = new SelectList(db.Vendors, "Id", "VendorName", product.VendorId);
            return View(product);
        }

        // EDIT PRODUCT
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }

            // Show categories
            var categories = product.Products_Categories_Mapping.ToList();
            List<int> category = new List<int>();
            foreach (var c in categories)
            {
                category.Add(c.CategoryId);
            }

            ViewBag.CategoryId = new MultiSelectList(db.Categories, "Id", "CategoryName", category);
            ViewBag.VendorId = new SelectList(db.Vendors, "Id", "VendorName", product.VendorId);
            return View(product);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit(Product product, string[] CategoryId)
        {
            if (ModelState.IsValid)
            {
                // edit product
                db.Entry(product).State = EntityState.Modified;

                // Add Categories
                var categoriesList = db.Products_Categories_Mapping.Where(x => x.ProductId.Equals(product.Id));


                foreach (var c in CategoryId)
                {
                    var cate = categoriesList.SingleOrDefault(x => x.CategoryId.ToString().Equals(c));
                    if (cate == null)
                    {
                        p_c_m = new Products_Categories_Mapping()
                        {
                            ProductId = product.Id,
                            CategoryId = int.Parse(c),
                        };
                        db.Products_Categories_Mapping.Add(p_c_m);
                    }
                }

                // ghi Log
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = 4,
                    Log_Type_Id = 2,
                    Message = "Edit a product: " + product.ProductName,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);
                UploadPicture(product.Id);

                return RedirectToAction("Index");
            }
            ViewBag.VendorId = new SelectList(db.Vendors, "Id", "VendorName", product.VendorId);
            return View(product);
        }


        // DELETE PRODUCT
        public ActionResult Delete(int id)
        {
            try
            {
                //tìm ra product Id
                var product = db.Products.Find(id);

                // xóa tất cả picture có trong product
                product.Pictures.ToList().ForEach(x => db.Pictures.Remove(x));

                // xoá tất cả categories có trong product
                product.Products_Categories_Mapping.ToList().ForEach(x => db.Products_Categories_Mapping.Remove(x));

                // xóa product
                db.Products.Remove(product);

                // ghi log
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = 4,
                    Log_Type_Id = 3,
                    Message = "Delete a product: " + product.ProductName,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);

                // lưu lại
                db.SaveChanges();

                return Content("OK");
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

        }


        // DISPLAY PICTURE
        public ActionResult Display(string id, string picname)
        {
            try
            {
                var product = db.Products.Find(int.Parse(id));
                product.PictureUrl = picname;
                db.SaveChanges();
                return Content("Ok");
            }
            catch (Exception)
            {
                return Content("Error");
            }
        }


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
