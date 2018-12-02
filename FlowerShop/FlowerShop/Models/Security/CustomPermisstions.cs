using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FlowerShop.Models;

namespace FlowerShop.Models
{
    public class CustomPermisstions
    {
        public static PermisstionsVM CheckPermisstion(int id, string TableName)
        {
            using (var db = new FlowerShoppingEntities())
            {
                var emp = db.Employees.Find(id);
                var permisstion = db.LevelPermissions.SingleOrDefault(x => x.LevelId == emp.LevelId && x.TableName == TableName);
                var per = new PermisstionsVM()
                {
                    View = Convert.ToBoolean(permisstion.Total & 1),
                    Create = Convert.ToBoolean(permisstion.Total & 2),
                    Edit = Convert.ToBoolean(permisstion.Total & 4),
                    Delete = Convert.ToBoolean(permisstion.Total & 8),
                };
                
                return per;
            }

        }

        public static bool CheckPermisstion(int id, string TableName, int number)
        {
            using (var db = new FlowerShoppingEntities())
            {
                var emp = db.Employees.Find(id);
                var permisstion = db.LevelPermissions.SingleOrDefault(x => x.LevelId == emp.LevelId && x.TableName == TableName);
                return Convert.ToBoolean(permisstion.Total & number);
            }

        }

    }
}