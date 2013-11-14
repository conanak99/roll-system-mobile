using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.HelperClass;

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

        public bool ChangeStatus(int UserID, bool NewStatus)
        {
            var User = GetList().FirstOrDefault(u => u.UserID == UserID);
            User.IsActive = NewStatus;

           return base.UpdateExist(User);
        }

        public User CreateUser(String FullName)
        {
            //Tu ten, cat ra cac ki tu dau
            var NameSplited = FullName.Split(' ');
            String Name = NameSplited.ElementAt(NameSplited.Length - 1);

            for (int i = 0; i < NameSplited.Length - 1; i++)
            {
                Name += NameSplited[i][0];
            }

            //Bo dau, bo viet hoa
            Name = Name.NonUnicode().ToLowerInvariant();

            if (Name.Length < 5)
            {
                Name = Name + "_user";
            }
            String FinalName = Name;

            int Suffix = 2;
            //Truong hop ta ra ten trung
            while (GetList().Any(us => us.Username.Equals(FinalName)))
            {
                FinalName = Name + Suffix;
                Suffix++;
            }

            User user = new User();
            user.Username = FinalName;
            user.Password = "123456";
            user.IsActive = true;
            user.RoleID = 1;
            base.Insert(user);

            return user;
        }
    }
}