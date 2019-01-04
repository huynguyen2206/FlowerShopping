using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class BannersController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        
        // INDEX
        public ActionResult Index(int? page)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Banners");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            int pagesize = 10;
            int pagenumber = page ?? 1;

            var banners = db.Banners.ToList();
            return View(banners.ToPagedList(pagenumber, pagesize));
        }


        // CREATE
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Banner data, HttpPostedFileBase img)
        {
            string ImageName = Security.Encrypt(DateTime.Now.Ticks.ToString()) + img.FileName.Split('\\').Last();
            string path = Server.MapPath("~/Uploads/Banners/");
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            img.SaveAs(path + "\\" + ImageName);

            Banner banner = new Banner()
            {
                PictureUrl = ImageName,
                ShowHomePage = data.ShowHomePage,
                Tittle = data.Tittle,
                Url = data.Url,
            };

            db.Banners.Add(banner);
            db.SaveChanges();

            return RedirectToAction("Index");
        }


        // EDIT
        public ActionResult Edit(int id)
        {
            var banner = db.Banners.Find(id);
            return View(banner);
        }

        [HttpPost]
        public ActionResult Edit(Banner data, HttpPostedFileBase img)
        {
            var banner = db.Banners.Find(data.Id);

            if(img != null)
            {
                string ImageName = Security.Encrypt(DateTime.Now.Ticks.ToString()) + img.FileName.Split('\\').Last();
                string path = Server.MapPath("~/Uploads/Banners/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                img.SaveAs(path + "\\" + ImageName);

                if (System.IO.File.Exists(path + banner.PictureUrl))
                {
                    System.IO.File.Delete(path + banner.PictureUrl);
                }
                banner.PictureUrl = ImageName;
            }
            
            banner.Url = data.Url;
            banner.Tittle = data.Tittle;
            banner.ShowHomePage = data.ShowHomePage;
            db.SaveChanges();

            return RedirectToAction("Index");
        }


        // DELETE
        public ActionResult Delete(int id)
        {
            try
            {
                var banner = db.Banners.Find(id);
                db.Banners.Remove(banner);

                string path = Server.MapPath("~/Uploads/Banners/");
                if (System.IO.File.Exists(path + banner.PictureUrl))
                {
                    System.IO.File.Delete(path + banner.PictureUrl);
                }

                SystemLogs.Delete("Banner", banner.Tittle);
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