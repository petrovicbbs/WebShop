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
    public class Korisnik
    {
        private string komanda, komanda2;
        private SqlDataAdapter da;
        private DataTable dt, dt2;
        private SqlConnection conn = konekcija.Connect();
        private SqlCommand cmd, cmd2;

        private int id;
        private string userName;
        private string sifra;
        private string ime;
        private string prezime;
        private string adresa;
        private string grad;
        private string email;
        private string tel;
        private string mb;
        private string authentication;
        private int gradId;
        private int auth;

        public int Id { get => id; set => id = value; }
        public string UserName { get => userName; set => userName = value; }
        public string Sifra { get => sifra; set => sifra = value; }
        public string Ime { get => ime; set => ime = value; }
        public string Prezime { get => prezime; set => prezime = value; }
        public string Adresa { get => adresa; set => adresa = value; }
        public string Grad { get => grad; set => grad = value; }
        public int GradId { get => gradId; set => gradId = value; }
        public string Email { get => email; set => email = value; }
        public string Tel { get => tel; set => tel = value; }
        public string Mb { get => mb; set => mb = value; }
        public string Authentication { get => authentication; set => authentication = value; }
        public int Auth { get => auth; set => auth = value; }

        public Korisnik(int id)
        {
            Id = id;
        }

        public Korisnik()
        {
        }

        #region LogIn
        public void LogIn()
        {
            komanda = "EXECUTE getUser @userName,@pass";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@userName", UserName);
            da.SelectCommand.Parameters.AddWithValue("@pass", Sifra);
            dt = new DataTable();
            da.Fill(dt);
            Id = int.Parse(dt.Rows[0]["ID"].ToString());
            UserName = dt.Rows[0]["userName"].ToString();
            Authentication = dt.Rows[0]["Autentifikacija"].ToString();
        }
        #endregion
        #region LoadProfil
        public void LoadProfil()
        {
            dt = new DataTable();
            komanda = "EXECUTE shwUser @userId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@userId", Id);
            da.Fill(dt);

            UserName = dt.Rows[0]["userName"].ToString();
            Ime = dt.Rows[0]["Ime"].ToString();
            Prezime = dt.Rows[0]["Prezime"].ToString();
            Adresa = dt.Rows[0]["Adresa"].ToString();
            Grad = dt.Rows[0]["Grad"].ToString();
            Tel = dt.Rows[0]["Telefon"].ToString();
            Email = dt.Rows[0]["Email"].ToString();
            Auth = int.Parse(dt.Rows[0]["Auth"].ToString());
        }
        #endregion
        #region ListaFaktura
        public DataTable ListaFaktura()
        {
            komanda = "EXECUTE userFakture @userId";
            dt = new DataTable();
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@userId", Id);
            da.Fill(dt);

            return dt;
        }
        #endregion
        #region Kupovina    
        public void Kupovina(string napomena)
        {
            int naStanju;

            /*Sledeci racun*/
            komanda = "EXECUTE getNextFakt";
            cmd = new SqlCommand(komanda, conn);
            conn.Open();
            int slFakt = int.Parse(cmd.ExecuteScalar().ToString());
            conn.Close();

            /*puni dt sa tmpKorpom*/
            komanda = "EXECUTE shwTmpKorpa @userId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@userId", Id);
            dt = new DataTable();
            da.Fill(dt);

            int rows = dt.Rows.Count;
            int itemId = 0;
            int askedQty = 0;

            for (int i = 0; i < rows; i++)
            {   /*Trazena kolicina i ArtikalId iz tmpKorpe*/
                askedQty = int.Parse(dt.Rows[i]["Kolicina"].ToString());
                itemId = int.Parse(dt.Rows[i]["ArtikalID"].ToString());

                /*Uzimanje proizvoda/svezeg stanja iz baze*/
                komanda = "EXECUTE getItem @itemId";
                da = new SqlDataAdapter(komanda, conn);
                da.SelectCommand.Parameters.AddWithValue("@itemId", itemId);

                dt2 = new DataTable();
                da.Fill(dt2);

                /*Dodela aktuelnog stanja iz baze*/
                naStanju = int.Parse(dt2.Rows[0]["Stanje"].ToString());

                /*Ispitivanje da li je trazena kolicina veca od kolicine sa stanja*/
                if (askedQty > naStanju)
                {
                    cmd.Parameters.Clear();

                    /*Ako jeste, nuluj kolicinu a rfshTmpKorpa ce automatski izbaciti nulovane redove*/
                    komanda = "EXECUTE rfshTmpKorpa @userId, @artikalId, @kolicina";
                    cmd.CommandText = komanda;
                    cmd.Parameters.AddWithValue("@userId", Id);
                    cmd.Parameters.AddWithValue("@artikalId", itemId);
                    cmd.Parameters.AddWithValue("@kolicina", 0);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            dt.Clear();

            /*Provera da li i nakon filtriranja postoji tabela tmpKorpa*/
            komanda = "EXECUTE chckTmpKorpa @userId";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@userId", Id);

            conn.Open();
            bool isExisting = int.Parse(cmd.ExecuteScalar().ToString()) > 0 ? true : false;
            conn.Close();

            /*Ako jos postoji*/
            if (isExisting)
            {
                /*Preuzmi njen novi sadrzaj*/
                komanda = "EXECUTE shwTmpKorpa @userId";
                da = new SqlDataAdapter(komanda, conn);
                da.SelectCommand.Parameters.AddWithValue("@userId", Id);
                dt = new DataTable();
                da.Fill(dt);

                /*Prebrojmo redove*/
                rows = dt.Rows.Count;

                /*Profiltrirana korpa zatim ide na Fakturisanje gde se svaka stavka iz korpe fakturise/evidentira*/
                komanda = "EXECUTE Fakturisanje @slFakt, @userId, @itemId, @qty, @Napomena";
                cmd = new SqlCommand(komanda, conn);

                /*----*/
                komanda2 = "EXECUTE logStanjaFakt";
                /*----*/
                cmd2 = new SqlCommand(komanda2, conn);

                for (int i = 0; i < rows; i++)
                {
                    cmd.Parameters.Clear();

                    int artikalId = int.Parse(dt.Rows[i]["ArtikalID"].ToString());
                    int kolicina = int.Parse(dt.Rows[i]["Kolicina"].ToString());
                    cmd.Parameters.AddWithValue("@slFakt", slFakt);
                    cmd.Parameters.AddWithValue("@userId", Id);
                    cmd.Parameters.AddWithValue("@itemId", artikalId);
                    cmd.Parameters.AddWithValue("@qty", kolicina);
                    cmd.Parameters.AddWithValue("@Napomena", napomena);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    /*----*/
                    cmd2.ExecuteNonQuery();
                    conn.Close();
                }
                /*Nakon Fakturisanja svih stavki brise se tmpKorpa korisnika*/
                cmd.CommandText = "EXECUTE delTmpKorpa @userId";

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        #endregion
        #region ObrisiKorpu
        public void ObrisiKorpu()
        {
            komanda = "EXECUTE delTmpKorpa @userId";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@userId", Id);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        #endregion
        public void UpdKorisnika()
        {
            string kom = "EXECUTE updUser @userId, @userName, @pass, @firstName, @lastName, @adress, @city, @phone, @email, @MB,@authentication";
            cmd = new SqlCommand(kom, conn);
            cmd.Parameters.AddWithValue("@userId", Id);
            cmd.Parameters.AddWithValue("@userName", UserName);
            cmd.Parameters.AddWithValue("@pass", Sifra);
            cmd.Parameters.AddWithValue("@firstName", Ime);
            cmd.Parameters.AddWithValue("@lastName", Prezime);
            cmd.Parameters.AddWithValue("@adress", Adresa);
            cmd.Parameters.AddWithValue("@city", GradId);
            cmd.Parameters.AddWithValue("@phone", Tel);
            cmd.Parameters.AddWithValue("@email", Email);
            cmd.Parameters.AddWithValue("@MB", Mb);
            cmd.Parameters.AddWithValue("@authentication", Authentication[0]);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public DataTable GetUser(int Id)
        {
            komanda = "EXECUTE shwUser @userId";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@userId", Id);
            dt = new DataTable();
            da.Fill(dt);

            return dt;
        }
    }
}