using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize(Roles = "Admin, Manager, Seller")]
    public class CouponsController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        
        // SHOW INDEX COUPON
        public ActionResult Index(int? page, string kw, string sort)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion(int.Parse(User.Identity.Name), "Coupon");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();
            if (!per.View)
            {
                return RedirectToAction("Index", "Dashboard");
            }

            int pagenumber = page ?? 1;
            int pagesize = 10;
            var coupon = db.Coupons.OrderByDescending(x => x.Id);

            if (!string.IsNullOrEmpty(kw))
            {
                coupon = coupon.Where(x => x.Price.ToString().Equals(kw)).OrderByDescending(x => x.Id);
                ViewBag.kw = kw;
            }

            if (string.IsNullOrEmpty(sort))
            {
                ViewBag.sort = "price_asc";
            }
            else
            {
                ViewBag.sort = sort;
            }

            switch (sort)
            {
                case "price_asc":
                    coupon = coupon.OrderBy(x => x.Price);
                    ViewBag.sortprice = "price_desc";
                    break;
                case "price_desc":
                    coupon = coupon.OrderByDescending(x => x.Price);
                    ViewBag.sortprice = "price_asc";
                    break;
                case "active_asc":
                    coupon = coupon.OrderBy(x => x.IsActive);
                    ViewBag.sortactive = "active_desc";
                    break;
                case "active_desc":
                    coupon = coupon.OrderByDescending(x => x.IsActive);
                    ViewBag.sortactive = "active_asc";
                    break;
            }

            ViewBag.sortprice = ViewBag.sortprice ?? "price_desc";
            ViewBag.sortactive = ViewBag.sortactive ?? "active_asc";

            return View(coupon.ToPagedList(pagenumber, pagesize));
        }




        // GET RANDOM COUPON
        public ActionResult RandomCoupon(string number, string price)
        {
            bool per = CustomPermisstions.CheckPermisstion(int.Parse(User.Identity.Name), "Coupon", 2);
            if (!per)
            {
                return RedirectToAction("Index");
            }
            if (string.IsNullOrEmpty(number))
            {
                //return Content("Vui lòng nhập số lượng");
                number = "1";
            }

            if (string.IsNullOrEmpty(price))
            {
                return Content("Vui lòng nhập giá trị khuyến mãi");
            }
            
            // tạo random coupon
            Random rd = new Random();
            char ch;

            // vòng for tạo ra số lượng coupon theo "number" truyền vào
            for (int j = 0; j < int.Parse(number); j++)
            {
                StringBuilder builder = new StringBuilder();

                // vòng for tạo ra random số lượng kí tự trong 1 coupon
                for (int i = 0; i < 10; i++)
                {
                    //tạo random 1 kí tự
                    ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * rd.NextDouble() + 65)));
                    // add vào builder
                    builder.Append(ch);
                }

                // add vào db
                Coupon cp = new Coupon()
                {
                    // kết thúc vòng for tạo đủ 10 kí tự sau đó add vào CouponCode
                    CouponCode = builder.ToString(),
                    Price = decimal.Parse(price),
                    IsActive = true,
                    Quantity = 1,
                    RegisterDate = DateTime.Now,
                    InitDate = DateTime.Now,
                    FinishDate = DateTime.Now,
                    UseDate = DateTime.Now,
                };

                db.Coupons.Add(cp);
            }

            db.SaveChanges();

            return Content("OK");

        }


        // DELETE
        public ActionResult Delete(int id)
        {
            bool per = CustomPermisstions.CheckPermisstion(int.Parse(User.Identity.Name), "Coupon", 8);
            if (!per)
            {
                return RedirectToAction("Index");
            }
            try
            {
                var coupon = db.Coupons.Find(id);

                db.Coupons.Remove(coupon);
                db.SaveChanges();

                return Content("OK");
            }
            catch (Exception ex)
            {
                return Content(ex.Message);
            }

        }




    }
}