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
    public partial class WebForm2 : System.Web.UI.Page
    {
        #region da,conn,cmd,dt,dr,komanda-e itd.
        string komanda;
        SqlDataAdapter da;
        SqlConnection conn = konekcija.Connect();
        SqlCommand cmd;
        DataTable dt;
        SqlDataReader dr;
        #endregion

        /*Load page*/
        #region Ucitavanje svih ListBox-ova i DropDown-ova pri Load-u stranice 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userAuthentication"] != null && Session["userAuthentication"].ToString() != "")
            {
                if (Session["userAuthentication"].ToString() == "A" || Session["userAuthentication"].ToString() == "Z")
                {
                    if (!IsPostBack) //da ne bi stalno "gazilo" stranicu
                    {
                        loadTable("KatArt");
                        loadTable("Grad");
                        loadTable("Dobavljac");
                        loadTable("Korisnik");
                        loadTable("Prodavnica");
                        loadTable("Artikal");
                        komanda = "EXECUTE showStanje";
                        da = new SqlDataAdapter(komanda, conn);
                        dt = new DataTable();
                        da.Fill(dt);
                        stGrid.DataSource = dt;
                        stGrid.DataBind();
                        DataTable dt2 = new DataTable();
                        komanda = "EXECUTE showFakture";
                        da = new SqlDataAdapter(komanda, conn);
                        da.Fill(dt2);
                        showFaktureList.DataSource = dt2;
                        showFaktureList.DataTextField = "Racun";
                        showFaktureList.DataValueField = "Racun";
                        showFaktureList.DataBind();
                        DataTable dt3 = new DataTable();
                        komanda = "EXECUTE shwLogStanja";
                        da = new SqlDataAdapter(komanda, conn);
                        da.Fill(dt3);
                        logStanjaGrid.DataSource = dt3;
                        logStanjaGrid.DataBind();
                    }
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
        #region Punjenje tabela
        public void loadTable(string table)
        {
            string colomn;
            switch (table)
            {
                case "Korisnik": colomn = "userName"; break;
                default: colomn = "Naziv"; break;
            }
            komanda = "EXECUTE getTable @colomn,@table";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@colomn", colomn);
            da.SelectCommand.Parameters.AddWithValue("@table", table);

            dt = new DataTable();

            da.Fill(dt);
            bindTable(table, dt, colomn);
        }
        #endregion
        #region Bind-ovanje tabela za ListBox-ove, DropDown-e, GridView-ove i dr.
        public void bindTable(string table, DataTable dt, string colomn = "Naziv")
        {
            switch (table)
            {
                case "Artikal":
                    ListBox4.DataSource = chgStanjeArt.DataSource = newStanjeArt.DataSource = dt;
                    ListBox4.DataTextField = chgStanjeArt.DataTextField = newStanjeArt.DataTextField = colomn;
                    ListBox4.DataValueField = chgStanjeArt.DataValueField = newStanjeArt.DataValueField = "ID";
                    ListBox4.DataBind();
                    chgStanjeArt.DataBind();
                    newStanjeArt.DataBind();
                    break;
                case "KatArt":
                    ListBox3.DataSource = newItemsCatArt.DataSource = updItemsCatArt.DataSource = dt;
                    ListBox3.DataTextField = newItemsCatArt.DataTextField = updItemsCatArt.DataTextField = colomn;
                    ListBox3.DataValueField = newItemsCatArt.DataValueField = updItemsCatArt.DataValueField = "ID";
                    ListBox3.DataBind();
                    newItemsCatArt.DataBind();
                    updItemsCatArt.DataBind();
                    break;
                case "Dobavljac":
                    ListBox1.DataSource = updItemsSupplier.DataSource = newItemsSupplier.DataSource = dt;
                    ListBox1.DataTextField = updItemsSupplier.DataTextField = newItemsSupplier.DataTextField = colomn;
                    ListBox1.DataValueField = updItemsSupplier.DataValueField = newItemsSupplier.DataValueField = "ID";
                    ListBox1.DataBind();
                    updItemsSupplier.DataBind();
                    newItemsSupplier.DataBind();
                    break;
                case "Korisnik":
                    ListBox5.DataSource = dt;
                    ListBox5.DataTextField = colomn;
                    ListBox5.DataValueField = "ID";
                    ListBox5.DataBind();
                    break;
                case "Prodavnica":
                    ListBox2.DataSource = chgStanjeShop.DataSource = newStanjeShop.DataSource = dt;
                    ListBox2.DataTextField = chgStanjeShop.DataTextField = newStanjeShop.DataTextField = colomn;
                    ListBox2.DataValueField = chgStanjeShop.DataValueField = newStanjeShop.DataValueField = "ID";
                    ListBox2.DataBind();
                    chgStanjeShop.DataBind();
                    newStanjeShop.DataBind();
                    break;
                case "Grad":
                    newSupplierCity.DataSource = updSupplierCity.DataSource = newShopCity.DataSource = updShopCity.DataSource = newUserCity.DataSource = updUserCity.DataSource = dt;
                    newSupplierCity.DataTextField = updSupplierCity.DataTextField = newShopCity.DataTextField = updShopCity.DataTextField = newUserCity.DataTextField = updUserCity.DataTextField = colomn;
                    newSupplierCity.DataValueField = updSupplierCity.DataValueField = newShopCity.DataValueField = updShopCity.DataValueField = newUserCity.DataValueField = updUserCity.DataValueField = "ID";
                    updUserCity.DataBind();
                    newUserCity.DataBind();
                    newShopCity.DataBind();
                    updShopCity.DataBind();
                    updSupplierCity.DataBind();
                    newSupplierCity.DataBind();
                    break;
            }
        }
        #endregion

        #endregion

        /*ListBox-ovi i ButtonGroup-e(INSERT, UPDATE, DELETE)*/
        #region ListBox-ovi i ButtonGroup-e

        /*▓▓▓▓▓--------------------INSERT--------------------▓▓▓▓▓*/
        #region INSERT-i za sve ListBox-ove

        #region Dobavljac - Insert
        protected void btnNewSupplierChck_Click(object sender, EventArgs e)
        {
            string newSuppName = newSupplierName.Text;
            string newSuppAdress = newSupplierAdress.Text;
            string newSuppCityId = newSupplierCity.SelectedItem.Value;
            string newSuppPIB = newSupplierPIB.Text;
            string newSuppMatBr = newSupplierMatBr.Text;

            cmd = new SqlCommand("EXECUTE newDobavljac @name,@adress,@cityId,@PIB,@MatBr", conn);
            cmd.Parameters.AddWithValue("@name", newSuppName);
            cmd.Parameters.AddWithValue("@adress", newSuppAdress);
            cmd.Parameters.AddWithValue("@cityId", newSuppCityId);
            cmd.Parameters.AddWithValue("@PIB", newSuppPIB);
            cmd.Parameters.AddWithValue("@MatBr", newSuppMatBr);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Prodavnica - Insert
        protected void btnNewShopChck_Click(object sender, EventArgs e)
        {
            string newShName = newShopName.Text;
            string newShAdress = newShopAdress.Text;
            string newShCity = newShopCity.SelectedItem.Value;
            string newShDesc = newShopDesc.Text;

            cmd = new SqlCommand("EXECUTE newShop @name,@adress,@city,@Desc", conn);
            cmd.Parameters.AddWithValue("@name", newShName);
            cmd.Parameters.AddWithValue("@adress", newShAdress);
            cmd.Parameters.AddWithValue("@city", newShCity);
            cmd.Parameters.AddWithValue("@Desc", newShDesc);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Korisnik - Insert
        protected void btnNewUserChck_Click(object sender, EventArgs e)
        {
            string userName = newUserName.Text;
            string pass = newUserPass.Text;
            string firstName = newUserFirstName.Text;
            string lastName = newUserLastName.Text;
            string adress = newUserAdress.Text;
            string city = newUserCity.SelectedItem.Value;
            string phone = newUserPhone.Text;
            string email = newUserEmail.Text;
            string MB = newUserMatBr.Text;
            string authentication;
            if (Session["userAuthentication"].ToString() == "A")
            {
                authentication = newUser2Auth1.SelectedItem.ToString();
            }
            else
            {
                authentication = newUser2Auth2.SelectedItem.ToString();
            }

            //  EXECUTE newUser '','',N'',N'',N'',1,'','','' za registraciju korisnika
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
            cmd.Parameters.AddWithValue("@authentication", authentication);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region KatArt - Insert
        protected void btnNewCatArtChck_Click(object sender, EventArgs e)
        {
            string newCatArt = newCatArt2Name.Text;

            cmd = new SqlCommand("EXECUTE newCatArt @name", conn);
            cmd.Parameters.AddWithValue("@name", newCatArt);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Art - Insert
        protected void btnNewItemsChck_Click(object sender, EventArgs e)
        {
            /*Prikupljanje podataka novog artikla*/
            string name = newItemsName.Text;
            string catArtId = newItemsCatArt.SelectedItem.Value;
            string desc = newItemsDesc.Text;
            string supplierId = newItemsSupplier.SelectedItem.Value;
            int price = int.Parse(newItemsPrice.Text);
            /*Insertovanje novog artikla*/
            cmd = new SqlCommand("EXECUTE newArt @name, @catArtId, @desc, @supplierId, @price", conn);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@catArtId", catArtId);
            cmd.Parameters.AddWithValue("@desc", desc);
            cmd.Parameters.AddWithValue("@supplierId", supplierId);
            cmd.Parameters.AddWithValue("@price", price);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            cmd.Parameters.Clear();

            /*Uzimanje ID-a novog artikla*/
            cmd.CommandText = "EXECUTE getLastArt";
            conn.Open();
            int newItemId = int.Parse(cmd.ExecuteScalar().ToString());
            conn.Close();

            /*Pravljenje putanje*/
            int kategorija = int.Parse(newItemsCatArt.SelectedItem.Value);

            string pathItem = (Server.MapPath("~") + "\\Images\\Kategorija\\" + kategorija + "\\" + newItemId + "");

            /*Kreiranje Foldera*/
            DirectoryInfo di = Directory.CreateDirectory(pathItem);

            //SELEKTOVANJE SLIKA - za INSERT NIJE NUZAN PA JE STOGA PRAZAN CATCH(Moze se dodati i kasnije pomocu UPDATE-a)
            try
            {
                HttpFileCollection slikeUpload = Request.Files;

                for (int i = 0; i < slikeUpload.Count-1; i++)
                {
                    HttpPostedFile userPostedFile = slikeUpload[i];

                    /*Dodavanje slika*/
                    int brojSlika = Directory.GetFiles(pathItem + "\\", "*.png").Length;
                    string naziv = (brojSlika + 1).ToString();

                    string fileExt = System.IO.Path.GetExtension(fileUploadNew.FileName).ToString().ToLower();
                    userPostedFile.SaveAs(pathItem + @"\" + naziv + fileExt);
                }
                Response.Redirect("Podesavanja.aspx");
            }
            catch (Exception)
            {
            }
        }
        #endregion

        #endregion

        /*▓▓▓▓▓--------------------UPDATE--------------------▓▓▓▓▓*/ //Proveravano u JS + TRY-CATCH-ovano ovde
        #region UPDATE-i za sve ListBox-ove

        #region Dobavljac - Update
        protected void btnUpdSupplierChck_Click(object sender, EventArgs e)
        {
            try
            {
                int supplierId = int.Parse(ListBox1.SelectedValue);

                string updSuppName = updSupplierName.Text;
                string updSuppAdress = updSupplierAdress.Text;
                string updSuppCityId = updSupplierCity.SelectedItem.Value;
                string updSuppPIB = updSupplierPIB.Text;
                string updSuppMatBr = updSupplierMatBr.Text;

                cmd = new SqlCommand("EXECUTE updDobavljac @supplierId,@name,@adress,@cityId,@PIB,@MatBr", conn);
                cmd.Parameters.AddWithValue("@supplierId", supplierId);
                cmd.Parameters.AddWithValue("@name", updSuppName);
                cmd.Parameters.AddWithValue("@adress", updSuppAdress);
                cmd.Parameters.AddWithValue("@cityId", updSuppCityId);
                cmd.Parameters.AddWithValue("@PIB", updSuppPIB);
                cmd.Parameters.AddWithValue("@MatBr", updSuppMatBr);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("Podesavanja.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "neispravan();", true);
            }
        }
        #endregion
        #region Prodavnica - Update
        protected void btnUpdShopChck_Click(object sender, EventArgs e)
        {
            try
            {
                int shopId = int.Parse(ListBox2.SelectedValue);

                string updShName = updShopName.Text;
                string updShAdress = updShopAdress.Text;
                string updShCity = updShopCity.SelectedItem.Value;
                string updShDesc = updShopDesc.Text;

                cmd = new SqlCommand("EXECUTE updShop @shopId,@name,@adress,@city,@Desc", conn);
                cmd.Parameters.AddWithValue("@shopId", shopId);
                cmd.Parameters.AddWithValue("@name", updShName);
                cmd.Parameters.AddWithValue("@adress", updShAdress);
                cmd.Parameters.AddWithValue("@city", updShCity);
                cmd.Parameters.AddWithValue("@Desc", updShDesc);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("Podesavanja.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "neispravan();", true);
            }
        }
        #endregion
        #region Korisnik - Update
        protected void btnUpdUserChck_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = int.Parse(ListBox5.SelectedValue);

                Korisnik posetilac = new Korisnik();

                posetilac.Id = userId;
                posetilac.UserName = hidUserName.Value.ToString();
                posetilac.Sifra = hidUserPass.Value.ToString();
                posetilac.Ime = updUserFirstName.Text;
                posetilac.Prezime = updUserLastName.Text;
                posetilac.Adresa = updUserAdress.Text;
                posetilac.GradId = int.Parse(updUserCity.SelectedItem.Value);
                posetilac.Tel = updUserPhone.Text;
                posetilac.Email = updUserEmail.Text;
                posetilac.Mb = updUserMatBr.Text;
                if (int.Parse(updUser2Auth1.SelectedValue) > 0) posetilac.Authentication = updUser2Auth1.SelectedItem.ToString();
                else posetilac.Authentication = updUser2Auth2.SelectedItem.ToString();

                posetilac.UpdKorisnika();

                Response.Redirect("Podesavanja.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "neispravan();", true);
            }
        }
        #endregion
        #region KatArt - Update
        protected void btnUpdCatArtChck_Click(object sender, EventArgs e)
        {
            try
            {
                int catArtId = int.Parse(ListBox3.SelectedValue);

                string updCatArt = updCatArtName.Text;

                cmd = new SqlCommand("EXECUTE updCatArt @catArtId,@name", conn);
                cmd.Parameters.AddWithValue("@catArtId", catArtId);
                cmd.Parameters.AddWithValue("@name", updCatArt);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("Podesavanja.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "neispravan();", true);
            }
        }
        #endregion
        #region Art - Update
        protected void btnUpdItemsChck_Click(object sender, EventArgs e)
        {
            try
            {
                int artId = int.Parse(ListBox4.SelectedValue);
                string name = updItemsName.Text;
                int catArtId = int.Parse(updItemsCatArt.SelectedItem.Value);
                string desc = updItemsDesc.Text;
                int supplierId = int.Parse(updItemsSupplier.SelectedItem.Value);
                int price = int.Parse(updItemsPrice.Text);

                if (name == "" || catArtId < 0 || desc == "" || supplierId < 0 || price < 0) throw new System.ArgumentException("Nepotpuni podaci ili namerna greška");

                cmd = new SqlCommand("EXECUTE updArt @artId,@name, @catArtId, @desc, @supplierId, @price", conn);
                cmd.Parameters.AddWithValue("@artId", artId);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@catArtId", catArtId);
                cmd.Parameters.AddWithValue("@desc", desc);
                cmd.Parameters.AddWithValue("@supplierId", supplierId);
                cmd.Parameters.AddWithValue("@price", price);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                cmd.Parameters.Clear();

                /*Uzimanje rednog broja artikla u kategoriji*/
                cmd.CommandText = "EXECUTE getItemPicPath @itemId";
                cmd.Parameters.AddWithValue("@itemId", artId);

                conn.Open();
                int redni = int.Parse(cmd.ExecuteScalar().ToString());
                conn.Close();

                /*Pravljenje putanje*/
                string kategorija = newItemsCatArt.SelectedItem.Text;

                string pathItem = (Server.MapPath("~") + "\\Images\\Kategorija\\" + kategorija + "\\" + redni + "");

                //SELEKTOVANJE SLIKA - za UPDATE NIJE NUZAN PA JE STOGA PRAZAN CATCH
                try
                {
                    HttpFileCollection slikeUpload = Request.Files;

                    for (int i = 0; i < slikeUpload.Count; i++)
                    {
                        HttpPostedFile userPostedFile = slikeUpload[i];

                        /*Dodavanje slika*/
                        int brojSlika = Directory.GetFiles(pathItem + "\\", "*.png").Length;
                        string naziv = (brojSlika + 1).ToString();

                        string fileExt = System.IO.Path.GetExtension(fileUploadUpd.FileName).ToString().ToLower();
                        userPostedFile.SaveAs(pathItem + @"\" + naziv + fileExt);
                    }
                }
                catch (Exception)
                {
                }

                Response.Redirect("Podesavanja.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "neispravan();", true);
            }
        }
        #endregion

        #endregion

        /*▓▓▓▓▓--------------------DELETE--------------------▓▓▓▓▓*/ //Proveravano u JS
        #region DELETE-i za sve ListBox-ove

        #region Dobavljac - Delete
        protected void btnDelSupplierChck_Click(object sender, EventArgs e)
        {
            int supplierId = int.Parse(ListBox1.SelectedValue);

            cmd = new SqlCommand("EXECUTE delDobavljac @supplierId", conn);
            cmd.Parameters.AddWithValue("@supplierId", supplierId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Prodavnica - Delete
        protected void btnDelShopChck_Click(object sender, EventArgs e)
        {
            int shopId = int.Parse(ListBox2.SelectedValue);

            cmd = new SqlCommand("EXECUTE delShop @shopId", conn);
            cmd.Parameters.AddWithValue("@shopId", shopId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Korisnik - Delete
        protected void btnDelUserChck_Click(object sender, EventArgs e)
        {
            int userId = int.Parse(ListBox5.SelectedValue);

            cmd = new SqlCommand("EXECUTE delUser @userId", conn);
            cmd.Parameters.AddWithValue("@userId", userId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region KatArt - Delete
        protected void btnDelKatArtChck_Click(object sender, EventArgs e)
        {
            int catArtId = int.Parse(ListBox3.SelectedValue);
            string kategorija = ListBox3.SelectedItem.ToString();

            cmd = new SqlCommand("EXECUTE delCatArt @catArtId", conn);
            cmd.Parameters.AddWithValue("@catArtId", catArtId);

            conn.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            conn.Close();
            
            /*Pravljenje putanje*/
            string putanja = (Server.MapPath("~") + "\\Images\\Kategorija\\" + kategorija + "");

            if (rowsAffected > 0)
            {
                Directory.Delete(putanja);
            }

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Art - Delete
        protected void btnDelArtChck_Click(object sender, EventArgs e)
        {
            int ItemId = int.Parse(ListBox4.SelectedValue);

            string komanda = "EXECUTE getItem @itemId";
            da = new SqlDataAdapter(komanda, conn);
            dt = new DataTable();
            da.SelectCommand.Parameters.AddWithValue("@itemId", ItemId);
            da.Fill(dt);
            
            string kategorija = dt.Rows[0]["Kategorija"].ToString();

            /*Pravljenje putanje*/

            string putanja = (Server.MapPath("~") + "\\Images\\Kategorija\\" + kategorija + "\\" + ItemId + "");
            
            cmd = new SqlCommand("EXECUTE delArt @artId", conn);
            cmd.Parameters.AddWithValue("@artId", ItemId);

            conn.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            conn.Close();

            if (rowsAffected > 0)
            {
                string[] fajlovi = Directory.GetFiles(putanja, "*", SearchOption.AllDirectories);
                foreach (string fajl in fajlovi)
                {
                    File.Delete(fajl);
                }
                Directory.Delete(putanja);
            }

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion

        #endregion

        #endregion

        /*Fakture*/
        #region Fakture

        /*Storniranje faktura*/
        #region Storniranje faktura
        protected void btnStornChck_Click(object sender, EventArgs e)
        {
            /*UPDATE Fakture SET Napomena = 'STORNO' */
            string oznaka = showFaktureList.SelectedItem.ToString();
            string komanda = "EXECUTE stornFakture @oznaka";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@oznaka", oznaka);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            /*Preuzimanje stavki fakture*/
            komanda = "EXECUTE showStavkeFakture @oznaka";
            da = new SqlDataAdapter(komanda, conn);
            da.SelectCommand.Parameters.AddWithValue("@oznaka", oznaka);
            dt = new DataTable();
            da.Fill(dt);
            int brStavki = dt.Rows.Count;
            int userId = int.Parse(dt.Rows[0]["KorisnikID"].ToString());
            int kolicina = 0;
            int itemId = 0;
            int shopId = 0;

            /*Povraćaj robe na stanje*/
            komanda = "EXECUTE izmStanja @kolicina,@itemID, @shopID";
            cmd = new SqlCommand(komanda, conn);

            for (int i = 0; i < brStavki; i++)
            {
                kolicina = int.Parse(dt.Rows[i]["Kolicina"].ToString()) * (-1);
                itemId = int.Parse(dt.Rows[i]["ArtikalId"].ToString());
                shopId = int.Parse(dt.Rows[i]["ProdavnicaId"].ToString());
                cmd.Parameters.AddWithValue("@kolicina", kolicina);
                cmd.Parameters.AddWithValue("@itemID", itemId);
                cmd.Parameters.AddWithValue("@shopID", shopId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                cmd.Parameters.Clear();
            }
            /*Evidentiranje u LogStanja*/
            cmd.CommandText = "EXECUTE logStanjaStorn @racun";
            cmd.Parameters.AddWithValue("@racun", oznaka);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion

        #endregion

        /*Stanje*/
        #region Stanje - dodavanja i izmena

        #region Dodavanje nove kolicine artikla na stanje - dodavanje (UPDATE SET oldValue+newValue)
        protected void btnDodajStanjeChck_Click(object sender, EventArgs e)
        {
            int prodavnicaId = int.Parse(newStanjeShop.SelectedValue.ToString());
            int artikalId = int.Parse(newStanjeArt.SelectedValue.ToString());
            int kolicina = int.Parse(newStanjeQty.Value.ToString()) * (-1);                  //kolicina pre slanja mora biti pomnozena sa -1 jer se u proceduri oduzima "(stanje - kolicina)"
            komanda = "EXECUTE izmStanja @kolicina,@itemID, @shop";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@kolicina", kolicina);
            cmd.Parameters.AddWithValue("@itemID", artikalId);
            cmd.Parameters.AddWithValue("@shop", prodavnicaId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            cmd.Parameters.Clear();

            int userId = int.Parse(Session["userId"].ToString());
            cmd.CommandText = "EXECUTE logStanjaDodavanje @korisnikId, @artikalId, @shopId";
            cmd.Parameters.AddWithValue("@korisnikId", userId);
            cmd.Parameters.AddWithValue("@artikalId", artikalId);
            cmd.Parameters.AddWithValue("@shopId", prodavnicaId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion
        #region Postavljanje novog stanja - izmena (UPDATE SET value)
        protected void btnIzmeniStanjeChck_Click(object sender, EventArgs e)
        {
            int prodavnicaId = int.Parse(chgStanjeShop.SelectedValue.ToString());
            int artikalId = int.Parse(chgStanjeArt.SelectedValue.ToString());
            int kolicina = int.Parse(chgStanjeQty.Value.ToString());
            komanda = "EXECUTE updStanja @kolicina,@itemID, @shopID";
            cmd = new SqlCommand(komanda, conn);
            cmd.Parameters.AddWithValue("@kolicina", kolicina);
            cmd.Parameters.AddWithValue("@itemID", artikalId);
            cmd.Parameters.AddWithValue("@shopID", prodavnicaId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            int userId = int.Parse(Session["userId"].ToString());
            cmd.CommandText = "EXECUTE logStanjaIzmena @korisnikId, @artikalId, @shopId, @kolicina";
            cmd.Parameters.AddWithValue("@korisnikId", userId);
            cmd.Parameters.AddWithValue("@artikalId", artikalId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Podesavanja.aspx");
        }
        #endregion

        #endregion

        /*WebMethod-e*/
        #region WebMethod-e za UPDATE

        #region Dobavljac
        [WebMethod]
        public static string updSupplier(string ID)
        {
            Dobavljac supplier = new Dobavljac();
            DataTable dt = supplier.GetSupplier(int.Parse(ID));

            supplier.Naziv = dt.Rows[0]["Naziv"].ToString();
            supplier.Adresa = dt.Rows[0]["Adresa"].ToString();
            supplier.Grad = dt.Rows[0]["Grad"].ToString();
            supplier.Pib = dt.Rows[0]["PIB"].ToString();
            supplier.MatBr = dt.Rows[0]["MatBr"].ToString();
            supplier.GradId = int.Parse(dt.Rows[0]["GradId"].ToString());

            string json = JsonConvert.SerializeObject(supplier);

            return json;
        }
        #endregion
        #region Prodavnica
        [WebMethod]
        public static string updShop(string ID)
        {
            Classes.Prodavnica shop = new Classes.Prodavnica();
            DataTable dt = shop.GetShop(int.Parse(ID));

            shop.Naziv = dt.Rows[0]["Naziv"].ToString();
            shop.Adresa = dt.Rows[0]["Adresa"].ToString();
            shop.GradId = int.Parse(dt.Rows[0]["GradID"].ToString());
            shop.Opis = dt.Rows[0]["Opis"].ToString();

            string json = JsonConvert.SerializeObject(shop);

            return json;
        }
        #endregion
        #region Korisnik
        [WebMethod]
        public static string updUser(string ID)
        {
            Korisnik posetilac = new Korisnik();
            DataTable dt = posetilac.GetUser(int.Parse(ID));

            posetilac.UserName = dt.Rows[0]["userName"].ToString();
            posetilac.Sifra = dt.Rows[0]["pass"].ToString();
            posetilac.Ime = dt.Rows[0]["Ime"].ToString();
            posetilac.Prezime = dt.Rows[0]["Prezime"].ToString();
            posetilac.Adresa = dt.Rows[0]["Adresa"].ToString();
            posetilac.GradId = int.Parse(dt.Rows[0]["GradID"].ToString());
            posetilac.Email = dt.Rows[0]["Email"].ToString();
            posetilac.Tel = dt.Rows[0]["Telefon"].ToString();
            posetilac.Mb = dt.Rows[0]["MatBr"].ToString();
            posetilac.Auth = int.Parse(dt.Rows[0]["Auth"].ToString());

            string json = JsonConvert.SerializeObject(posetilac);

            return json;
        }
        #endregion
        #region Kategorija Artikla
        [WebMethod]
        public static string updCatArt(string katId)
        {
            Classes.KatArt katArt1 = new Classes.KatArt();
            DataTable dt = katArt1.GetKatArt(int.Parse(katId));

            katArt1.Naziv = dt.Rows[0]["Naziv"].ToString();

            string json = JsonConvert.SerializeObject(katArt1);

            return json;
        }
        #endregion
        #region Artikal
        [WebMethod]
        public static string updArt(string artId)
        {
            Artikal art = new Artikal();
            DataTable dt = art.GetArt(int.Parse(artId));

            art.Naziv = dt.Rows[0]["Naziv"].ToString();
            art.KatArtId = int.Parse(dt.Rows[0]["KatArtID"].ToString());
            art.Opis = dt.Rows[0]["Opis"].ToString();
            art.DobavljacId = int.Parse(dt.Rows[0]["DobavljacID"].ToString());
            art.Cena = int.Parse(dt.Rows[0]["Cena"].ToString());

            string json = JsonConvert.SerializeObject(art);

            return json;
        }
        #endregion

        #endregion

    }
}