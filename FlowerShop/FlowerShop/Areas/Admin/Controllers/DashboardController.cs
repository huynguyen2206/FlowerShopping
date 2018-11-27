using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class DashboardController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // GET: Admin/Dashboard
        public ActionResult Index()
        {
            //var pr = (from p in db.Products
            //         join od in db.OrderDetails on p.Id equals od.ProductId
            //         join o in db.Orders on od.OrderId equals o.Id
            //         where p.OrderDetails.Count() >= 1 && (DateTime.Now - o.OrderDate).Days < 3
            //         select p);

            var products = db.Products.Where(x => x.OrderDetails.Count >= 1).ToList();
            ViewBag.products = products;

            return View();
        }
    }
}