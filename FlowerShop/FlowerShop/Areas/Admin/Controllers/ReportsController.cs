using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class ReportsController : Controller
    {
        // GET: Admin/Reports
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult ReportProducts()
        {
            return View();
        }
    }
}