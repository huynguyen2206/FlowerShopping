using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class CategoriesController : Controller
    {
        private GenericRepository<Category> categoryRepository = new GenericRepository<Category>();
        private GenericRepository<Topic> topicRepository = new GenericRepository<Topic>();
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // INDEX SHOW CATEGORIES
        public ActionResult Index(string kw)
        {
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
        

        // SHOW TOPIC
        public ActionResult Topic()
        {
            var topic = topicRepository.GetModel();
            return View(topic);
        }


        // CREATE TOPIC
        [HttpGet]
        public ActionResult CreateTopic()
        {
            return PartialView();
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult CreateTopic(Topic topic)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    topic.CreateDate = DateTime.Now;
                    db.Topics.Add(topic);

                    // ghi Log
                    System_Logs s_l = new System_Logs()
                    {
                        EmployeeId = 4,
                        Log_Type_Id = 1,
                        Message = "Create new Topic: " + topic.TopicName,
                        RegisterDate = DateTime.Now,
                    };

                    db.System_Logs.Add(s_l);
                    db.SaveChanges();
                }
                return RedirectToAction("Topic");
            }
            catch (Exception)
            {
                throw;
            }
        }


        // EDIT TOPIC
        public ActionResult EditTopic(int id)
        {
            var topic = topicRepository.GetModelById(id);
            return PartialView(topic);
        }

        [HttpPost]
        public ActionResult EditTopic(Topic data)
        {
            if (ModelState.IsValid)
            {
                topicRepository.UpdateModel(data);
                topicRepository.Save();
                return RedirectToAction("Index");
            }
            return View(data);
        }




    }
}