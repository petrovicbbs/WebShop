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
    public class Artikal
    {
        private string komanda;
        private SqlDataAdapter da;
        private DataTable dt;
        private SqlConnection conn = konekcija.Connect();

        private int id;
        private string naziv;
        private int katArtId;
        private string opis;
        private int dobavljacId;
        private int cena;

        public int Id { get => id; set => id = value; }
        public string Naziv { get => naziv; set => naziv = value; }
        public int KatArtId { get => katArtId; set => katArtId = value; }
        public string Opis { get => opis; set => opis = value; }
        public int DobavljacId { get => dobavljacId; set => dobavljacId = value; }
        public int Cena { get => cena; set => cena = value; }

        public Artikal()
        {
        }

        public Artikal(int id)
        {
            id = Id;
        }

        public DataTable GetArt(int Id)
        {
            komanda = "EXECUTE getArt @itemId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@itemId", Id);
            dt = new DataTable();
            da.Fill(dt);

            return dt;
        }
    }
}