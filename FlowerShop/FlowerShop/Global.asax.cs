using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using AutoMapper;
using FlowerShop.Models;

namespace FlowerShop
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            Mapper.Initialize(mp =>
           {
               // register
               mp.CreateMap<RegisterVM, Customer>();

               //update profile
               mp.CreateMap<UpdateProfileVM, Customer>();
               mp.CreateMap<Customer, UpdateProfileVM>();

               // order details
               mp.CreateMap<OrderDetailsVM, OrderDetail>();
               mp.CreateMap<OrderDetail, OrderDetailsVM>();

               //add shipper
               mp.CreateMap<AddShipperVM, Order>();
               mp.CreateMap<Order, AddShipperVM>();
           });
        }
    }
}
