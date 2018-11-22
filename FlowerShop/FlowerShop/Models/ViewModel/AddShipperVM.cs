using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class AddShipperVM
    {
        public int Id { get; set; }
        public Nullable<int> ShippingId { get; set; }
    }
}