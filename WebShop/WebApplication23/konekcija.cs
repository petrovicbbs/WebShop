using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace WebApplication23
{
    public class konekcija
    {
        static public SqlConnection Connect()
        {
            SqlConnection conn = new SqlConnection(
            WebConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            return conn;
        }
    }
}