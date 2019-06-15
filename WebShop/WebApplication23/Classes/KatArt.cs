using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace WebApplication23.Classes
{
    public class KatArt
    {
        private string komanda;
        private SqlDataAdapter da;
        private DataTable dt;
        private SqlConnection conn = konekcija.Connect();

        private int id;
        private string naziv;

        public int Id { get => id; set => id = value; }
        public string Naziv { get => naziv; set => naziv = value; }

        public KatArt()
        {
        }

        public KatArt(int id)
        {
            Id = id;
        }

        public DataTable GetKatArt(int Id)
        {
            komanda = "EXECUTE GetKatArt @catArtId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@catArtId", Id);
            dt = new DataTable();
            da.Fill(dt);

            return dt;

        }
    }
}