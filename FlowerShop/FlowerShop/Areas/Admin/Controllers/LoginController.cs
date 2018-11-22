using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(Employee data)
        {
            var emp = db.Employees.SingleOrDefault(x => x.LoginName.Equals(data.LoginName));

            if(emp == null)
            {
                ViewBag.Msg = "Tài khoản không chính xác";
            }

            if (!emp.Password.Equals(data.Password))
            {
                ViewBag.Msg = "Mật khẩu không chính xác";
            }

            //if (!emp.isActive)
            //{
            //    ViewBag.Msg = "Tài khoản đã bị khóa";
            //}

            //FormsAuthentication.SetAuthCookie(emp.Id.ToString(), false);

            return View();
        }
    }
}