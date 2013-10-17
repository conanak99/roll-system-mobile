using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models;

namespace RollSystemMobile.Models.BusinessObject
{
    /// <summary>
    /// Base business class for using in other normal business classes
    /// </summary>
    /// <typeparam name="T">T is instance of BookmanagementEntities entity</typeparam>
    public class GenericBusiness<T> where T : class
    {
        /// <summary>
        /// Book management entities class
        /// </summary>
        protected RSMEntities RollSystemDB { get; set; }

        /// <summary>
        /// Create 
        /// </summary>
        public GenericBusiness()
        {
            this.RollSystemDB = new RSMEntities();
        }

        public GenericBusiness(RSMEntities DB)
        {
            this.RollSystemDB = DB;
        }

        /// <summary>
        /// Get list of entities T
        /// </summary>
        /// <returns></returns>
        public List<T> GetList()
        {
            return RollSystemDB.CreateObjectSet<T>().ToList();
        }

        public List<T> Find(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
        {
            return RollSystemDB.CreateObjectSet<T>().Where(predicate).ToList();
        }

        public T FindSingle(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
        {
            return RollSystemDB.CreateObjectSet<T>().FirstOrDefault(predicate);
        }

        /// <summary>
        /// Insert entity which is instance of T class
        /// </summary>
        /// <param name="entity">entity need to be inserted</param>
        /// <returns></returns>
        public bool Insert(T entity)
        {
            try
            {
                RollSystemDB.CreateObjectSet<T>().AddObject(entity);
                RollSystemDB.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Update entity which is instance of T class
        /// </summary>
        /// <param name="entity">entity need to be updated.</param>
        /// <returns></returns>
        public bool Update(T entity)
        {
            try
            {
                RollSystemDB.CreateObjectSet<T>().Attach(entity);
                RollSystemDB.ObjectStateManager.ChangeObjectState(entity, System.Data.EntityState.Modified);        
                // .Entry(entity).State = System.Data.EntityState.Modified;          
                RollSystemDB.SaveChanges();
                return true;
            }
            catch(Exception e)
            {
                throw e;    
            }
        }

        public bool Detach(T entity)
        {
            try
            {
                RollSystemDB.CreateObjectSet<T>().Detach(entity);
                return true;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public bool UpdateExist(T entity)
        {
            try
            {
                RollSystemDB.CreateObjectSet<T>().Detach(entity);
                RollSystemDB.CreateObjectSet<T>().Attach(entity);
                RollSystemDB.ObjectStateManager.ChangeObjectState(entity, System.Data.EntityState.Modified);        
                RollSystemDB.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// Delete entity which is instance of T class
        /// </summary>
        /// <param name="entity">entity need to be deleted</param>
        /// <returns></returns>
        public bool Delete(T entity)
        {
            try
            {
                RollSystemDB.CreateObjectSet<T>().DeleteObject(entity);
                RollSystemDB.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}