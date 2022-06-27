using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace ElibraryManagment
{
    public static class DbConnection
    {
        static string constring = ConfigurationManager.ConnectionStrings["ElibaryDB"].ConnectionString;

        public static string DataBaseConnection
        {
            get { return constring; }
        }
    }
}