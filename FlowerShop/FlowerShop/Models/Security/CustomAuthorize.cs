using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Models
{
    public class CustomAuthorize : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (this.AuthorizeCore(filterContext.HttpContext))
            {
                base.OnAuthorization(filterContext);
            }
            else
            {
                filterContext.Result = new RedirectResult("~/Home/Index");
            }
        }
    }

    public class AdminCustomAuthorize : AuthorizeAttribute
    {
        public AdminCustomAuthorize()
        {
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (this.AuthorizeCore(filterContext.HttpContext))
            {
                var controller_name = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
                var action_name = filterContext.ActionDescriptor.ActionName;
                int number = 0;
                switch (action_name)
                {
                    case "Index": number = 1; break;
                    case "Create": number = 2; break;
                    case "Edit": number = 4; break;
                    case "Delete": number = 8; break;

                    case "RandomCoupon": number = 2; break;

                    case "AddShipper": number = 4; break;
                    case "OrderDetails": number = 4; break;
                    case "CancelOrder": number = 4; break;
                    case "ChangeStatus": number = 4; break;
                    default:
                        break;
                }

                using (var db = new FlowerShoppingEntities())
                {
                    try
                    {
                        var emp = db.Employees.Find(int.Parse(HttpContext.Current.User.Identity.Name));

                        var permisstion = db.LevelPermissions.SingleOrDefault(x => x.LevelId == emp.LevelId && x.TableName == controller_name);
                        if (permisstion != null)
                        {
                            bool isPermistion = Convert.ToBoolean(permisstion.Total & number);

                            if (number == 1 && !isPermistion)
                            {
                                filterContext.Result = new RedirectResult("~/Admin/Dashboard");
                            }
                            else
                            {
                                if (isPermistion)
                                {
                                    base.OnAuthorization(filterContext);
                                }
                                else
                                {
                                    filterContext.Result = new RedirectResult("~/Admin/" + controller_name + "/Index");
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                        filterContext.Result = new RedirectResult("~/Admin/Employees/Login");
                    }
                }

                base.OnAuthorization(filterContext);
            }
            else
            {
                filterContext.Result = new RedirectResult("~/Admin/Employees/Login");
            }
        }
    }
}