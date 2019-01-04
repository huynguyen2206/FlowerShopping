using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
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
        public ActionResult Index(int? page, string slider_price, string kw_customername, string StatusId, string kw_daterange, string kw_ordercode, string sort)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Orders");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagenumber = page ?? 1;
            int pagesize = 10;
            var orders = orderRepository.GetModel();

            if (!string.IsNullOrEmpty(slider_price))
            {
                var price = slider_price.Split(',');

                orders = orders.Where(x => x.OrderDetails.Sum(od => (od.UnitPrice - od.Discount) * od.Quantity) >= int.Parse(price[0]) && x.OrderDetails.Sum(od => (od.UnitPrice - od.Discount) * od.Quantity) <= int.Parse(price[1]));
                ViewBag.slider_price = slider_price;
            }

            if (!string.IsNullOrEmpty(kw_ordercode))
            {
                orders = orders.Where(x => x.OrderCode.Equals(kw_ordercode));
                ViewBag.kw_ordercode = kw_ordercode;
            }

            if (!string.IsNullOrEmpty(StatusId))
            {
                orders = orders.Where(x => x.StatusId.ToString().Equals(StatusId));
                ViewBag.kw_status = StatusId;
            }
            //else
            //{
            //    ViewBag.StatusId = 0;
            //}

            if (!string.IsNullOrEmpty(kw_customername))
            {
                orders = orders.Where(x => x.CustomerId != null && ChangeVN_EN.change(x.Customer.CustomerName.ToLower()).Contains(kw_customername.ToLower().Trim())
                || x.CustomerId != null && x.Customer.CustomerName.ToLower().Contains(kw_customername.ToLower().Trim()));
                ViewBag.kw_customername = kw_customername;
            }

            if (!string.IsNullOrEmpty(kw_daterange))
            {
                var dt = kw_daterange.Split('-');

                orders = orders.Where(x => x.OrderDate.Date >= DateTime.Parse(dt[0]) && x.OrderDate.Date <= DateTime.Parse(dt[1]));
                ViewBag.kw_daterange = kw_daterange;
            }


            if (string.IsNullOrEmpty(sort))
            {
                ViewBag.sort = "date_desc";
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
                case "total_asc":
                    orders = orders.OrderBy(x => x.OrderDetails.Sum(od => (od.UnitPrice - od.Discount) * od.Quantity));
                    ViewBag.sortstatus = "total_desc";
                    break;
                case "total_desc":
                    orders = orders.OrderByDescending(x => x.OrderDetails.Sum(od => (od.UnitPrice - od.Discount) * od.Quantity));
                    ViewBag.sortstatus = "total_asc";
                    break;
            }

            ViewBag.sortdate = ViewBag.sortdate ?? "date_desc";
            ViewBag.sorttotal = ViewBag.sortstatus ?? "total_asc";

            ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName");

            return View(orders.ToPagedList(pagenumber, pagesize));
        }


        // CREATE ORDER
        public ActionResult Create()
        {
            ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName");
            ViewBag.PaymentMethodId = new SelectList(db.PaymentMethods, "Id", "MethodName");
            ViewBag.ShippingId = new SelectList(db.Shippings.Where(x => x.IsActive == true), "Id", "ShippingName");

            return View();
        }

        [HttpPost]
        public ActionResult Create(Order data, string CouponCode)
        {
            if (ModelState.IsValid)
            {
                if (CouponCode != "")
                {
                    var coupon = db.Coupons.SingleOrDefault(x => x.CouponCode.Equals(CouponCode));
                    if (coupon == null)
                    {
                        ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName", data.StatusId);
                        ViewBag.PaymentMethodId = new SelectList(db.PaymentMethods, "Id", "MethodName", data.PaymentMethodId);
                        ViewBag.ShippingId = new SelectList(db.Shippings.Where(x => x.IsActive == true), "Id", "ShippingName", data.ShippingId);
                        ViewBag.coupon = "Coupon Code không chính xác";
                        return View();
                    }
                    data.CouponId = coupon.Id;
                }
                else
                {
                    data.CouponId = 1;
                }

                StringBuilder builder = new StringBuilder();
                Random rd = new Random();
                int number;

                for (int i = 0; i < 10; i++)
                {
                    //tạo random 1 kí tự
                    number = rd.Next(0, 9);
                    // add vào builder
                    builder.Append(number);
                }

                data.OrderCode = builder.ToString();
                data.OrderDate = DateTime.Now;
                data.EmployeeId = int.Parse(User.Identity.Name);
                db.Orders.Add(data);
                db.SaveChanges();

                SystemLogs.Create("Order", data.OrderCode);

                return RedirectToAction("Index");

            }

            ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName", data.StatusId);
            ViewBag.PaymentMethodId = new SelectList(db.PaymentMethods, "Id", "MethodName", data.PaymentMethodId);
            ViewBag.ShippingId = new SelectList(db.Shippings.Where(x => x.IsActive == true), "Id", "ShippingName", data.ShippingId);

            return View(data);

        }

        // ADD PRODUCTS
        public ActionResult AddProduct(int ProductId)
        {

            return View();
        }


        // SHOW ORDER DETAILS
        public ActionResult Edit(int id)
        {
            var order = orderRepository.GetModelById(id);
            ViewBag.StatusId = new SelectList(db.Statuses, "Id", "StatusName", order.StatusId);
            ViewBag.ProductId = new SelectList(db.Products, "Id", "ProductName");
            return View(order);
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

            if (data.Quantity < 0 || data.UnitPrice < data.Discount)
            {
                ViewBag.Msg = "Error!";
                return PartialView(data);
            }

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

            ViewBag.ShippingId = new SelectList(db.Shippings.Where(x => x.IsActive == true), "Id", "ShippingName");
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