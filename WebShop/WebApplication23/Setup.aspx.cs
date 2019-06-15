using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication23
{
    public partial class Contact : Page
    {
        string komanda = "";
        SqlConnection conn = konekcija.Connect();
        SqlDataAdapter da;
        DataTable dt = new DataTable();
                                                                           
        protected void Page_Load(object sender, EventArgs e)
        {
            ListBox1.Items.Clear();
            dt.Clear();
            komanda = "EXEC listItems 'Dobavljac'";
            da = new SqlDataAdapter(komanda, conn);
            da.Fill(dt);
            ListBox1.DataSource = dt;
            ListBox1.DataTextField = "Naziv";
            ListBox1.DataBind();

            ListBox2.Items.Clear();
            dt.Clear();
            komanda = "EXEC listItems 'Prodavnica'";
            da = new SqlDataAdapter(komanda, conn);
            da.Fill(dt);
            ListBox2.DataSource = dt;
            ListBox2.DataTextField = "Naziv";
            ListBox2.DataBind();

            ListBox3.Items.Clear();
            dt.Clear();
            komanda = "EXEC listItems 'KatArt'";
            da = new SqlDataAdapter(komanda, conn);
            da.Fill(dt);
            ListBox3.DataSource = dt;
            ListBox3.DataTextField = "Naziv";
            ListBox3.DataBind();
            ListBox3.SelectedIndex = 0;

            ListBox4.Items.Clear();
            dt.Clear();
            komanda = "SELECT Naziv FROM Artikal WHERE KatArtID='" + (ListBox3.SelectedIndex + 1).ToString() + "'";
            da = new SqlDataAdapter(komanda, conn);
            da.Fill(dt);
            ListBox4.DataSource = dt;
            ListBox4.DataTextField = "Naziv";
            ListBox4.DataBind();
            dt.Clear();

        }


        public void ButtonID1_Click(object sender, EventArgs e)
        {
            //komanda = "INSERT INTO Koverat VALUES (" +  +" Naziv FROM Svrha";

        }

        protected void ListBox3_SelectedIndexChanged(object sender, EventArgs e)
        {/*
            ListBox4.Items.Clear();
            dt.Clear();
            komanda = "SELECT Naziv FROM Artikal WHERE KatArtID='" + (ListBox3.SelectedIndex + 1).ToString() + "'";
            da = new SqlDataAdapter(komanda, conn);
            da.Fill(dt);
            ListBox4.DataSource = dt;
            ListBox4.DataTextField = "Naziv";
            ListBox4.DataBind();
            dt.Clear();*/
        }
    }
}