using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication23
{
    public partial class _Default : Page
    {
        string komanda1;
        SqlDataAdapter da;
        SqlConnection conn = konekcija.Connect();
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {

            string artikli = "";
            int kategorija=0;

            if (Session["currentCatArt"] != null)
            {
                if (int.Parse(Session["currentCatArt"].ToString()) != 0)
                {
                    kategorija = int.Parse(Session["currentCatArt"].ToString());
                }
            }

            switch (kategorija)
            {
                case 0:
                    komanda1 = "EXECUTE shwArt";
                    break;
                default:
                    komanda1 = "EXECUTE shwArt " + kategorija + "";
                    break;
            }
            da = new SqlDataAdapter(komanda1, conn);
            dt = new DataTable();
            da.Fill(dt);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                int itemId = int.Parse(dt.Rows[i]["ID"].ToString());
                int itemCategory;
                if (kategorija == 0) itemCategory = int.Parse(dt.Rows[i]["KatArtID"].ToString());
                else itemCategory = kategorija;
                string itemPrice = dt.Rows[i]["Cena"].ToString();
                string itemName = dt.Rows[i]["Naziv"].ToString();
                if (int.Parse(dt.Rows[i]["Kolicina"].ToString()) > 0)
                {
                    string mainPhoto = "Images/Kategorija/" + itemCategory + "/" + itemId + "/1.png";
                    artikli += "<div class='col-12 col-sm-10 col-md-6 col-lg-6 col-xl-4'>	<div class='card bg-dark box-shadow'>	<img class='card-img-top' id='itemPhoto" + i + "' src='" + mainPhoto + "'>	<div class='card-body'>	<asp:HyperLink ID='item" + i + "' runat='server'>	<p class='card-text text-light' id='itemName" + i + "'>" + itemName + "</p>	</asp:HyperLink>	<div class='d-flex justify-content-between align-items-center'>	<div class='btn-group' role='group'>	<button type = 'button' class='btn btn-sm btn-outline-secondary detaljnije' id='detaljnije" + itemId + "' onclick='openItem();' Value=" + itemId + ">Detaljnije</button>	<button type='button' class='btn btn-sm btn-outline-secondary inBasket' id='inBasket" + itemId + "' runat='server' Value='" + itemId + "' >Ubaci u korpu</button>    	</div>	<h5>" + itemPrice + " RSD</h5>	</div>	</div>	</div>	</div>";
                }
            }
            parent.InnerHtml = artikli;
        }

        [WebMethod(enableSession: true)]
        public static void openItem(string item)
        {
            HttpContext.Current.Session["currentItemId"] = int.Parse(item);
        }

        [WebMethod(enableSession: true)]
        public static void openCategory(string category)
        {
            HttpContext.Current.Session["currentCatArt"] = category;
        }

        [WebMethod(enableSession: true)]
        public static void openFakturu(string racun)
        {
            HttpContext.Current.Session["oznakaRacuna"] = racun;
        }

        #region Dodaj u korpu artikal iz Default.aspx
        [WebMethod(enableSession: true)]
        public static void Kupi(string Id)
        {
            if (HttpContext.Current.Session["userId"] != null)
            {
                int askedQty = 1;
                int itemId = int.Parse(Id);
                string komanda = "EXECUTE getItem @itemId";
                DataTable dt = new DataTable();
                SqlConnection conn = konekcija.Connect();
                SqlDataAdapter da = new SqlDataAdapter(komanda, conn);
                da.SelectCommand.Parameters.AddWithValue("@itemId", itemId);
                da.Fill(dt);
                int naStanju = int.Parse(dt.Rows[0]["Stanje"].ToString());

                if (askedQty <= naStanju)
                {
                    int userId = int.Parse(HttpContext.Current.Session["userId"].ToString());

                    string komanda2 = "EXECUTE tmpKorpa @userId, @artikalId";
                    SqlCommand cmd = new SqlCommand(komanda2, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@artikalId", itemId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            else
            {
                //za otvaranje LogIn modala
            }
        }
        #endregion
    }
}