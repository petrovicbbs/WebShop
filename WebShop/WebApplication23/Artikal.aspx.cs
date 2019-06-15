using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication23
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        string komanda;
        SqlDataAdapter da;
        SqlConnection conn = konekcija.Connect();
        SqlCommand cmd;
        DataTable dt;
        static int naStanju;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentItemId"].ToString() == "")
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                int itemId = int.Parse(Session["currentItemId"].ToString());

                komanda = "EXECUTE getItem @itemId";
                da = new SqlDataAdapter(komanda, conn);
                da.SelectCommand.Parameters.AddWithValue("@itemId", itemId);
                dt = new DataTable();
                da.Fill(dt);

                naStanju = int.Parse(dt.Rows[0]["Stanje"].ToString());

                int katId = int.Parse(dt.Rows[0]["KatID"].ToString());
                string kategorija = dt.Rows[0]["Kategorija"].ToString();
                string naziv = dt.Rows[0]["Naziv"].ToString();
                float cena = float.Parse(dt.Rows[0]["Cena"].ToString());
                string opis = dt.Rows[0]["Opis"].ToString();               

                string pathItem = "/Images/Kategorija/" + katId + "/" + itemId + "/";
                int numPhoto = Directory.GetFiles(Server.MapPath("~") + pathItem, "*.png").Length;

                string galerija = "";
                string indikatori = "";

                for (int i = 0; i < numPhoto; i++)
                {
                    if (i == 0)
                    {
                        galerija += "<div class='carousel-item active'> ";
                        indikatori += "<li data-target='#carousel' data-slide-to='" + i + "' class='active'></li>";
                    }
                    else
                    {
                        galerija += "<div class='carousel-item'> ";
                        indikatori += "<li data-target='#carousel' data-slide-to='" + i + "'></li>";
                    }

                    galerija += "<img src='" + pathItem + (i + 1) + ".png' class='d-block w-100 slajdovi' alt='" + (i + 1) + "/3'>   </div>";
                }
                Galerija.InnerHtml = galerija;
                artikalKategorija.InnerText = kategorija;
                artikalNaziv.InnerText = naziv;
                artikalOpis.InnerText = opis;
                artikalCena.InnerText = cena.ToString() + " " + "RSD sa PDV-om";
                Indikatori.InnerHtml += indikatori;
            }
        }

        protected void inBasket_Click(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openLogIn();", true);
            }
            else
            {
                if (itemQty.Text != "" && int.Parse(itemQty.Text) <= naStanju)
                {
                    int itemId = int.Parse(Session["currentItemId"].ToString());
                    int qty = int.Parse(itemQty.Text.ToString());
                    int userId = int.Parse(Session["userId"].ToString());

                    komanda = "EXECUTE tmpKorpa @userId, @artikalId, @kolicina";
                    cmd = new SqlCommand(komanda, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@artikalId", itemId);
                    cmd.Parameters.AddWithValue("@kolicina", qty);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Redirect("Default.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "notEnough("+naStanju+");", true);
                }
            }
        }
    }
}
