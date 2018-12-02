using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    //[AdminCustomAuthorize(Roles = "Admin, Manager")]
    public class EmployeesController : Controller
    {
        private FlowerShoppingEntities db = new FlowerShoppingEntities();
        
        // LOGIN
        public ActionResult Login()
        {
            if(User.Identity.IsAuthenticated && !User.IsInRole(""))
            {
                return RedirectToAction("Index", "Dashboard");
            }

            if (User.Identity.IsAuthenticated && User.IsInRole(""))
            {
                //HttpCookie myCookie = new HttpCookie("name");
                //myCookie.Expires = DateTime.Now.AddDays(-1d);
                //Response.Cookies.Add(myCookie);

                //FormsAuthentication.SignOut();
                return View();
            }
            return View();
        }


        [HttpPost]
        public ActionResult Login(Employee data)
        {
            var emp = db.Employees.SingleOrDefault(x => x.LoginName.Equals(data.LoginName));

            if (emp == null)
            {
                ViewBag.Msg = "Tài khoản không chính xác";
                return View();
            }

            if (!emp.Password.Equals(data.Password))
            {
                ViewBag.Msg = "Mật khẩu không chính xác";
                return View();
            }

            //if (!emp.isActive)
            //{
            //    ViewBag.Msg = "Tài khoản đã bị khóa";
            //}


            FormsAuthentication.SetAuthCookie(emp.Id.ToString(), false);
            return RedirectToAction("Index", "Dashboard");
        }


        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }




        // GET: Admin/Employees
        public ActionResult Index()
        {
            var employees = db.Employees.Include(e => e.Level);
            return View(employees.ToList());
        }

        // GET: Admin/Employees/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Employee employee = db.Employees.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        // GET: Admin/Employees/Create
        public ActionResult Create()
        {
            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName");
            return View();
        }

        // POST: Admin/Employees/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,LoginName,Password,EmployeeName,Phone,Gender,Email,Address,PictureUrl,LevelId,LastLogin,RegisterDate")] Employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Employees.Add(employee);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName", employee.LevelId);
            return View(employee);
        }

        // GET: Admin/Employees/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Employee employee = db.Employees.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName", employee.LevelId);
            return View(employee);
        }

        // POST: Admin/Employees/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,LoginName,Password,EmployeeName,Phone,Gender,Email,Address,PictureUrl,LevelId,LastLogin,RegisterDate")] Employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Entry(employee).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName", employee.LevelId);
            return View(employee);
        }

        // GET: Admin/Employees/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Employee employee = db.Employees.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        // POST: Admin/Employees/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Employee employee = db.Employees.Find(id);
            db.Employees.Remove(employee);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
