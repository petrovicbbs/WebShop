using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication23
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string komanda;
        SqlDataAdapter da;
        SqlConnection conn = konekcija.Connect();
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            string shops = "";
            komanda = "EXECUTE showProdavnice";
            da = new SqlDataAdapter(komanda, conn);
            dt = new DataTable();
            da.Fill(dt);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //int shopId = int.Parse(dt.Rows[i]["ID"].ToString());
                string shopName = dt.Rows[i]["Naziv"].ToString();
                string shopAdress = dt.Rows[i]["Adresa"].ToString();
                string shopCity = dt.Rows[i]["Grad"].ToString();
                string shopDesc = dt.Rows[i]["Opis"].ToString();
                if (i == 0) shops += "<div id='slideShop' class='carousel text-light slide bg-dark' data-ride='carousel'>   <div class='carousel-inner'> <div class='carousel-item active'>  <h1>" + shopName + "</a></h1>   <p class='lead'>" + shopAdress + ", " + shopCity + "</p> <p class='lead'>" + shopDesc + "</p>    </div>";
                else shops += "<div class='carousel-item'>  <h1> " + shopName + " </h1> <p class='lead'>" + shopAdress + ", " + shopCity + "</p> <p class='lead'>" + shopDesc + "</p> </div>";
                //shops += "<div class='row featurette bg-light'>    <div class='col-sm-7 col-md-7 col-lg-7'>		<h2 class='featurette-heading'>" + shopName + "</h2>	<p>" + shopAdress + ", "+ shopCity + "</p>	<p>" + shopDesc + "</p> 	</div>   </div> <br/> <br/> <br/>";
                //if (i == 0) shops += "<div id='slideShop' class='carousel text-light slide bg-dark' data-ride='carousel'>   <div class='carousel-inner'> <div class='carousel-item active'>  <h1><a href='https://www.google.com/maps/dir//%D0%93%D0%BB%D0%B0%D0%B2%D0%BD%D0%B0+2,+%D0%91%D0%B5%D0%BE%D0%B3%D1%80%D0%B0%D0%B4/@44.8419974,20.411429,17z/data=!4m8!4m7!1m0!1m5!1m1!1s0x475a65a625844d8f:0x7598234d11686c29!2m2!1d20.4136177!2d44.8419974' target='_blank'> " + shopName + "</a></h1>   <p class='lead'>" + shopAdress + ", "+ shopCity + "</p> <p class='lead'>" + shopDesc + "</p>    </div>";
            }
            shops += "  </div>  <a class='carousel-control-prev' href='#slideShop' role='button' data-slide='prev'>    <span class='carousel-control-prev-icon' aria-hidden='true'></span> <span class='sr-only'>Prethodna</span>  </a>  <a class='carousel-control-next' href='#slideShop' role='button' data-slide='next'>    <span class='carousel-control-next-icon' aria-hidden='true'></span> <span class='sr-only'>Sledeća</span>    </a>    </div>";
            prodavnice.InnerHtml = shops;
        }

        [WebMethod]
        public static string posaljiMejl(string ime, string email, string poruka)
        {
            string name = ime;
            string eMail = email;
            string message = poruka;

            MailMessage msg = new MailMessage();
            SmtpClient klijent = new SmtpClient();

            try
            {
                msg.Subject = "Info Web Shop";
                msg.Body = "Ovo je poslato sa: " + eMail + "\n\nOvo je poruka: " + message;
                msg.From = new MailAddress(eMail);

                msg.To.Add("infowebshop9@gmail.com");
                klijent.Host = "smtp.gmail.com";
                System.Net.NetworkCredential basic = new System.Net.NetworkCredential("infowebshop9@gmail.com", "info123shop");
                klijent.EnableSsl = true;
                klijent.Port = 587;
                klijent.UseDefaultCredentials = false;
                klijent.Credentials = basic;
                klijent.DeliveryMethod = SmtpDeliveryMethod.Network;
                klijent.Send(msg);

                return "Poruka uspešno poslata.";
            }
            catch (Exception ex)
            {
                return "Došlo je do greške. Molimo da pokušate kasnije.("+ex+")";
            }
        }

    }
}




