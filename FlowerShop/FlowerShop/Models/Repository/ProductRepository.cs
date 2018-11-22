using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class ProductRepository: GenericRepository<Product>
    {
        public IEnumerable<Product> Getbykw_price(string kw_price)
        {
            try
            {
                var products = this.GetModel();
                var search = products.Where(x => x.UnitPrice.ToString().Equals(kw_price));
                return search;
            }
            catch (Exception)
            {
                throw;
            }
            
        }

        public IEnumerable<Product> Getbykw_productname(string kw_productname)
        {
            try
            {
                var products = this.GetModel();
                var search = products.Where(x => x.ProductName.ToLower().Contains(kw_productname.ToLower()));
                return search;
            }
            catch (Exception)
            {
                throw;
            }

        }

    }
}