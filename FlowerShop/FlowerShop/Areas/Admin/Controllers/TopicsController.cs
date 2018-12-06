using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class TopicsController : Controller
    {
        private GenericRepository<Topic> topicRepository = new GenericRepository<Topic>();
        FlowerShoppingEntities db = new FlowerShoppingEntities();
        // GET: Admin/Topics
        public ActionResult Index()
        {
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Topics");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            var topic = topicRepository.GetModel();
            return View(topic);
        }


        // CREATE TOPIC
        [HttpGet]
        public ActionResult Create()
        {
            return PartialView();
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Create(Topic topic)
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
        public ActionResult Edit(int id)
        {
            var topic = topicRepository.GetModelById(id);
            return PartialView(topic);
        }

        [HttpPost]
        public ActionResult Edit(Topic data)
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