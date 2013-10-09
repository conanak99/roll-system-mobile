using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace RollSystemMobile.Models.BusinessObject
{
    public class AccountBusiness: GenericBusiness<User>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public AccountBusiness()
        {
            
        }
        public AccountBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public User CheckLogin(String Username, String Password)
        {
            return base.GetList().FirstOrDefault(u => u.Username.Equals(Username)
                             && u.Password.Equals(Password) && u.IsActive == true);
        }

        public User GetUserByID(int ID)
        {
            return base.GetList().FirstOrDefault(u => u.UserID == ID);
        }

        public User GetUserByUsername(String Username)
        {
            return base.GetList().FirstOrDefault(u => u.Username.Equals(Username));
        }
    }
}