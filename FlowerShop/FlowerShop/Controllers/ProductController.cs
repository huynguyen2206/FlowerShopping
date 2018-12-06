using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Controllers
{
    public class ProductController : Controller
    {
        private ProductRepository productRepository = new ProductRepository();
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Search(int? page, string kw)
        {
            int pagesize = 9;
            int pagenumber = page ?? 1;

            var products = productRepository.GetModel();
            products = products.Where(x => ChangeVN_EN.change(x.ProductName.ToLower()).Contains(kw.ToLower().Trim())
                || x.ProductName.ToLower().Contains(kw.ToLower().Trim()));
            ViewBag.kw = kw;

            return View(products.ToPagedList(pagenumber, pagesize));
        }

        public ActionResult Category(int id)
        {
            var products = db.Products_Categories_Mapping.Where(x => x.CategoryId.Equals(id));
            return View(products.ToList());
        }

        public ActionResult ProductDetails(int id)
        {
            try
            {
                var product = db.Products.Find(id);

                if (Session["view" + id] == null)
                {
                    Session["view" + id] = "ok";
                    product.View++;
                    db.SaveChanges();
                }

                return View(product);
            }
            catch (Exception)
            {
                throw;
            }
        }


        // LIKE
        public ActionResult Like(int id)
        {
            try
            {
                //var user_id = int.Parse(User.Identity.Name);
                var cus = db.Customers.SingleOrDefault(x => x.Email.Equals(User.Identity.Name));

                Like l = db.Likes.Where(x => x.CustomerId.Equals(cus.Id) && x.ProductId == id).SingleOrDefault();

                if (l == null)
                {
                    l = new Like()
                    {
                        CustomerId = cus.Id,
                        IsLike = true,
                        ProductId = id,
                    };

                    db.Likes.Add(l);
                }
                else
                {
                    l.IsLike = !l.IsLike;
                }
                db.SaveChanges();

                return Content(l.IsLike.ToString() + "|" + db.Likes.Where(x => x.ProductId == id && x.IsLike).Count());
            }
            catch (Exception)
            {

                return Content("Error!");
            }


        }


        public ActionResult Checklike(int id)
        {
            try
            {
                //var user_id = int.Parse(User.Identity.Name);
                var cus = db.Customers.SingleOrDefault(x => x.Email.Equals(User.Identity.Name));

                Like l = db.Likes.Where(x => x.CustomerId.Equals(cus.Id) && x.ProductId == id).SingleOrDefault();

                return Content(l.IsLike.ToString());
            }
            catch (Exception)
            {
                return Content("Error!");
            }

        }

    }
}