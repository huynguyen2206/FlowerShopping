using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Controllers
{
    public class ProductController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // GET: Product
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult Category(int id)
        {
            var product = db.Products_Categories_Mapping.Where(x => x.CategoryId.Equals(id));
            return View(product.ToList());
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
                var user_id = int.Parse(User.Identity.Name);

                Like l = db.Likes.Where(x => x.CustomerId == user_id && x.ProductId == id).SingleOrDefault();

                if (l == null)
                {
                    l = new Like()
                    {
                        CustomerId = user_id,
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
                var user_id = int.Parse(User.Identity.Name);

                Like l = db.Likes.Where(x => x.CustomerId == user_id && x.ProductId == id).SingleOrDefault();

                return Content(l.IsLike.ToString());
            }
            catch (Exception)
            {
                return Content("Error!");
            }

        }

    }
}