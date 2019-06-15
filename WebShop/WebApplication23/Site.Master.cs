using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication23
{
    public partial class SiteMaster : MasterPage
    {
        private string komanda;
        private SqlDataAdapter da;
        private SqlConnection conn = konekcija.Connect();
        private SqlCommand cmd;
        private DataTable dt;
        private SqlDataReader reader;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*Side bar*/
            #region Punjenje Sidebar-a sa kategorijama
            string kategorijeList = "";
            komanda = "EXECUTE listItems @tabela";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@tabela", "KatArt");
            dt = new DataTable();
            da.Fill(dt);
            int numKatArt = dt.Rows.Count;

            for (int i = 0; i < numKatArt; i++)
            {
                int katId = int.Parse(dt.Rows[i]["ID"].ToString());
                string kategorija = dt.Rows[i]["Naziv"].ToString();
                kategorijeList += "<button id = Cat'" + kategorija + "' Value='" + katId + "' type='button' runat='server' class='list-group-item list-group-item-action bg-light kategorije'>" + kategorija + "</button> ";
            }
            kategorijeList += "<button id = 'allCategories' Value='0' type='button' runat='server' class='list-group-item list-group-item-action bg-light kategorije'>Prikaži sve</button> ";

            sidebarKatArt.InnerHtml = kategorijeList;
            #endregion
            /*Grad za registraciju*/
            #region Punjenje Grad DropDown-a za registraciju
            dt.Clear();
            da.SelectCommand.CommandText = "EXECUTE getTable @colomn,@table";
            da.SelectCommand.Parameters.AddWithValue("@colomn", "Naziv");
            da.SelectCommand.Parameters.AddWithValue("@table", "Grad");
            da.Fill(dt);

            regUserCity.DataSource = dt;
            regUserCity.DataTextField = "Naziv";
            regUserCity.DataValueField = "ID";
            regUserCity.DataBind();
            #endregion
            /*Profil*/
            #region Punjenje Profila sa korisnickim podacima
            if (Session["userId"] != null)
            {
                int userId = int.Parse(Session["userID"].ToString());
                Korisnik posetilac = new Korisnik(userId);

                posetilac.LoadProfil();

                profilUserName.Value = posetilac.UserName;
                profilName.Value = posetilac.Ime;
                profilLastName.Value = posetilac.Prezime;
                profilAdresa.Value = posetilac.Adresa;
                profilGrad.Value = posetilac.Grad;
                profilTelefon.Value = posetilac.Tel;
                profilEmail.Value = posetilac.Email;

                userFak.DataSource = posetilac.ListaFaktura();
                userFak.DataTextField = "Racun";
                userFak.DataValueField = "Racun";
                userFak.DataBind();
            }
            #endregion
            /*Korpa*/
            #region Punjenje korisnicke korpe iz tmpKorpe
            if (Session["userId"] != null)
            {
                if (Session["userId"].ToString() != "")
                {
                    string tabela = "";
                    int sum = 0;
                    int j = 0;
                    int userId = int.Parse(Session["userId"].ToString());

                    komanda = "EXECUTE chckTmpKorpa @userId";
                    cmd = new SqlCommand(komanda, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);

                    conn.Open();
                    bool isExisting = int.Parse(cmd.ExecuteScalar().ToString()) > 0 ? true : false;
                    conn.Close();

                    if (isExisting)
                    {
                        komanda = "EXECUTE shwTmpKorpa @userId";
                        cmd = new SqlCommand(komanda, conn);
                        cmd.Parameters.AddWithValue("@userId", userId);
                        conn.Open();
                        reader = cmd.ExecuteReader();

                        if (reader.HasRows)
                        {
                            tabela = " <table class='tg'>  <tr>    <th class='tg-0lax'>Stavka</th> <th class='tg-0lax' colspan='5'>Artikal</th>    <th class='tg-0lax'>Količina</th>   <th class='tg-0lax' colspan='2'>Cena po komadu</th> <th class='tg-0lax' colspan='2'>Ukupno</th> <th class='tg-0lax'></th>   </tr>";

                            while (reader.Read())
                            {
                                string tmpKorpaStavka = reader["Stavka"].ToString();
                                string tmpKorpaArtikal = reader["Artikal"].ToString();
                                int tmpKorpaKolicina = int.Parse(reader["Kolicina"].ToString());
                                int tmpKorpaCenaPoKomadu = int.Parse(reader["Cena"].ToString());
                                int tmpKorpaArtikalId = int.Parse(reader["ArtikalId"].ToString());
                                int tmpKorpaUkupno = tmpKorpaKolicina * tmpKorpaCenaPoKomadu;
                                sum += tmpKorpaUkupno;
                                j++;

                                tabela += "   <tr>    <td class='tg-0lax'>" + tmpKorpaStavka + "</td> <td class='tg-0lax' colspan='5'>" + tmpKorpaArtikal + "</td>    <td class='tg-0lax'>" + tmpKorpaKolicina + "</td>   <td class='tg-0lax' colspan='2'>" + tmpKorpaCenaPoKomadu + "</td> <td class='tg-0lax' colspan='2'>" + tmpKorpaUkupno + "</td> <td class='tg-0lax'> <asp:Button ID='remStavku" + j + "' onclick='remStavku_Click' class='hl-btn btn-default' CustomParameter='" + tmpKorpaArtikalId + "' runat='server' Text='X' /></td>   </tr>   ";
                            }
                        }
                        tabela += " <tr>    <td class='tg-0lax' colspan='5'></td>	<td class='tg-0lax' colspan='4' style='text-decoration: underline;text-decoration-style: double;'><b>Ukupno za uplatu:</b></td>	<td class='tg-0lax' colspan='2' id='ukIznos' style='text-decoration: underline;text-decoration-style: double;'><b>" + sum + "</b></td>	<td class='tg-0lax'></td>	</tr>   ";
                        tabela += "  </table> <hr/>";
                        sadrzajKorpe.InnerHtml = tabela;

                        conn.Close();
                    }
                }
            }
            #endregion
        }


        /*▓▓ LOG IN, OUT, REGISTRACIJA ▓▓*/

        #region LogIn
        protected void logBtn_Click(object sender, EventArgs e)
        {
            string user = userNameLog.Value;
            string pass = inputPassword.Value;

            komanda = "EXECUTE getUser @userName,@pass";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@userName", user);
            cmd.Parameters.AddWithValue("@pass", pass);

            conn.Open();
            if (cmd.ExecuteReader().HasRows)
            {
                conn.Close();
                Korisnik posetilac = new Korisnik();
                posetilac.UserName = user;
                posetilac.Sifra = pass;
                posetilac.LogIn();

                Session["userID"] = posetilac.Id;
                Session["userName"] = posetilac.UserName;
                Session["userAuthentication"] = posetilac.Authentication;

                btnLogInMod.InnerHtml = posetilac.UserName;
                Response.Redirect("Default.aspx");

            }
            conn.Close();
        }

        #endregion

        #region LogOut
        public void LogOutBtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
        #endregion

        #region Registracija
        protected void btnRegChck_Click(object sender, EventArgs e)
        {
            string userName = regUserName.Text;
            string pass = regUserPass.Text;
            string firstName = regUserFirstName.Text;
            string lastName = regUserLastName.Text;
            string adress = regUserAdress.Text;
            string city = regUserCity.SelectedItem.Value;
            string phone = regUserPhone.Text;
            string email = regUserEmail.Text;
            string MB = regUserMatBr.Text;

            cmd = new SqlCommand("EXECUTE newUser @userName,@pass,@firstName,@lastName,@adress,@city,@phone,@email,@MB,@authentication='K'", conn);
            cmd.Parameters.AddWithValue("@userName", userName);
            cmd.Parameters.AddWithValue("@pass", pass);
            cmd.Parameters.AddWithValue("@firstName", firstName);
            cmd.Parameters.AddWithValue("@lastName", lastName);
            cmd.Parameters.AddWithValue("@adress", adress);
            cmd.Parameters.AddWithValue("@city", city);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@MB", MB);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion

        /*▓▓ KORPA ▓▓*/

        /*///Kupovina\\\*/

        #region Fakturisanje
        protected void btnShopCheck_Click(object sender, EventArgs e)
        {
            string napomena = txtNapomena.Text;
            int userId = int.Parse(Session["userID"].ToString());
            Korisnik kupac = new Korisnik(userId);

            kupac.Kupovina(napomena);

            /*Na kraju redirect na Default.aspx*/
            Response.Redirect("Default.aspx");
        }
        #endregion

        #region Brisanje stavki korpe
        protected void btnclearCheck_Click(object sender, EventArgs e)
        {
            int userId = int.Parse(Session["userId"].ToString());
            Korisnik posetilac = new Korisnik(userId);
            posetilac.ObrisiKorpu();
            Response.Redirect("Default.aspx");
        }
        #endregion

        /* ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓*/
        /* ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ VAN FUNKCIJE▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓*/

        #region "Obrisati stavku" iz tmpKorpe   *TRENUTNO VAN FUNKCIJE*
        protected void remStavku_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            int artikalId = int.Parse(btn.Attributes["CustomParameter"].ToString());
            int userId = int.Parse(Session["userId"].ToString());

            komanda = "EXECUTE rfshTmpKorpa @userId, @artikalId, @kolicina ";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@userId", userId);
            cmd.Parameters.AddWithValue("@artikalId", artikalId);
            cmd.Parameters.AddWithValue("@kolicina", 0);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        #endregion

        #region "Osvezi korpu" *TRENUTNO VAN FUNKCIJE*
        public void osveziKorpu_Click(int kolicina, int artikalId)
        {
            int userId = int.Parse(Session["userId"].ToString());
            komanda = "EXECUTE rfshTmpKorpa @userId, @artikalId, @kolicina";

            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@userId", userId);
            cmd.Parameters.AddWithValue("@artikalId", artikalId);
            cmd.Parameters.AddWithValue("@kolicina", kolicina);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        #endregion
    }
}


