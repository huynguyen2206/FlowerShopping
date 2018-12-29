using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class ShippersController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        GenericRepository<Shipping> ShippingRepository = new GenericRepository<Shipping>();
        // GET: Admin/Shippings
        public ActionResult Index(int? page, string sort, string Kw_EmployeeName)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Shippers");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagesize = 10;
            int pagenumber = page ?? 1;
            var shipping = ShippingRepository.GetModel();
            shipping = shipping.Where(x => x.IsActive);

            if (!string.IsNullOrEmpty(Kw_EmployeeName))
            {
                shipping = shipping.Where(x => x.ShippingName.ToLower().Contains(Kw_EmployeeName.ToLower()));
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
                    shipping = shipping.OrderBy(x => x.Id);
                    ViewBag.sortid = "id_desc";
                    break;
                case "id_desc":
                    shipping = shipping.OrderByDescending(x => x.Id);
                    ViewBag.sortid = "id_asc";
                    break;
            }
            ViewBag.sortid = ViewBag.sortid ?? "id_desc";
            return View(shipping.ToPagedList(pagenumber, pagesize));

        }


        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Shippings/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,ShippingName,Email,Phone,Address")] Shipping shipping)
        {
            if (ModelState.IsValid)
            {
                db.Shippings.Add(shipping);

                SystemLogs.Create("Shipper", shipping.ShippingName);

                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(shipping);
        }

        // GET: Admin/Shippings/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Shipping shipping = db.Shippings.Find(id);
            if (shipping == null)
            {
                return HttpNotFound();
            }
            return View(shipping);
        }

        // POST: Admin/Shippings/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,ShippingName,Email,Phone,Address")] Shipping shipping)
        {
            if (ModelState.IsValid)
            {
                db.Entry(shipping).State = EntityState.Modified;

                SystemLogs.Edit("Shipper", shipping.ShippingName);

                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(shipping);
        }

        // GET: Admin/Shippings/Delete/5
        public ActionResult Delete(int? id)
        {
            var shipping = db.Shippings.Find(id);
            shipping.IsActive = false;
            db.SaveChanges();
            return Content("OK");
        }

        // POST: Admin/Shippings/Delete/5


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