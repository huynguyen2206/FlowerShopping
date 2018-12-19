using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class OrdersController : Controller
    {
        private GenericRepository<Order> orderRepository = new GenericRepository<Order>();
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        
        // SHOW INDEX ORDER
        public ActionResult Index(int? page, string kw_customername, string StatusId, string kw_daterange, string sort)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Orders");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagenumber = page ?? 1;
            int pagesize = 10;
            var orders = orderRepository.GetModel();

            if (!string.IsNullOrEmpty(StatusId))
            {
                orders = orders.Where(x => x.StatusId.ToString().Equals(StatusId));
                ViewBag.kw_productname = StatusId;
            }

            if (!string.IsNullOrEmpty(kw_customername))
            {
                orders = orders.Where(x => x.CustomerId != null && ChangeVN_EN.change(x.Customer.CustomerName.ToLower()).Contains(kw_customername.ToLower().Trim())
                || x.CustomerId != null && x.Customer.CustomerName.ToLower().Contains(kw_customername.ToLower().Trim()));
                ViewBag.kw = kw_customername;
            }

            if (!string.IsNullOrEmpty(kw_daterange))
            {
                var dt = kw_daterange.Split('-');

                orders = orders.Where(x => x.OrderDate.Date >= DateTime.Parse(dt[0]) && x.OrderDate.Date <= DateTime.Parse(dt[1]));
                ViewBag.kw_date = kw_daterange;
            }


            if (string.IsNullOrEmpty(sort))
            {
                ViewBag.sort = "date_asc";
            }
            else
            {
                ViewBag.sort = sort;
            }

            switch (sort)
            {
                case "date_asc":
                    orders = orders.OrderBy(x => x.OrderDate);
                    ViewBag.sortdate = "date_desc";
                    break;
                case "date_desc":
                    orders = orders.OrderByDescending(x => x.OrderDate);
                    ViewBag.sortdate = "date_asc";
                    break;
                case "status_asc":
                    orders = orders.OrderBy(x => x.Status.Id);
                    ViewBag.sortastatus = "status_desc";
                    break;
                case "status_desc":
                    orders = orders.OrderByDescending(x => x.Status.Id);
                    ViewBag.sortstatus = "status_asc";
                    break;
            }

            ViewBag.sortdate = ViewBag.sortdate ?? "date_desc";
            ViewBag.sortstatus = ViewBag.sortstatus ?? "status_asc";

            ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName");

            return View(orders.OrderByDescending(x => x.Id).ToPagedList(pagenumber, pagesize));
        }

        // SHOW ORDER DETAILS
        public ActionResult Edit(int id)
        {
            var orderdetails = orderRepository.GetModelById(id);
            ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName", orderdetails.StatusId);
            return View(orderdetails);
        }

        
        //public ActionResult Details(int id)
        //{
        //    var orderdetails = orderRepository.GetModelById(id);
        //    ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName", orderdetails.StatusId);
        //    return View(orderdetails);
        //}


        // CHANGE STATUS ORDER = CANCEL
        public ActionResult CancelOrder(int oid)
        {
            try
            {
                var orderdetails = orderRepository.GetModelById(oid);
                orderdetails.StatusId = 4;
                orderRepository.UpdateModel(orderdetails);
                orderRepository.Save();
                return Content("OK");
            }
            catch (Exception)
            {
                return Content("Error!");
            }
            
        }


        // CHANGE PRODUCT INFO
        public ActionResult OrderDetails(int id)
        {
            var orderdetails = db.OrderDetails.Find(id);

            OrderDetailsVM data = Mapper.Map<OrderDetailsVM>(orderdetails);
            return PartialView(data);
        }

        [HttpPost]
        public ActionResult OrderDetails(OrderDetailsVM data)
        {
            var orderdetails = db.OrderDetails.Find(data.Id);

            Mapper.Map(data, orderdetails);
            db.SaveChanges();

            return RedirectToAction("Edit", new { id = data.OrderId });
        }


        // DELETE ORDER DETAILS
        public ActionResult Delete_Orderdetails(int odid)
        {
            try
            {
                var orderdetails = db.OrderDetails.Find(odid);
                //db.OrderDetails.Remove(orderdetails);
                db.SaveChanges();

                return Content("OK");
            }
            catch (Exception)
            {
                return Content("Error!");
            }

        }


        // ADD SHIPPER
        public ActionResult AddShipper(int id)
        {
            var order = db.Orders.Find(id);
            AddShipperVM data = Mapper.Map<AddShipperVM>(order);

            ViewBag.ShippingId = new SelectList(db.Shippings, "Id", "ShippingName");
            return PartialView(data);
        }

        [HttpPost]
        public ActionResult AddShipper(AddShipperVM data)
        {
            var order = db.Orders.Find(data.Id);
            Mapper.Map(data, order);

            order.EmployeeId = int.Parse(User.Identity.Name);
            order.StatusId = 2;
            db.SaveChanges();
            
            return RedirectToAction("Edit", new { id = data.Id });
        }


        public ActionResult ChangeStatus(int oid, int statusid)
        {
            try
            {
                //var order = orderRepository.GetModelById(int.Parse(oid));
                var order = db.Orders.Find(oid);
                order.StatusId = statusid;
                db.SaveChanges();

                return Content("OK");
            }
            catch (Exception)
            {
                return Content("Error!");
            }
        }



    }
}