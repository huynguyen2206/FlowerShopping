using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Controllers
{
    public class HomeController : Controller
    {
        DisableRepository disableRepository = new DisableRepository();
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        public ActionResult Index()
        {
            //var cate = db.Categories.Where(x => x.ShowHomePage == true);
            //foreach(var item in cate)
            //{
            //    var category = db.Products_Categories_Mapping.Where(x => x.CategoryId.Equals(item.Id));
            //}

            // lấy dữ liệu product vào ViewBag để show ra ngoài HomePage
            var ProductsDiscount = db.Products.OrderBy(x => x.Id).Where(x => x.SalePrice > 0).Take(8).ToList();
            ViewBag.ProductsDiscount = ProductsDiscount;

            var NewProducts = db.Products.OrderByDescending(x => x.CreateDate).Take(8).ToList();
            ViewBag.NewProducts = NewProducts;
            
            var HotProducts = db.Products.OrderByDescending(x => x.OrderDetails.Count).Take(3).ToList();
            ViewBag.HotProducts = HotProducts;

            var Product_Showhomepage = db.Products.Where(x => x.ShowHomePage.Equals(true)).Take(8).ToList();
            ViewBag.Product_Showhomepage = Product_Showhomepage;

            // lấy dữ liệu disable vào ViewBag để show ra ngoài HomePage
            ViewBag.DisProductDiscounted = disableRepository.ShowDisable("ProductDiscounted");
            ViewBag.DisCategories = disableRepository.ShowDisable("Categories");
            ViewBag.DisProductNew = disableRepository.ShowDisable("ProductNew");
            ViewBag.DisProductShowHomePage = disableRepository.ShowDisable("ProductShowHomePage");
            ViewBag.DisProductOrder = disableRepository.ShowDisable("ProductOrder");
            
            return View();
        }

    }
}