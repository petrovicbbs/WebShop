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

namespace WebApplication23
{
    public class Dobavljac
    {
        private string komanda;
        private SqlDataAdapter da;
        private DataTable dt;
        private SqlConnection conn = konekcija.Connect();

        private int id;
        private string naziv;
        private string adresa;
        private string grad;
        private string pib;
        private string matBr;
        private int gradId;

        public int Id { get => id; set => id = value; }
        public string Naziv { get => naziv; set => naziv = value; }
        public string Adresa { get => adresa; set => adresa = value; }
        public string Grad { get => grad; set => grad = value; }
        public string Pib { get => pib; set => pib = value; }
        public string MatBr { get => matBr; set => matBr = value; }
        public int GradId { get => gradId; set => gradId = value; }

        public Dobavljac()
        {
        }

        public Dobavljac(int id)
        {
            id = Id;
        }

        public DataTable GetSupplier(int Id)
        {
            komanda = "EXECUTE getSupplier @supplierId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@supplierId", Id);
            dt = new DataTable();
            da.Fill(dt);

            return dt;
        }
    }
}