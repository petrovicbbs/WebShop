using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication23
{
    public partial class Settings : System.Web.UI.Page
    {
        string komanda;
        SqlDataAdapter da;
        SqlConnection conn = konekcija.Connect();
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            loadTable("KatArt","");
            loadTable("Dobavljac", "");
            loadTable("Korisnik", "");
            string index = (ListBox3.SelectedIndex + 1).ToString();
            loadTable("Artikal", index);
        }
        public void loadTable(string table, string index)
        {
            string colomn;
            switch (table)
            {
                case "Korisnik": colomn = "userName"; break;
                default: colomn = "Naziv"; break;
            }
            if(table=="Artikal") komanda = "SELECT ID," + colomn + " FROM " + table + " WHERE KatArtID=" + index;
            else komanda = "SELECT ID," + colomn + " FROM " + table;
            da = new SqlDataAdapter(komanda, conn);
            dt = new DataTable();
            da.Fill(dt);
            bindTable(table, dt, colomn);
        }
        public void bindTable(string table, DataTable dt, string colomn="Naziv")
        {
            switch (table)
            {
                case "Artikal":
                    ListBox4.DataSource = dt;
                    ListBox4.DataTextField = colomn;
                    ListBox4.DataValueField = "ID";
                    ListBox4.DataBind();
                    break;
                case "KatArt":
                    KatArt.DataSource = ListBox3.DataSource = dt;
                    KatArt.DataTextField = ListBox3.DataTextField = colomn;
                    KatArt.DataValueField = ListBox3.DataValueField = "ID";
                    KatArt.DataBind();
                    ListBox3.DataBind();
                    ListBox3.SelectedIndex = 0;
                    break;
                case "Dobavljac":
                    Supplier.DataSource = ListBox1.DataSource = dt;
                    Supplier.DataTextField = ListBox1.DataTextField = colomn;
                    Supplier.DataValueField = ListBox1.DataValueField = "ID";
                    Supplier.DataBind();
                    ListBox1.DataBind();
                    break;
                case "Korisnik":
                    ListBox2.DataSource = dt;
                    ListBox2.DataTextField = colomn;
                    ListBox2.DataValueField = "ID";
                    ListBox2.DataBind();
                    break;
            }
        }


        protected void ListBox3_SelectedIndexChanged(object sender, EventArgs e)
        {
            string index = (ListBox3.SelectedIndex + 1).ToString();
            loadTable("Artikal", index);
        }      
    }
}