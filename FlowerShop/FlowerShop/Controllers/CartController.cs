using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FlowerShop.Models;
using Newtonsoft.Json;

namespace FlowerShop.Controllers
{
    public class CartController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // SHOW INDEX CART
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CheckoutDisplay()
        {
            return View();
        }


        // CHECK OUT
        [HttpPost]
        public ActionResult Checkout(string data, int coupon, string receiver, string address, string phone)
        {
            var cart_items = JsonConvert.DeserializeObject<List<CartItem>>(data);

            if (cart_items == null || cart_items.Count == 0)
            {
                return Content("Giỏ Hàng Của Bạn Chưa Có Sản Phẩm!");
            }

            if (string.IsNullOrEmpty(receiver) || string.IsNullOrEmpty(address) || string.IsNullOrEmpty(phone))
            {
                return Content("Vui Lòng Nhập Đầy Đủ Thông Tin Người Nhận Hàng");
            }

            foreach (var item in cart_items)
            {
                var pid = db.Products.SingleOrDefault(x => x.Id.Equals(item.productid));

                if (pid.UnitPrice != item.price || pid.SalePrice != item.saleprice || pid.QuantityAvailable < item.quantity)
                {
                    return Content("Error!");
                }
            }

            if (!coupon.Equals(1))
            {
                var cp = db.Coupons.SingleOrDefault(x => x.Id.Equals(coupon));
                if (cp.IsActive == true)
                {
                    cp.IsActive = false;
                }
                else
                {
                    return Content("coupon");
                }
            }

            //if (User.Identity.IsAuthenticated && User.IsInRole("Admin"))
            //{
            //    FormsAuthentication.SignOut();
            //}

            Order order;
            
            if (!User.Identity.IsAuthenticated)
            {
                StringBuilder builder = new StringBuilder();
                Random rd = new Random();
                int number;

                for (int i = 0; i < 10; i++)
                {
                    //tạo random 1 kí tự
                    number = rd.Next(0,9);
                    // add vào builder
                    builder.Append(number);
                }

                order = new Order()
                {
                    OrderCode = builder.ToString(),
                    OrderDate = DateTime.Now,
                    StatusId = 1,
                    CouponId = coupon,
                    Discount = 0,
                    Tax = 0,
                    ShippingFee = 0,
                    PaymentMethodId = 1,
                    Receiver = receiver,
                    Address = address,
                    PhoneNumber = phone,
                };
            }
            else
            {
                var cus = db.Customers.SingleOrDefault(x => x.Email.Equals(User.Identity.Name));
                order = new Order()
                {
                    OrderDate = DateTime.Now,
                    StatusId = 1,
                    CustomerId = cus.Id,
                    CouponId = coupon,
                    Discount = 0,
                    Tax = 0,
                    ShippingFee = 0,
                    PaymentMethodId = 1,
                    Receiver = receiver,
                    Address = address,
                    PhoneNumber = phone,
                };
            }
            
            db.Orders.Add(order);
            db.SaveChanges();

            foreach (var item in cart_items)
            {
                var picture = item.picture.Split('\\').Last();
                OrderDetail od = new OrderDetail()
                {
                    OrderId = order.Id,
                    ProductId = item.productid,
                    Unit = "Lãng",
                    UnitPrice = item.price,
                    Discount = item.saleprice,
                    Quantity = item.quantity,
                    Tax = 0,
                    DescriptionLong = item.description,
                    ImageUrl = picture,
                };

                db.OrderDetails.Add(od);

            }

            db.SaveChanges();

            return Content("OK");
        }


        // CHECK COUPON
        public ActionResult Coupon(string code)
        {
            var ccode = db.Coupons.SingleOrDefault(x => x.CouponCode.Equals(code));

            if (ccode == null)
            {
                return Content("error");
            }

            if (ccode.IsActive == false)
            {
                return Content("unique");
            }

            return Content((ccode.Price.ToString("N0")) + "|" + ccode.Id);
        }


        public ActionResult CheckoutLog()
        {
            return View();
        }


    }
}