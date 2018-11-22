using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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

            if (!User.Identity.IsAuthenticated)
            {
                return Content("Bạn phải đăng nhập trước khi thanh toán");
            }

            if (string.IsNullOrEmpty(receiver) || string.IsNullOrEmpty(address) || string.IsNullOrEmpty(phone))
            {
                return Content("Vui Lòng Nhập Đầy Đủ Thông Tin Người Nhận Hàng");
            }

            foreach (var item in cart_items)
            {
                var pid = db.Products.SingleOrDefault(x => x.Id.Equals(item.productid));

                if (pid.UnitPrice != item.price || pid.SalePrice != item.saleprice)
                {
                    return Content("Error!");
                }
            }

            if(!coupon.Equals(1))
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

            Order o = new Order()
            {
                OrderDate = DateTime.Now,
                StatusId = 1,
                CustomerId = int.Parse(User.Identity.Name),
                CouponId = coupon,
                Discount = 0,
                Tax = 0,
                ShippingFee = 0,
                PaymentMethodId = 1,
                Receiver = receiver,
                Address = address,
                PhoneNumber = phone,
            };

            db.Orders.Add(o);
            db.SaveChanges();

            foreach (var item in cart_items)
            {
                var picture = item.picture.Split('\\').Last();
                OrderDetail od = new OrderDetail()
                {
                    OrderId = o.Id,
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



    }
}