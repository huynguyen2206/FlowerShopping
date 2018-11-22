using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class DisableRepository: GenericRepository<Disable>
    {
        public string ShowDisable(string name)
        {
            var disable = this.GetModel();
            var d = disable.SingleOrDefault(x => x.DisableName.Equals(name));
            return d.IsActive.ToString();
        }
    }
}