using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class SystemLogs
    {
        public static void Create(string ControllerName, string Name)
        {
            using (FlowerShoppingEntities db = new FlowerShoppingEntities())
            {
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = int.Parse(HttpContext.Current.User.Identity.Name),
                    Log_Type_Id = 1,
                    Message = "Create new "+ ControllerName +": " + Name,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);
                db.SaveChanges();
            }
        }

        public static void Edit(string ControllerName, string Name)
        {
            using (FlowerShoppingEntities db = new FlowerShoppingEntities())
            {
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = int.Parse(HttpContext.Current.User.Identity.Name),
                    Log_Type_Id = 2,
                    Message = "Edit " + ControllerName + ": " + Name,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);
                db.SaveChanges();
            }
        }

        public static void Delete(string ControllerName, string Name)
        {
            using (FlowerShoppingEntities db = new FlowerShoppingEntities())
            {
                System_Logs s_l = new System_Logs()
                {
                    EmployeeId = int.Parse(HttpContext.Current.User.Identity.Name),
                    Log_Type_Id = 3,
                    Message = "Delete " + ControllerName + ": " + Name,
                    RegisterDate = DateTime.Now,
                };

                db.System_Logs.Add(s_l);
                db.SaveChanges();
            }
        }

    }
}