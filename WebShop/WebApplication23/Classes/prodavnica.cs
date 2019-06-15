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
    public class Prodavnica
    {
        private string komanda;
        private SqlDataAdapter da;
        private DataTable dt;
        private SqlConnection conn = konekcija.Connect();

        private int id;
        private string naziv;
        private string adresa;
        private int gradId;
        private string opis;

        public int Id { get => id; set => id = value; }
        public string Naziv { get => naziv; set => naziv = value; }
        public string Adresa { get => adresa; set => adresa = value; }
        public int GradId { get => gradId; set => gradId = value; }
        public string Opis { get => opis; set => opis = value; }

        public Prodavnica() { }

        public Prodavnica(int id) {
            id = Id;
        }


        public DataTable GetShop(int Id)
        {
            komanda = "EXECUTE getShop @shopId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@shopId", Id);
            dt = new DataTable();
            da.Fill(dt);

            return dt;
        }
    }
}