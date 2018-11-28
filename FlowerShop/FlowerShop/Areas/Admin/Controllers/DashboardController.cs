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
            //          join od in db.OrderDetails on p.Id equals od.ProductId
            //          join o in db.Orders on od.OrderId equals o.Id
            //          where p.OrderDetails.Count() >= 1 && (DateTime.Now - o.OrderDate).Days < 3
            //          select p).ToList();

            var cus = (from c in db.Customers
                       where c.IsActive == true
                      select c).ToList();

            var products = db.Products.Where(x => x.OrderDetails.Count >= 1).ToList();
            ViewBag.products = products;

            //var customer = db.Customers.Where(x => (DateTime.Now - x.RegisterDate).Days < 3).ToList();
            ViewBag.cus = cus;

            return View();
        }
    }
}