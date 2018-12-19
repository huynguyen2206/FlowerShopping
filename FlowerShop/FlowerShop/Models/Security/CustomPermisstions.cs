using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FlowerShop.Models;

namespace FlowerShop.Models
{
    public class CustomPermisstions
    {
        public static PermisstionsVM CheckPermisstion(string TableName)
        {
            using (var db = new FlowerShoppingEntities())
            {
                var emp = db.Employees.Find(int.Parse(HttpContext.Current.User.Identity.Name));
                var permisstion = db.LevelPermissions.SingleOrDefault(x => x.LevelId == emp.LevelId && x.TableName == TableName);
                var per = new PermisstionsVM()
                {
                    //View = Convert.ToBoolean(permisstion.Total & 1),
                    Create = Convert.ToBoolean(permisstion.Total & 2),
                    Edit = Convert.ToBoolean(permisstion.Total & 4),
                    Delete = Convert.ToBoolean(permisstion.Total & 8),
                };
                
                return per;
            }

        }

    }
}