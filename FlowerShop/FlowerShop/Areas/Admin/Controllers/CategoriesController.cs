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
        private GenericRepository<Category> categoryRepository = new GenericRepository<Category>();
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // INDEX SHOW CATEGORIES
        public ActionResult Index(string kw)
        {

            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Categories");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            var categories = categoryRepository.GetModel();

            if (!string.IsNullOrEmpty(kw))
            {
                categories = db.Categories.Where(x => x.TopicId.ToString().Equals(kw));
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

                // ghi Log
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = 4,
                    Log_Type_Id = 1,
                    Message = "Create new Category: " + category.CategoryName,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);
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
            var category = categoryRepository.GetModelById(id);
            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName", category.TopicId);
            return PartialView(category);
        }

        [HttpPost]
        public ActionResult Edit(Category data)
        {
            if (ModelState.IsValid)
            {
                categoryRepository.UpdateModel(data);
                categoryRepository.Save();
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