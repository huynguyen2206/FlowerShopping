using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class CartItem
    {
        public int productid { get; set; }
        public int price { get; set; }
        public int saleprice { get; set; }
        public int quantity { get; set; }
        public string description { get; set; }
        public string picture { get; set; }
    }
}