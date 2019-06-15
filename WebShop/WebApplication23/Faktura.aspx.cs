using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication23
{
    public partial class Faktura : System.Web.UI.Page
    {
        private string komanda;
        private SqlDataAdapter da;
        private SqlConnection conn = konekcija.Connect();
        private DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["oznakaRacuna"] != null)
            {
                string racunBr = Session["oznakaRacuna"].ToString();

                if (racunBr != "")
                {
                    oznakaRacuna.InnerText = racunBr;

                    komanda = "EXECUTE showStavkeFakture @oznaka";
                    da = new SqlDataAdapter(komanda, conn);
                    da.SelectCommand.Parameters.AddWithValue("@oznaka", racunBr);
                    dt = new DataTable();
                    da.Fill(dt);
                    DateTime dateTime = Convert.ToDateTime(dt.Rows[0]["Datum"]);
                    string datum = dateTime.ToString("dd.MM.yyyy");

                    datumFakturisanja.InnerText += datum;

                    string napomena = dt.Rows[0]["Napomena"].ToString();
                    int shopId = int.Parse(dt.Rows[0]["ProdavnicaID"].ToString());
                    int userId = int.Parse(dt.Rows[0]["KorisnikID"].ToString());

                    int brStavki = dt.Rows.Count;
                    int sum = 0;

                    string stavke = "<table class='table table-condensed table-responsive table-striped'> <thead> <tr>  <th>R.br.</th>   <th id='artikal' colspan='12'>Artikal</th>   <th>Kom.</th>  <th colspan='2'>Cena po kom.</th>  <th colspan='5'>Ukupno</th> </tr> </thead> ";

                    for (int i = 0; i < brStavki; i++)
                    {
                        string nazivArtikla = dt.Rows[i]["Naziv"].ToString();
                        int kolicinaArtikla = int.Parse(dt.Rows[i]["Kolicina"].ToString());
                        int cenaArtikla = int.Parse(dt.Rows[i]["Iznos"].ToString()) / kolicinaArtikla;
                        int ukupno = int.Parse(dt.Rows[i]["Iznos"].ToString());

                        sum += ukupno;

                        if (i != brStavki - 1)
                            stavke += " <tbody>  <tr class='stavke'>  <td>" + (i + 1) + "</td>   <td  class='artikli' colspan='12'> " + nazivArtikla + " </td >   <td> " + kolicinaArtikla + "</td >  <td colspan='2'>" + cenaArtikla + "</td>  <td colspan = '5' > " + ukupno + " </td> </tr>   ";
                        else
                            stavke += "<tr id='krajStavki' class='stavke'>  <td>" + (i + 1) + "</td>   <td class='artikli' colspan='12'> " + nazivArtikla + " </td >   <td> " + kolicinaArtikla + "</td >  <td colspan='2'>" + cenaArtikla + "</td>  <td colspan = '5' > " + ukupno + " </td> </tr>   ";
                    }
                    stavke += " <tr id='pocetalObracuna'>    <td id='beli1' colspan='14'></td>	<td id='pdvLbl' colspan='2'>PDV 20%:</td>	<td colspan='3' id='pdv'>" + (sum * 0.2) + "</td>   </tr>   ";
                    stavke += " <tr>    <td colspan='14' class='beli'></td>	<td id='glavnicaLbl' colspan='2'>Glavnica:</td>	<td colspan='3' id='glavnica'>" + (sum * 0.8) + "</td>   </tr>   ";
                    stavke += " <tr>    <td colspan='14' class='beli'></td>	<td id='ukIznosLbl' colspan='2'>Ukupno za uplatu:</td>	<td colspan='3' id='ukIznos'>" + sum + "</td>   </tr>  </tbody> ";

                    stavke += " </table>";
                    tabelaFakture.InnerHtml = stavke;

                    da.SelectCommand.Parameters.Clear();
                    dt.Clear();

                    /*Podaci korisnika*/
                    da.SelectCommand.CommandText = "EXECUTE shwUser @userId";
                    da.SelectCommand.Parameters.AddWithValue("@userId", userId);
                    da.Fill(dt);

                    imeKupca.InnerText = dt.Rows[0]["Ime"].ToString();
                    prezimeKupca.InnerText = dt.Rows[0]["Prezime"].ToString();
                    adresaKupca.InnerText = dt.Rows[0]["Adresa"].ToString();
                    gradKupca.InnerText = dt.Rows[0]["Grad"].ToString();

                    da.SelectCommand.Parameters.Clear();
                    dt.Clear();

                    /*Podaci poslovnice*/
                    da.SelectCommand.CommandText = "EXECUTE getProdavnica @shopId";
                    da.SelectCommand.Parameters.AddWithValue("@shopId", shopId);
                    da.Fill(dt);

                    nazivPoslovnice.InnerText = dt.Rows[0]["Naziv"].ToString();
                    adresaPoslovnice.InnerText = dt.Rows[0]["Adresa"].ToString();
                    gradPoslovnice.InnerText = dt.Rows[0]["Grad"].ToString();

                    if (napomena != "STORNO") storno.Visible = false;
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }
}
