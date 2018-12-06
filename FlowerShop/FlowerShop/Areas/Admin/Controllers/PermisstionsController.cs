using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize(Roles = "Admin")]
    public class PermisstionsController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        // GET: Admin/Permisstions
        public ActionResult Index(string LevelId)
        {
            if (LevelId == null) LevelId = "1";
            var permisstions = db.LevelPermissions.Where(x => x.LevelId.ToString().Equals(LevelId)).ToList();
            List<PermisstionsVM> list = new List<PermisstionsVM>();

            foreach(var item in permisstions)
            {
                var per = new PermisstionsVM()
                {
                    Id = item.Id,
                    LevelId = item.LevelId,
                    TableName = item.TableName,
                    DisplayName = item.DisplayName,
                    View = Convert.ToBoolean(item.Total & 1),
                    Create = Convert.ToBoolean(item.Total & 2),
                    Edit = Convert.ToBoolean(item.Total & 4),
                    Delete = Convert.ToBoolean(item.Total & 8),
                };

                list.Add(per);
            }

            ViewBag.LevelId = new SelectList(db.Levels, "Id", "LevelName");

            return View(list);
        }


        public ActionResult Change(string pid, string pnumber)
        {
            var permisstion = db.LevelPermissions.Find(int.Parse(pid));
            bool check = Convert.ToBoolean(permisstion.Total & int.Parse(pnumber));

            if(check)
            {
                permisstion.Total -= int.Parse(pnumber);
            }
            else
            {
                permisstion.Total += int.Parse(pnumber);
            }
            
            db.SaveChanges();

            return Content("OK");
        }


        public ActionResult AddLevel()
        {
            return PartialView();
        }

        [HttpPost]
        public ActionResult AddLevel(Level data)
        {
            string[] TableName = {"Orders", "Coupons", "Products", "Employees", "Customers", "Categories", "Shippers", "Topics" };
            string[] DisplayName = { "Orders Manager", "Coupons Manager", "Products Manager", "Employees Manager", "Customers Manager", "Categories manager", "Shippers Manager", "Topics Manager" };

            try
            {
                Level level = new Level()
                {
                    LevelName = data.LevelName
                };

                db.Levels.Add(level);
                db.SaveChanges();

                for (int i = 0; i < TableName.Length; i++)
                {
                    LevelPermission per = new LevelPermission()
                    {
                        LevelId = level.Id,
                        TableName = TableName[i],
                        DisplayName = DisplayName[i],
                        Total = 1,
                    };
                    db.LevelPermissions.Add(per);
                }

                db.SaveChanges();

                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                throw;
            }
            
        }

    }
}