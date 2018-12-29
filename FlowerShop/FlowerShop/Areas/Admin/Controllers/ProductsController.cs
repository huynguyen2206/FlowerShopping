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
    [AdminCustomAuthorize]
    public class ProductsController : Controller
    {
        private ProductRepository productRepository = new ProductRepository();
        //private GenericRepository<Product> productRepository = new GenericRepository<Product>();
        FlowerShoppingEntities db = new FlowerShoppingEntities();
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
        public ActionResult Index(int? page, string slider_price, string kw_productname, string kw_daterange, string sort)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Products");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagesize = 10;
            int pagenumber = page ?? 1;

            var products = productRepository.GetModel();

            //ViewBag.Msg = slider_price;

            if (!string.IsNullOrEmpty(slider_price))
            {
                var price = slider_price.Split(',');

                products = products.Where(x => x.UnitPrice >= int.Parse(price[0]) && x.UnitPrice <= int.Parse(price[1]));
                ViewBag.slider_price = slider_price;
            }

            // lọc qua keywork để search
            if (!string.IsNullOrEmpty(kw_productname))
            {
                products = products.Where(x => ChangeVN_EN.change(x.ProductName.ToLower()).Contains(kw_productname.ToLower().Trim()) 
                || x.ProductName.ToLower().Contains(kw_productname.ToLower().Trim()) );
                ViewBag.kw_productname = kw_productname;
            }

            if (!string.IsNullOrEmpty(kw_daterange))
            {
                var dt = kw_daterange.Split('-');

                products = products.Where(x => x.CreateDate.Date >= DateTime.Parse(dt[0]) && x.CreateDate.Date <= DateTime.Parse(dt[1]));
                ViewBag.kw_daterange = kw_daterange;
            }


            if (string.IsNullOrEmpty(sort))
            {
                ViewBag.sort = "id_asc";
            }
            else
            {
                ViewBag.sort = sort;
            }

            switch (sort)
            {
                case "id_asc":
                    products = products.OrderBy(x => x.Id);
                    ViewBag.sortid = "id_desc";
                    break;
                case "id_desc":
                    products = products.OrderByDescending(x => x.Id);
                    ViewBag.sortid = "id_asc";
                    break;
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

            ViewBag.sortid = ViewBag.sortid ?? "id_desc";
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
        public ActionResult Create(Product product, int[] CategoryId, HttpPostedFileBase img, int InputPrice)
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
                        CategoryId = c,
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

                SystemLogs.Create("Product", product.ProductName);

                // add real quantity
                Product_Logs p_l = new Product_Logs()
                {
                    ProductId = product.Id,
                    ProductPrice = InputPrice,
                    ProductQuantity = product.QuantityAvailable,
                    EmployeeId = int.Parse(User.Identity.Name),
                    RegisterDate = DateTime.Now
                };

                db.Product_Logs.Add(p_l);

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
        public ActionResult Edit(Product product, int[] CategoryId, int realquantity, int realprice)
        {
            if (ModelState.IsValid)
            {
                // edit product
                db.Entry(product).State = EntityState.Modified;

                // Add Categories
                List<int> category = new List<int>();

                var categoriesList = db.Products_Categories_Mapping.Where(x => x.ProductId.Equals(product.Id));

                foreach(var c in categoriesList)
                {
                    category.Add(c.CategoryId);
                }

                var categoriesRemove = category.Except(CategoryId);
                foreach(var c in categoriesRemove)
                {
                    var cate = db.Products_Categories_Mapping.SingleOrDefault(x => x.CategoryId.Equals(c) && x.ProductId.Equals(product.Id));
                    db.Products_Categories_Mapping.Remove(cate);
                }

                var categoriesAdd = CategoryId.Except(category);
                foreach(var c in categoriesAdd)
                {
                    Products_Categories_Mapping cate = new Products_Categories_Mapping()
                    {
                        ProductId = product.Id,
                        CategoryId = c
                    };
                    db.Products_Categories_Mapping.Add(cate);
                }

                SystemLogs.Edit("Product", product.ProductName);

                if (realquantity > 0)
                {
                    // add real quantity
                    Product_Logs p_l = new Product_Logs()
                    {
                        ProductId = product.Id,
                        ProductPrice = realprice,
                        ProductQuantity = realquantity,
                        EmployeeId = int.Parse(User.Identity.Name),
                        RegisterDate = DateTime.Now
                    };

                    db.Product_Logs.Add(p_l);
                }
                

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

                // xóa tất cả id có trong product_log
                product.Product_Logs.ToList().ForEach(x => db.Product_Logs.Remove(x));

                // xóa product
                db.Products.Remove(product);

                SystemLogs.Delete("Product", product.ProductName);

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
