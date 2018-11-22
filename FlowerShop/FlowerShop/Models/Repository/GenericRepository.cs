using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class GenericRepository<T> : IRepository<T> where T: class
    {
        private FlowerShoppingEntities db;
        private IDbSet<T> dbEntity;

        public GenericRepository()
        {
            db = new FlowerShoppingEntities();
            dbEntity = db.Set<T>();
        }

        public void DeleteModel(int modelId)
        {
            T model = dbEntity.Find(modelId);
            dbEntity.Remove(model);
        }

        public IEnumerable<T> GetModel()
        {
            return dbEntity.ToList();
        }

        public T GetModelById(int modelId)
        {
            return dbEntity.Find(modelId);
        }

        public void InsertModel(T model)
        {
            dbEntity.Add(model);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateModel(T model)
        {
            db.Entry(model).State = EntityState.Modified;
        }
    }
}