using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    
    public class EmployeesController : Controller
    {
        private GenericRepository<Employee> EmployeeRepository = new GenericRepository<Employee>();
        private FlowerShoppingEntities db = new FlowerShoppingEntities();
        
        // LOGIN
        public ActionResult Login()
        {
            if (User.Identity.IsAuthenticated && !User.IsInRole(""))
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
        public ActionResult Login(Employee data, string RememeberMe)
        {
            var emp = db.Employees.SingleOrDefault(x => x.LoginName.ToLower().Equals(data.LoginName.ToLower()));

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

            if (!emp.IsActive)
            {
                ViewBag.Msg = "Tài khoản đã bị khóa";
            }
            
            FormsAuthentication.SetAuthCookie(emp.Id.ToString(), RememeberMe == "on" ? true : false);
            return RedirectToAction("Index", "Dashboard");
        }
        
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }


        [AdminCustomAuthorize]
        public ActionResult Index(int? page, string sort, string Kw_EmployeeName)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Employees");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagesize = 10;
            int pagenumber = page ?? 1;
            var employees = EmployeeRepository.GetModel();
            employees = employees.Where(x => x.IsActive == true);

            if (!string.IsNullOrEmpty(Kw_EmployeeName))
            {
                employees = employees.Where(x => x.EmployeeName.ToLower().Contains(Kw_EmployeeName.ToLower()));
                ViewBag.kw = Kw_EmployeeName;
            }

            if (string.IsNullOrEmpty(sort))
            {
                ViewBag.sort = "id_asc";
            }
            else
            {
                ViewBag.sort = sort;
            }

            switch (sort)
            {
                case "id_asc":
                    employees = employees.OrderBy(x => x.Id);
                    ViewBag.sortid = "id_desc";
                    break;
                case "id_desc":
                    employees = employees.OrderByDescending(x => x.Id);
                    ViewBag.sortid = "id_asc";
                    break;
            }
            ViewBag.sortid = ViewBag.sortid ?? "id_desc";
            return View(employees.ToPagedList(pagenumber, pagesize));
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

        [AdminCustomAuthorize]
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
        public ActionResult Create(HttpPostedFileBase pic, [Bind(Include = "Id,LoginName,Password,EmployeeName,Phone,Gender,Email,Address,PictureUrl,LevelId,LastLogin,RegisterDate")] Employee employee)
        {
            if (ModelState.IsValid)
            {
                employee.PictureUrl = "";
                employee.RegisterDate = DateTime.Now;
                employee.LastLogin = DateTime.Now;
                db.Employees.Add(employee);

                db.SaveChanges();
                // picture
                string path = Server.MapPath("~/Uploads/Employee/" + employee.Id);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }


                string ImageName = pic.FileName.Split('\\').Last();
                pic.SaveAs(path + "\\" + ImageName);
                var employees = db.Employees.Find(employee.Id);

                employees.PictureUrl = ImageName;

                SystemLogs.Create("Employee", employee.EmployeeName);

                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName", employee.LevelId);
            return View(employee);
        }

        [AdminCustomAuthorize]
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
        public ActionResult Edit(HttpPostedFileBase pic, [Bind(Include = "Id,LoginName,Password,EmployeeName,Phone,Gender,Email,Address,PictureUrl,LevelId,LastLogin,RegisterDate")] Employee employee)
        {
            if (ModelState.IsValid)
            {
                var emp = db.Employees.Find(employee.Id);
                if (pic != null)
                {
                    // picture
                    string path = Server.MapPath("~/Uploads/Employee/") + emp.Id + "\\" + emp.PictureUrl;
                    if (System.IO.File.Exists(path))
                    {
                        System.IO.File.Delete(path);
                        path = Server.MapPath("~/Uploads/Employee/" + emp.Id);
                        Directory.CreateDirectory(path);
                        string ImageName = pic.FileName.Split('\\').Last();
                        pic.SaveAs(path + "\\" + ImageName);
                        employee.PictureUrl = ImageName;

                    }
                }


                emp.LevelId = employee.LevelId;
                emp.Email = employee.Email;
                emp.Phone = employee.Phone;
                emp.Address = employee.Address;
                emp.Gender = employee.Gender;

                SystemLogs.Edit("Employee", employee.EmployeeName);

                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName", employee.LevelId);
            return View(employee);
        }


        [AdminCustomAuthorize]
        // GET: Admin/Employees/Delete/5
        public ActionResult Delete(int id)
        {
            //if (id == null)
            //{
            //    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            //}
            //Employee employee = db.Employees.Find(id);
            //if (employee == null)
            //{
            //    return HttpNotFound();
            //}
            //return View(employee);
            try
            {
                var employee = db.Employees.Find(id);
                employee.IsActive = false;
                db.SaveChanges();


                return Content("OK");
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }
        }

        // POST: Admin/Employees/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Employee employee = db.Employees.Find(id);
            db.Employees.Remove(employee);

            SystemLogs.Delete("Employee", employee.EmployeeName);

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
