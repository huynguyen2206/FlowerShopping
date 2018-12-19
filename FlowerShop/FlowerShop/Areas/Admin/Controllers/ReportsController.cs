using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlowerShop.Models;
using PagedList;

namespace FlowerShop.Areas.Admin.Controllers
{
    [AdminCustomAuthorize]
    public class ReportsController : Controller
    {
        private ProductRepository productRepository = new ProductRepository();
        private GenericRepository<Customer> customerRepository = new GenericRepository<Customer>();
        private GenericRepository<Employee> employeeRepository = new GenericRepository<Employee>();
        private GenericRepository<Shipping> shipperRepository = new GenericRepository<Shipping>();

        FlowerShoppingEntities db = new FlowerShoppingEntities();
        // GET: Admin/Reports
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult ReportEmployees()
        {
            var emp = db.Employees.ToList();
            return View(emp);
        }


        public ActionResult ReportProducts()
        {
            var products = db.Products.ToList();
            return View(products);
        }

        public ActionResult ReportOrders()
        {
            var orders = db.Orders.ToList();
            return View(orders);
        }

        public ActionResult ReportPrices(int? page_p_i, int? page_p_o, string kw_daterange)
        {
            int pagesize = 5;
            int pagenumber_p_i = page_p_i ?? 1;
            int pagenumber_p_o = page_p_o ?? 1;

            ViewBag.page_p_i = page_p_i;
            ViewBag.page_p_o = page_p_o;

            var ProductsInput = productRepository.GetModel().Where(x => x.Product_Logs.Count > 0);
            var ProductsOrders = productRepository.GetModel().Where(x => x.OrderDetails.Count > 0);

            if (!string.IsNullOrEmpty(kw_daterange))
            {
                var dt = kw_daterange.Split('-');
                ViewBag.kw = kw_daterange;
                ProductsInput = from p in ProductsInput
                                join l in db.Product_Logs on p.Id equals l.ProductId
                                where l.RegisterDate.Date >= DateTime.Parse(dt[0]) && l.RegisterDate.Date <= DateTime.Parse(dt[1])
                                select p;
                ProductsOrders = from p in ProductsOrders
                                 join od in db.OrderDetails on p.Id equals od.ProductId
                                 join o in db.Orders on od.OrderId equals o.Id
                                 where o.OrderDate.Date >= DateTime.Parse(dt[0]) && o.OrderDate.Date <= DateTime.Parse(dt[1])
                                 select p;
            }

            ViewBag.ProductsInput = ProductsInput.Distinct().ToPagedList(pagenumber_p_i, pagesize);
            ViewBag.ProductsOrders = ProductsOrders.Distinct().ToPagedList(pagenumber_p_o, pagesize);

            return View();
        }


        public ActionResult ReportUsers()
        {
            var customer = customerRepository.GetModel();
            var employee = employeeRepository.GetModel();
            var shipper = shipperRepository.GetModel();
            ViewBag.customer = customer;
            ViewBag.employee = employee;
            ViewBag.shipper = shipper;
            return View();
        }

    }
}