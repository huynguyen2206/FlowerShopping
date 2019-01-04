using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using Newtonsoft.Json;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
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

            //var cus = (from c in db.Customers
            //           where c.IsActive == true
            //          select c).ToList();

            //var products = db.Products.Where(x => x.OrderDetails.Count >= 1).ToList();
            //ViewBag.products = products;

            ////var customer = db.Customers.Where(x => (DateTime.Now - x.RegisterDate).Days < 3).ToList();
            //ViewBag.cus = cus;
            DateTime firstday = DateTime.Now;
            firstday = firstday.AddDays((-firstday.Day));

            DateTime lastday = DateTime.Now;
            lastday = lastday.AddMonths(1);
            lastday = lastday.AddDays(-(lastday.Day));

            var order = db.Orders.Where(o => o.OrderDate >= firstday && o.OrderDate <= lastday && o.StatusId == 3).ToList();
            decimal TR = 0; 
            if(order == null)
            {
                TR = 0;
            }
            else
            {
                TR = order.Sum(x => x.OrderDetails.Sum(od => (od.UnitPrice - od.Discount) * od.Quantity));
            }
            
            ViewBag.TR = TR.ToString("N0");

            var TotalCost = db.Products.Where(x => x.OrderDetails.Count > 0);
            //var TotalC = from p in TotalCost
            //             join l in db.Product_Logs on p.Id equals l.ProductId
            //             where l.RegisterDate >= firstday && l.RegisterDate <= lastday
            //             select p;

            //var TC = TotalCost.Sum(x => (x.Product_Logs.Where(p => p.RegisterDate >= firstday && p.RegisterDate <= lastday).Sum(p => p.ProductPrice * p.ProductQuantity) 
            //        / x.Product_Logs.Where(p => p.RegisterDate >= firstday && p.RegisterDate <= lastday).Sum(p => p.ProductQuantity))
            //        * x.OrderDetails.Where(od => od.Order.OrderDate >= firstday && od.Order.OrderDate <= lastday && od.Order.StatusId == 3).Sum(od => od.Quantity));

            decimal TC = 0;
            try
            {
                TC = TotalCost.Sum(x => (x.Product_Logs.Sum(p => p.ProductPrice * p.ProductQuantity)
                    / x.Product_Logs.Sum(p => p.ProductQuantity))
                    * x.OrderDetails.Where(od => od.Order.OrderDate >= firstday && od.Order.OrderDate <= lastday && od.Order.StatusId == 3).Sum(od => od.Quantity));
            }
            catch
            {
                TC = 0;
            }
            

            ViewBag.TC = TC.ToString("N0");

            var TP = TR - TC;
            ViewBag.TP = TP.ToString("N0");

            ViewBag.pendding = db.Orders.Where(x => x.StatusId == 1 && x.OrderDate >= firstday && x.OrderDate <= lastday).Count().ToString();
            ViewBag.processing = db.Orders.Where(x => x.StatusId == 2 && x.OrderDate >= firstday && x.OrderDate <= lastday).Count().ToString();
            ViewBag.complete = db.Orders.Where(x => x.StatusId == 3 && x.OrderDate >= firstday && x.OrderDate <= lastday).Count().ToString();
            ViewBag.cancel = db.Orders.Where(x => x.StatusId == 4 && x.OrderDate >= firstday && x.OrderDate <= lastday).Count().ToString();
            ViewBag.total = db.Orders.Where(x => x.OrderDate >= firstday && x.OrderDate <= lastday).Count().ToString();

            return View();
        }


        public ActionResult MonthlyReport()
        {
            List<int> ArrayOrder = new List<int>();

            DateTime lastday = DateTime.Now;
            lastday = lastday.AddMonths(1);
            lastday = lastday.AddDays(-(lastday.Day));

            for (int i = 1; i <= lastday.Day; i++)
            {
                int order = db.Orders.Where(x => x.OrderDate.Day == i && x.OrderDate.Month == DateTime.Now.Month && x.OrderDate.Year == DateTime.Now.Year).Count();
                ArrayOrder.Add(order);
            }

            string list_order = JsonConvert.SerializeObject(ArrayOrder);

            return Content(list_order);
        }

    }
}