using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]

    public class CategoriesController : Controller
    {
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // INDEX SHOW CATEGORIES
        public ActionResult Index(string kw)
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Categories");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            var categories = db.Categories.ToList();

            if (!string.IsNullOrEmpty(kw))
            {
                categories = db.Categories.Where(x => x.TopicId.ToString().Equals(kw)).ToList();
            }

            return View(categories);
        }


        // CREATE CATEGORY
        [HttpGet]
        public ActionResult Create()
        {
            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName");

            return PartialView();
        }

        [HttpPost]
        public ActionResult Create(Category category)
        {
            try
            {
                category.CreateDate = DateTime.Now;

                db.Categories.Add(category);

                SystemLogs.Create("Category", category.CategoryName);

                db.SaveChanges();

                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                throw;
            }

        }


        // EDIT CATEGORY
        public ActionResult Edit(int id)
        {
            var category = db.Categories.Find(id);

            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName", category.TopicId);

            return PartialView(category);
        }

        [HttpPost]
        public ActionResult Edit(Category data)
        {
            
            if (ModelState.IsValid)
            {
                var category = db.Categories.Find(data.Id);
                category.CategoryName = data.CategoryName;
                category.TopicId = data.TopicId;
                category.ShowHomePage = data.ShowHomePage;
                category.CreateDate = DateTime.Now;
                category.IsActive = data.IsActive;
                
                SystemLogs.Edit("Category", data.CategoryName);
                
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName", data.TopicId);
            
            return View(data);
        }


        // DELETE
        public ActionResult Delete(int id)
        {
            try
            {
                var category = db.Categories.Find(id);
                db.Categories.Remove(category);
                SystemLogs.Delete("Category", category.CategoryName);
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