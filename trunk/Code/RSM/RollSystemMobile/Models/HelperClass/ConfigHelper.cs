using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using RollSystemMobile.Models.ViewModels;
using System.Xml.Serialization;

namespace RollSystemMobile.Models.HelperClass
{
    public static class ConfigHelper
    {
        private static String ConfigFilePath;

        public static void SetConfigFile(String FilePath)
        {
            ConfigFilePath = FilePath;
        }

        public static ConfigModel GetConfig()
        {
            if (!File.Exists(ConfigFilePath))
            {
                //Neu file ko ton tai, tra default
                return new ConfigModel();
            }
            else
            {
                XmlSerializer _xmlSerializer = new XmlSerializer(typeof(ConfigModel));
                Stream stream = new FileStream(ConfigFilePath, FileMode.Open, FileAccess.Read);
                ConfigModel Model = (ConfigModel)_xmlSerializer.Deserialize(stream);
                stream.Close();
                return Model;
                
            }
        }

        public static void SaveConfig(ConfigModel Model)
        {
            XmlSerializer _xmlserializer = new XmlSerializer(typeof(ConfigModel));
            Stream stream = new FileStream(ConfigFilePath, FileMode.Create);
            _xmlserializer.Serialize(stream, Model);
            stream.Close();
        }

    }
}
