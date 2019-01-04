using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class SystemsController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        public ActionResult ProductsLogs(int? page, string kw_price, string kw_quantity, string kw_productname, string kw_daterange)
        {
            int pagesize = 20;
            int pagenumber = page ?? 1;

            var products_logs = db.Product_Logs.ToList();

            if(!string.IsNullOrEmpty(kw_price))
            {
                var price = kw_price.Split(',');
                products_logs = products_logs.Where(x => x.ProductPrice >= int.Parse(price[0]) && x.ProductPrice <= int.Parse(price[1])).ToList();
                ViewBag.kw_price = kw_price;
            }

            if (!string.IsNullOrEmpty(kw_quantity))
            {
                var price = kw_quantity.Split(',');
                products_logs = products_logs.Where(x => x.ProductQuantity >= int.Parse(price[0]) && x.ProductQuantity <= int.Parse(price[1])).ToList();
                ViewBag.kw_quantity = kw_quantity;
            }

            if (!string.IsNullOrEmpty(kw_productname))
            {
                products_logs = products_logs.Where(x => ChangeVN_EN.change(x.Product.ProductName.ToLower()).Contains(kw_productname.ToLower().Trim())
                || x.Product.ProductName.ToLower().Contains(kw_productname.ToLower().Trim())).ToList();
                ViewBag.kw_productname = kw_productname;
            }

            if (!string.IsNullOrEmpty(kw_daterange))
            {
                var dt = kw_daterange.Split('-');

                products_logs = products_logs.Where(x => x.RegisterDate.Date >= DateTime.Parse(dt[0]) && x.RegisterDate.Date <= DateTime.Parse(dt[1])).ToList();
                ViewBag.kw_daterange = kw_daterange;
            }

            return View(products_logs.OrderByDescending(x => x.Id).ToPagedList(pagenumber, pagesize));
        }


        public ActionResult SystemLogs(int? page, string TypeId, string kw_employeename, string kw_daterange, string kw_message)
        {
            int pagesize = 20;
            int pagenumber = page ?? 1;

            var system_logs = db.System_Logs.ToList();

            if(!string.IsNullOrEmpty(TypeId))
            {
                system_logs = system_logs.Where(x => x.Log_Type_Id.Equals(int.Parse(TypeId))).ToList();
                ViewBag.Type_log = TypeId;
            }

            if (!string.IsNullOrEmpty(kw_message))
            {
                system_logs = system_logs.Where(x => ChangeVN_EN.change(x.Message.ToLower()).Contains(kw_message.ToLower().Trim())
                || x.Message.ToLower().Contains(kw_message.ToLower().Trim())).ToList();
                ViewBag.kw_message = kw_message;
            }

            if (!string.IsNullOrEmpty(kw_employeename))
            {
                system_logs = system_logs.Where(x => ChangeVN_EN.change(x.Employee.EmployeeName.ToLower()).Contains(kw_employeename.ToLower().Trim())
                || x.Employee.EmployeeName.ToLower().Contains(kw_employeename.ToLower().Trim())).ToList();
                ViewBag.kw_employeename = kw_employeename;
            }

            if (!string.IsNullOrEmpty(kw_daterange))
            {
                var dt = kw_daterange.Split('-');

                system_logs = system_logs.Where(x => x.RegisterDate.Date >= DateTime.Parse(dt[0]) && x.RegisterDate.Date <= DateTime.Parse(dt[1])).ToList();
                ViewBag.kw_daterange = kw_daterange;
            }

            ViewBag.TypeId = new SelectList(db.Log_Types, "Id", "Log_Type_Name");

            return View(system_logs.OrderByDescending(x => x.Id).ToPagedList(pagenumber, pagesize));
        }

        public ActionResult Display()
        {
            var display = db.Disables.ToList();

            return View(display);
        }

        [HttpPost]
        public ActionResult Display(int pid)
        {
            var display = db.Disables.Find(pid);
            display.IsActive = !display.IsActive;
            db.SaveChanges();

            return Content("OK");
        }
    }
}