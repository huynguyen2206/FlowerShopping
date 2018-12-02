using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace FlowerShop.Models
{
    public class CustomRoleProvider : RoleProvider
    {
        public override string ApplicationName { get; set; }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetRolesForUser(string username)
        {
            using (var db = new FlowerShoppingEntities())
            {
                var emp = db.Employees.SingleOrDefault(x => x.Id.ToString().Equals(username));
                if(emp != null)
                {
                    return new string[] { emp.Level.LevelName };
                }
                else
                {
                    return new string[] { "" };
                }
            }
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            using (var db = new FlowerShoppingEntities())
            {
                var emp = db.Employees.SingleOrDefault(x => x.Id.ToString().Equals(username));
                return emp.Level.LevelName.Equals(roleName);
            }
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}