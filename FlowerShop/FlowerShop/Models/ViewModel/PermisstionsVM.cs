using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class PermisstionsVM
    {
        public int Id { get; set; }
        public int LevelId { get; set; }
        public string TableName { get; set; }
        public string DisplayName { get; set; }
        public bool View { get; set; }
        public bool Create { get; set; }
        public bool Edit { get; set; }
        public bool Delete { get; set; }
    }
}