using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using AutoMapper;
using FlowerShop.Models;

namespace FlowerShop.Controllers
{
    public class CustomerController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // REGISTER
        [HttpGet]
        public ActionResult Register()
        {
            Session.Abandon();
            return View();
        }

        [HttpPost]
        public ActionResult Register(HttpPostedFileBase img, RegisterVM data)
        {
            try
            {
                Customer cus = Mapper.Map<Customer>(data);
                cus.Password = Security.Encrypt(data.Password);
                cus.RegisterDate = DateTime.Now;
                cus.VIP = false;
                cus.IsActive = true;
                cus.ImageUrl = "";

                db.Customers.Add(cus);
                db.SaveChanges();

                string path = Server.MapPath("~/Uploads/Customers/" + cus.Id);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                string ImageName = img.FileName.Split('\\').Last();
                img.SaveAs(path + "\\" + ImageName);

                var customer = db.Customers.Find(cus.Id);
                customer.ImageUrl = ImageName;
                

                db.SaveChanges();

                return RedirectToAction("Index", "Home");
            }
            catch (Exception)
            {
                throw;
            }
        }


        // LOGIN
        public ActionResult Login(string Email, string Password)
        {
            try
            {
                if (string.IsNullOrEmpty(Email))
                {
                    return Content("Vui lòng nhập Email");
                }

                if (string.IsNullOrEmpty(Password))
                {
                    return Content("Vui lòng nhập Pasword");
                }

                var cus = db.Customers.SingleOrDefault(x => x.Email.Equals(Email));
                if (cus == null)
                {
                    return Content("Email chưa được đăng ký");
                }

                if (!cus.Password.Equals(Security.Encrypt(Password)))
                {
                    if (Session["login_log"] != null)
                    {
                        if (Session["login_log2"] != null)
                        {
                            Session["login_log3"] = "login_log3";
                            Session.Timeout = 1;
                            return Content("LoginLog");
                        }
                        Session["login_log2"] = "login_log2";
                    }
                    Session["login_log"] = "login_log";
                    return Content("Password không chính xác");
                }

                if (!cus.IsActive)
                {
                    return Content("Tài Khoản đã bị khóa, vui lòng kích hoạt tài khoản hoặc gọi đến xxx-xxx để nhận được sự hỗ trợ");
                }

                Session.Abandon();
                FormsAuthentication.SetAuthCookie(cus.Id.ToString(), false);
                Response.Cookies["name"].Value = cus.CustomerName;
                
                return Content("OK");
            }
            catch (Exception)
            {
                throw;
            }
        }


        // LOGOUT
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        [CustomAuthorize]
        public ActionResult MyAccount()
        {
            int id = int.Parse(User.Identity.Name);
            var cus = db.Customers.Find(id);

            UpdateProfileVM data = Mapper.Map<UpdateProfileVM>(cus);
            return View(data);
        }


        // View Update Profile and Change Password
        [HttpGet]
        public ActionResult UpdateAndChange()
        {
            return View();
        }

        // UPDATE PROFILE
        [HttpGet]
        public PartialViewResult UpdateProfile()
        {
            try
            {
                int id = int.Parse(User.Identity.Name);
                var cus = db.Customers.Find(id);

                UpdateProfileVM data = Mapper.Map<UpdateProfileVM>(cus);
                return PartialView(data);
            }
            catch (Exception)
            {
                throw;
            }
        }

        [HttpPost]
        public ActionResult UpdateProfile(UpdateProfileVM data, HttpPostedFileBase img)
        {
            int id = int.Parse(User.Identity.Name);
            var cus = db.Customers.Find(id);

            string path = Server.MapPath("/Uploads/Customers/") + id + "\\" + cus.ImageUrl;

            if (System.IO.File.Exists(path))
            {
                System.IO.File.Delete(path);
            }
            string path_new = Server.MapPath("~/Uploads/Customers/" + cus.Id);
            if (!Directory.Exists(path_new))
            {
                Directory.CreateDirectory(path_new);
            }

            string ImageName = img.FileName.Split('\\').Last();
            img.SaveAs(path_new + "\\" + ImageName);
            Mapper.Map(data, cus);
            cus.ImageUrl = ImageName;

            db.SaveChanges();

            return RedirectToAction("MyAccount");
        }


        //CHANGE PASSWORD
        public ActionResult ChangePassword(string Password, string NewPassword, string RePassword)
        {
            if (string.IsNullOrEmpty(NewPassword) || !NewPassword.Equals(RePassword))
            {
                return Content("New Password invalid!");
            }

            if (!NewPassword.Equals(RePassword))
            {
                return Content("New Password invalid!");
            }

            try
            {
                int id = int.Parse(User.Identity.Name);
                var cus = db.Customers.Find(id);

                if (cus.Password.Equals(Password))
                {
                    cus.Password = NewPassword;
                    db.SaveChanges();
                    return Content("OK");
                }
                else
                {
                    return Content("Current Password wrong!");
                }
            }
            catch (Exception)
            {
                return Content("Error!");
            }
        }

        // FORGET PASSWORD
        public ActionResult ForgetPassword(string myemail)
        {
            var cus = db.Customers.SingleOrDefault(x => x.Email.Equals(myemail));
            if (cus == null)
            {
                return Content("Email của bạn chưa được đăng ký");
            }

            string token = Security.Encrypt(DateTime.Now.Ticks + cus.Id.ToString() + "thienbienvanhoa");
            cus.RegisterToten = token;
            db.SaveChanges();

            string email = cus.Email;
            string subject = "Your lost password?";
            string body = "<a href = 'http://localhost:64803/Customer/Activate?token=" + token + "'>Click here to change your password</a>";

            SentMail.Sent(email, subject ,body);

            return Content("OK");
        }


        // ACTIVE TOKEN
        public ActionResult Activate(string token)
        {
            try
            {
                var cus = db.Customers.SingleOrDefault(x => x.RegisterToten.Equals(token));
                if (cus == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                ActivatePasswordVM data = new ActivatePasswordVM()
                {
                    Id = cus.Id,
                };

                return View(data);
            }
            catch (Exception)
            {

                throw;
            }
            
        }

        [HttpPost]
        public ActionResult Activate(ActivatePasswordVM data)
        {
            try
            {
                var cus = db.Customers.Find(data.Id);

                cus.Password = Security.Encrypt(data.Password);
                cus.RegisterToten = "";
                db.SaveChanges();

                return RedirectToAction("Index", "Home");
            }
            catch (Exception)
            {

                throw;
            }
        }


    }
}