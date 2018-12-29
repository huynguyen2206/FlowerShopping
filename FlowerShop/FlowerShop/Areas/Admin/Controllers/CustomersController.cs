using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class CustomersController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        private GenericRepository<Customer> CustomerRepository = new GenericRepository<Customer>();
        // GET: Admin/Customers
        public ActionResult Index(int? page, string sort, string Kw_CustomerName)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Customers");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagesize = 10;
            int pagenumber = page ?? 1;
            var Cus = CustomerRepository.GetModel();
            Cus = Cus.Where(x => x.IsActive);

            if (!string.IsNullOrEmpty(Kw_CustomerName))
            {
                Cus = Cus.Where(x => x.CustomerName.ToLower().Contains(Kw_CustomerName.ToLower()));
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
                    Cus = Cus.OrderBy(x => x.Id);
                    ViewBag.sortid = "id_desc";
                    break;
                case "id_desc":
                    Cus = Cus.OrderByDescending(x => x.Id);
                    ViewBag.sortid = "id_asc";
                    break;
            }
            ViewBag.sortid = ViewBag.sortid ?? "id_desc";
            return View(Cus.ToPagedList(pagenumber, pagesize));
        }

        // GET: Admin/Customers/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }

        // GET: Admin/Customers/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Customers/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(HttpPostedFileBase pic, [Bind(Include = "Id,CustomerName,Email,Password,Phone,Address,ImageUrl,VIP,RegisterToten,RegisterDate,IsActive")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                customer.ImageUrl = "";
                customer.RegisterDate = DateTime.Now;
                customer.VIP = false;
                customer.IsActive = true;
                db.Customers.Add(customer);
                db.SaveChanges();
                // luu hinh anh
                string path = Server.MapPath("~/Uploads/Customers/" + customer.Id);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }


                string ImageName = pic.FileName.Split('\\').Last();
                pic.SaveAs(path + "\\" + ImageName);
                var cus = db.Customers.Find(customer.Id);

                cus.ImageUrl = ImageName;

                SystemLogs.Create("Customer", cus.CustomerName);

                db.SaveChanges();
                return RedirectToAction("Index");

            }

            return View(customer);
        }

        // GET: Admin/Customers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }

        // POST: Admin/Customers/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(HttpPostedFileBase pic, [Bind(Include = "Id,CustomerName,Email,Password,Phone,Address,ImageUrl,VIP,RegisterToten,RegisterDate,IsActive")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                var cus = db.Customers.Find(customer.Id);
                // thay doi anh
                if (pic != null)
                {
                    // picture
                    string path = Server.MapPath("~/Uploads/Customers/") + cus.Id + "\\" + cus.ImageUrl;
                    if (System.IO.File.Exists(path))
                    {
                        System.IO.File.Delete(path);
                        path = Server.MapPath("~/Uploads/Customers/" + cus.Id);
                        Directory.CreateDirectory(path);
                        string ImageName = pic.FileName.Split('\\').Last();
                        pic.SaveAs(path + "\\" + ImageName);
                        cus.ImageUrl = ImageName;

                    }


                }

                cus.IsActive = customer.IsActive;
                cus.Phone = customer.Phone;
                cus.Address = customer.Address;

                SystemLogs.Edit("Customer", cus.CustomerName);

                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(customer);
        }

        // GET: Admin/Customers/Delete/5
        public ActionResult Delete(int? id)
        {
            try
            {
                var cus = db.Customers.Find(id);
                cus.IsActive = false;
                db.SaveChanges();
                return Content("OK");
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }
        }

        // POST: Admin/Customers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Customer customer = db.Customers.Find(id);
            db.Customers.Remove(customer);

            SystemLogs.Delete("Customer", customer.CustomerName);

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