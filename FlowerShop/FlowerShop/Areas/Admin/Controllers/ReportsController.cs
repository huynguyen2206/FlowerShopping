using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class ReportsController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        // GET: Admin/Reports
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult ReportEmployees()
        {
            var emp = db.Employees.ToList();
            return View(emp);
        }


        public ActionResult ReportProducts()
        {
            var products = db.Products.ToList();
            return View(products);
        }

        public ActionResult ReportOrders()
        {
            var orders = db.Orders.ToList();
            return View(orders);
        }
    }
}