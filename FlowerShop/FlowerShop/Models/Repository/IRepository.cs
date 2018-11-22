using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FlowerShop.Models
{
    public interface IRepository<T> where T : class
    {
        IEnumerable<T> GetModel();
        T GetModelById(int modelId);
        void InsertModel(T model);
        void UpdateModel(T model);
        void DeleteModel(int modelId);
        void Save();
    }
}
