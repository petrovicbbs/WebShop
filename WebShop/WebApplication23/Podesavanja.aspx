<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Podesavanja.aspx.cs" Inherits="WebApplication23.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<h1>Dobrodošli u podešavanja</h1>
	<div class="row text-center">
		<div class="col-4">
			<label class="naslov">Dobavljači</label>
			<br />
			<asp:ListBox class="listBox" ID="ListBox1" runat="server"></asp:ListBox>
			<br />
			<div class="btn-group"> 

				<!--▓▓▓▓▓▓▓▓ Btn newSupplier1 -> Modal newSupplier2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Ubacivanje" id="newSupplier1" data-toggle="modal" data-target="#newSupplier2">+</button>

				<!--▓▓▓▓▓▓▓▓ Btn updSupplier1 -> Modal updSupplier2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Izmeni" id="updSupplier1">&#x21bb;</button>

				<!--▓▓▓▓▓▓▓▓ Btn delSupplier1 -> Modal delSupplier2Chck ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Brisanje" id="delSupplier1">-</button>
			</div>
		</div>
		<div class="col-4">
			<label class="naslov">Prodavnice</label>
			<br />
			<asp:ListBox class="listBox" ID="ListBox2" runat="server"></asp:ListBox>
			<br />
			<div class="btn-group">

				<!--▓▓▓▓▓▓▓▓ Btn newShop1 -> Modal newShop2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Ubacivanje" id="newShop1" data-toggle="modal" data-target="#newShop2">+</button>

				<!--▓▓▓▓▓▓▓▓ Btn updShop1 -> Modal updShop2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Izmeni" id="updShop1">&#x21bb;</button>

				<!--▓▓▓▓▓▓▓▓ Btn delShop1 -> Modal delShop2Chck ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Brisanje" id="delShop1">-</button>
			</div>
		</div>
		<div class="col-4">
			<label class="naslov">Korisnici</label>
			<br />
			<asp:ListBox class="listBox" ID="ListBox5" runat="server"></asp:ListBox>
			<br />
			<div class="btn-group text-center">

				<!--▓▓▓▓▓▓▓▓ Btn newUser1 -> Modal newUser2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Ubacivanje" id="newUser1" data-toggle="modal" data-target="#newUser2">+</button>

				<!--▓▓▓▓▓▓▓▓ Btn updUser1 -> Modal updUser2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Izmeni" id="updUser1">&#x21bb;</button>

				<!--▓▓▓▓▓▓▓▓ Btn delUser1 -> Modal delUser2Chck ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Brisanje" id="delUser1">-</button>
			</div>
		</div>
	</div>
	<br />
	<br />
	<div class="row text-center">
		<div class="col-4">
			<label class="naslov">Kategorije artikla</label>
			<br />
			<asp:ListBox class="listBox" ID="ListBox3" runat="server"></asp:ListBox>
			<br />
			<div class="btn-group">

				<!--▓▓▓▓▓▓▓▓ Btn newCatArt1 -> Modal newCatArt2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Ubacivanje" id="newCatArt1" data-toggle="modal" data-target="#newCatArt2">+</button>

				<!--▓▓▓▓▓▓▓▓ Btn updCatArt1 -> Modal updCatArt2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Izmeni" id="updCatArt1">&#x21bb;</button>

				<!--▓▓▓▓▓▓▓▓ Btn delCatArt1 -> Modal delCatArt2Chck ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Brisanje" id="delCatArt1">-</button>
			</div>
		</div>
		<div class="col-8">
			<label class="naslov">Artikli</label>
			<br />
			<asp:ListBox class="listBox" ID="ListBox4" runat="server"></asp:ListBox>
			<br />
			<div class="btn-group">

				<!--▓▓▓▓▓▓▓▓ Btn newArt1 -> Modal newArt2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Ubacivanje" id="newArt1" data-toggle="modal" data-target="#newItems2">+</button>

				<!--▓▓▓▓▓▓▓▓ Btn updArt1 -> Modal updArt2 ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Izmeni" id="updArt1">&#x21bb;</button>

				<!--▓▓▓▓▓▓▓▓ Btn delArt1 -> Modal delArt2Chck ▓▓▓▓▓▓▓▓-->
				<button type="button" class="btn btn-secondary" name="Brisanje" id="delArt1">-</button>
			</div>
		</div>
	</div>
	<br />
	<div class="row text-center">
		<div class="col-4">

			<!--OnClick="btnStanje_Click"-->
			<asp:Button class="btn btn-secondary" Text="Stanje" ID="btnStanje" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#showStanje" />
		</div>
		<div class="col-4">
			<!--OnClick="btnFakture_Click"-->
			<asp:Button class="btn btn-secondary" Text="Fakture" ID="btnFakture" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#showFakture" />
		</div>
		<div class="col-4">
			<!--OnClick="btnLogStanja_Click"-->
			<asp:Button class="btn btn-secondary" Text="Log stanja" ID="btnLogStanja" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#logStanja" />
        </div>
	</div>

	<!--▓						LEGENDA ZA MODAL-e									▓-->
	<!--▓	Sekcije su odvojene dugim nizom simbola	- ▓								▓-->
	<!--▓	Modali za unos/izmene počinju komentrom sa kratkim nizom simbola - ▓	▓-->
	<!--▓	Modali za provere počinju komentrom sa jednostrukim simbolom - ▓		▓-->
	<!--▓	Modali za unos sadrže prefix "new"										▓-->
	<!--▓	Modali za izmene sadrže prefix "upd"									▓-->
	<!--▓	Modali za brisanje sadrže prefix "del"									▓-->
	<!--▓	Modali za proveru sadrže naziv modal-a sa sufix-om "Chck"				▓-->

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓SUPPLIER▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!--▓▓▓▓▓▓▓▓ Modal newSupplier2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="newSupplier2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Unos novog dobavljača</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="newSupplierName" title="Naziv: Naziv firme ili poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Adresa" runat="server" /><br />
					<asp:TextBox ID="newSupplierAdress" title="Adresa: Adresa sedišta firme ili poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Grad" runat="server" /><br />
					<asp:DropDownList ID="newSupplierCity" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="PIB" runat="server" /><br />
					<asp:TextBox ID="newSupplierPIB" pattern="[0-9]{9}" title="PIB: Poreski identifikacioni kod. Mora sadržati 9 cifara 0-9." runat="server" />
					<br />
					<asp:Label Text="Matični broj" runat="server" /><br />
					<asp:TextBox ID="newSupplierMatBr" pattern="[0-8]{8}" title="Matični broj: Matični broj preduzeća je po osnivanju dodeljen od strane APR-a. Mora sadržati 8 cifara 0-9." runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#newSupplier2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal newSupplier2Chck ▓-->
	<div class="modal fade" id="newSupplier2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete ubaciti novog dobavljača!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa unosom podataka za novog dobavljača?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnNewSupplier2Chck" OnClick="btnNewSupplierChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓ Modal updSupplier2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="updSupplier2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena dobavljača</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="updSupplierName" title="Naziv: Naziv firme ili poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Adresa" runat="server" /><br />
					<asp:TextBox ID="updSupplierAdress" title="Adresa: Adresa sedišta firme ili poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Grad" runat="server" /><br />
					<asp:DropDownList ID="updSupplierCity" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="PIB" runat="server" /><br />
					<asp:TextBox ID="updSupplierPIB" pattern="[0-9]{9}" title="PIB: Poreski identifikacioni kod. Mora sadržati 9 cifara 0-9." runat="server" />
					<br />
					<asp:Label Text="Matični broj" runat="server" /><br />
					<asp:TextBox ID="updSupplierMatBr" pattern="[0-9]{8}" title="Matični broj: Matični broj preduzeća je po osnivanju dodeljen od strane APR-a. Mora sadržati 8 cifara 0-9." runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#updSupplier2Chck" class="hl-btn btn-secondary">Unesi izmene</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal updSupplier2Chck ▓-->
	<div class="modal fade" id="updSupplier2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete izmeniti dobavljača!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa izmenom podataka dobavljača?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnUpdSupplierChck" OnClick="btnUpdSupplierChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal delSupplier2Chck ▓-->
	<div class="modal fade" id="delSupplier2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete obrisati selektovanog dobavljača!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite obrisati selektovanog dobavljača?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnDelSupplier2Chck" OnClick="btnDelSupplierChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓SHOP▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!--▓▓▓▓▓▓▓▓ Modal newShop2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="newShop2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Unos novog dobavljača</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="newShopName" title="Naziv: Naziv poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Adresa" runat="server" /><br />
					<asp:TextBox ID="newShopAdress" title="Adresa: Adresa poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Grad" runat="server" /><br />
					<asp:DropDownList ID="newShopCity" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="Opis" runat="server" /><br />
					<asp:TextBox class="description" ID="newShopDesc" title="Opis prodavnice. Kako do nje, koji prevoz, radno vreme i dr. ." runat="server" />
					<br />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#newShop2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!--▓ Modal newShop2Chck ▓-->
	<div class="modal fade" id="newShop2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete ubaciti novu prodavnicu!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa unosom podataka za novu prodavnicu?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnNewShop2Chck" OnClick="btnNewShopChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓ Modal updShop2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="updShop2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena dobavljača</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="updShopName" title="Naziv: Naziv poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Adresa" runat="server" /><br />
					<asp:TextBox ID="updShopAdress" title="Adresa: Adresa poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Grad" runat="server" /><br />
					<asp:DropDownList ID="updShopCity" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="Opis" runat="server" /><br />
					<asp:TextBox class="description" ID="updShopDesc" title="Opis prodavnice. Kako do nje, koji prevoz, radno vreme i dr. ." runat="server" />
					<br />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#updShop2Chck" id="btnUpdShop" class="hl-btn btn-secondary">Unesi izmene</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal updShop2Chck ▓-->
	<div class="modal fade" id="updShop2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete izmeniti prodavnicu!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa izmenom podataka prodavnice?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnUpdShopChck" OnClick="btnUpdShopChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal delShop2Chck ▓-->
	<div class="modal fade" id="delShop2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete obrisati selektovanu prodavnicu!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite obrisati selektovanu prodavnicu?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnDelShop2Chck" OnClick="btnDelShopChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓USERS▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!--▓▓▓▓▓▓▓▓ Modal newUser2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="newUser2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Unos novog dobavljača</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Korisničko ime" runat="server" /><br />
					<asp:TextBox ID="newUserName" title="Korisničko ime: Mora sadržati bar 5 alfanumeričkih karaktera i mora početi slovom." runat="server" />
					<br />
					<asp:Label Text="Korisnička šifra" runat="server" /><br />
					<asp:TextBox type="password" ID="newUserPass" title="Korisnička šifra: Mora sadržati bar 5 alfanumeričkih karaktera i mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Ime" runat="server" /><br />
					<asp:TextBox ID="newUserFirstName" title="Ime: Mora sadržati bar 3 slova i mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Prezime" runat="server" /><br />
					<asp:TextBox ID="newUserLastName" title="Prezime: Mora sadržati bar 5 slova i mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Adresa" runat="server" /><br />
					<asp:TextBox ID="newUserAdress" title="Adresa: Adresa sedišta firme ili poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Grad" runat="server" /><br />
					<asp:DropDownList ID="newUserCity" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="Kontakt telefon" runat="server" /><br />
					<asp:TextBox ID="newUserPhone" pattern="(+)+[0-9/\- ]{9,}" title="Kontakt telefon: Mora sadržati bar 9 cifara 0-9." runat="server" />
					<br />
					<asp:Label Text="E-mail" runat="server" /><br />
					<asp:TextBox type="email" ID="newUserEmail" title="Elektronska pošta: Mora sadržati bar 3 alfanumeričkih karaktera, za kojima sledi '@', zatim provajder i domen." pattern="[A-Z]{1,}[a-zA-Z0-9]{2,}+@[a-zA-z]{2,}+\.[a-zA-z]{2,}(.[a-zA-z]{2,})" runat="server" />
					<br />
					<asp:Label Text="Matični broj" runat="server" /><br />
					<asp:TextBox ID="newUserMatBr" pattern="\d{9}|\d{13}" title="Matični broj: Matični broj preduzeća je po osnivanju dodeljen od strane APR-a. Mora sadržati 8 cifara 0-9." runat="server" />
					<br />
					<asp:Label Text="Autentifikacija" runat="server" /><br />
					<% if (Session["userAuthentication"].ToString() == "A")
						{ %>
					<asp:DropDownList ID="newUser2Auth1" runat="server">
						<asp:ListItem Text="Korisnik" Value="1"></asp:ListItem>
						<asp:ListItem Text="Zaposleni" Value="2"></asp:ListItem>
						<asp:ListItem Text="Administrator" Value="3"></asp:ListItem>
					</asp:DropDownList>
					<%}
						else
						{%>
					<asp:DropDownList ID="newUser2Auth2" runat="server">
						<asp:ListItem Text="Korisnik" Value="1"></asp:ListItem>
						<asp:ListItem Text="Zaposleni" Value="2"></asp:ListItem>
					</asp:DropDownList>
					<%}%>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#newUser2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal newUser2Chck ▓-->
	<div class="modal fade" id="newUser2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete ubaciti novog korisnika!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa unosom podataka za novog korisnika?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnNewUserChck" OnClick="btnNewUserChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓ Modal updUser2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="updUser2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena podataka korisnika</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Korisničko ime" runat="server" /><br />
					<asp:TextBox type="text" ID="updUserName" runat="server" ReadOnly="true"/>
					<asp:HiddenField value="" runat="server" ID="hidUserName"/>
					<br />
					<asp:Label Text="Korisnička šifra" runat="server" /><br />
					<asp:TextBox  type="password" ID="updUserPass" runat="server" ReadOnly="true"/>
					<asp:HiddenField value="" runat="server" ID="hidUserPass"/>
					<br />
					<asp:Label Text="Ime" runat="server" /><br />
					<asp:TextBox ID="updUserFirstName" title="Ime: Mora sadržati bar 3 slova i mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Prezime" runat="server" /><br />
					<asp:TextBox ID="updUserLastName" title="Prezime: Mora sadržati bar 5 slova i mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Adresa" runat="server" /><br />
					<asp:TextBox ID="updUserAdress" title="Adresa: Adresa sedišta firme ili poslovnice tj. ogranka. Mora početi velikim slovom." runat="server" />
					<br />
					<asp:Label Text="Grad" runat="server" /><br />
					<asp:DropDownList ID="updUserCity" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="Kontakt telefon" runat="server" /><br />
					<asp:TextBox ID="updUserPhone" pattern="(+)+[0-9/\- ]{9,}" title="Kontakt telefon: Mora sadržati bar 9 cifara 0-9." runat="server" />
					<br />
					<asp:Label Text="E-mail" runat="server" /><br />
					<asp:TextBox type="email" ID="updUserEmail" title="Elektronska pošta: Mora sadržati bar 3 alfanumeričkih karaktera, za kojima sledi '@', zatim provajder i domen." pattern="[A-Z]{1,}[a-zA-Z0-9]{2,}+@[a-zA-z]{2,}+\.[a-zA-z]{2,}(.[a-zA-z]{2,})" runat="server" />
					<br />
					<asp:Label Text="Matični broj" runat="server" /><br />
					<asp:TextBox ID="updUserMatBr" pattern="\d{9}|\d{13}" title="Matični broj: Matični broj preduzeća je po osnivanju dodeljen od strane APR-a. Mora sadržati 8 cifara 0-9." runat="server" />
					<br />
					<asp:Label Text="Autentifikacija" runat="server" /><br />
					<% if (Session["userAuthentication"].ToString() == "A")
						{ %>
					<asp:DropDownList ID="updUser2Auth1" runat="server">
						<asp:ListItem Text="Korisnik" Value="1"></asp:ListItem>
						<asp:ListItem Text="Zaposleni" Value="2"></asp:ListItem>
						<asp:ListItem Text="Administrator" Value="3"></asp:ListItem>
					</asp:DropDownList>
					<%}
						else
						{%>
					<asp:DropDownList ID="updUser2Auth2" runat="server">
						<asp:ListItem Text="Korisnik" Value="1"></asp:ListItem>
						<asp:ListItem Text="Zaposleni" Value="2"></asp:ListItem>
					</asp:DropDownList>
					<%}%>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#updUser2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal updUser2Chck ▓-->
	<div class="modal fade" id="updUser2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete izmeniti korisnika!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa izmenom podataka korisnika?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnUpdUserChck" OnClick="btnUpdUserChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal delUser2Chck ▓-->
	<div class="modal fade" id="delUser2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete obrisati selektovanog korisnika!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite obrisati selektovanog korisnika?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnDelUser2Chck" OnClick="btnDelUserChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓CATEGORY ITEMS▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!--▓▓▓▓▓▓▓▓ Modal newCatArt2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="newCatArt2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Unos nove kategorije artikla</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="newCatArt2Name" title="Naziv: Naziv kategorije artikala" runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#newCatArt2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal newCatArt2Chck ▓-->
	<div class="modal fade" id="newCatArt2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete ubaciti novu kategoriju artikla!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa unosom podataka za novu kategoriju artikla?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnNewCatArtChck" OnClick="btnNewCatArtChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓ Modal updCatArt2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="updCatArt2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena kategorije artikla</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="updCatArtName" title="Naziv: Naziv kategorije artikala" runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" onclick="return false;" data-toggle="modal" data-target="#updCatArt2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal updCatArt2Chck ▓-->
	<div class="modal fade" id="updCatArt2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete izmeniti kategoriju artikla!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa izmenom kategorije artikla?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button Text="Da" runat="server" name="Izvrši izmenu" ID="btnUpdCatArtChck" OnClick="btnUpdCatArtChck_Click" class="hl-btn btn-default" />
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal delCatArt2Chck ▓-->
	<div class="modal fade" id="delCatArt2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete obrisati selektovanu kategoriju artikla!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite obrisati selektovanu kategoriju artikla?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnDelCatArt2Chck" OnClick="btnDelKatArtChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ITEMS▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!--▓▓▓▓▓▓▓▓ Modal newItems2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="newItems2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Unos novog artikla</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="newItemsName" title="Naziv: Naziv artikala mora sadržati kratak opis artikla poput vrsta, tip, model, proizvođača i dr.(bar 15 karaktera)" runat="server" />
					<br />
					<asp:Label Text="Opis" runat="server" /><br />
					<asp:TextBox class="description" ID="newItemsDesc" title="Opis: Pun opis artikla" runat="server" />
					<br />
					<asp:Label Text="Kategorija artikla" runat="server" /><br />
					<asp:DropDownList ID="newItemsCatArt" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="Cena" runat="server" /><br />
					<asp:TextBox ID="newItemsPrice" title="Cena: Prodajna cena artikla" runat="server" />
					<br />
					<asp:Label Text="Dobavljač" runat="server" /><br />
					<asp:DropDownList ID="newItemsSupplier" runat="server"></asp:DropDownList>
					<br />
					<asp:FileUpload ID="fileUploadNew" label="Upload-ujte slike" class="custom-file-input" multiple="multiple" accept=".png" runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#newItems2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal newItems2Chck ▓-->
	<div class="modal fade" id="newItems2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete ubaciti nov artikl!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa unosom podataka za nov artikal?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnNewItemsChck" OnClick="btnNewItemsChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓ Modal updItems2 ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="updArt2" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena artikla</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Naziv" runat="server" /><br />
					<asp:TextBox ID="updItemsName" title="Naziv: Naziv artikala mora sadržati kratak opis artikla poput vrsta, tip, model, proizvođača i dr.(bar 15 karaktera)" runat="server" />
					<br />
					<asp:Label Text="Opis" runat="server" /><br />
					<asp:TextBox class="description" ID="updItemsDesc" title="Opis: Pun opis artikla" runat="server" />
					<br />
					<asp:Label Text="Kategorija artikla" runat="server" /><br />
					<asp:DropDownList ID="updItemsCatArt" runat="server"></asp:DropDownList>
					<br />
					<asp:Label Text="Cena" runat="server" /><br />
					<asp:TextBox ID="updItemsPrice" title="Cena: Prodajna cena artikla" runat="server" />
					<br />
					<asp:Label Text="Dobavljač" runat="server" /><br />
					<asp:DropDownList ID="updItemsSupplier" runat="server"></asp:DropDownList>
					<br />
					<asp:FileUpload ID="fileUploadUpd" label="Upload-ujte slike" class="custom-file-input" multiple="multiple" accept=".png" runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#updItems2Chck" class="hl-btn btn-secondary">Unesi</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal updItems2Chck ▓-->
	<div class="modal fade" id="updItems2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete izmeniti artikal!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste završili sa izmenom podataka za selektovani artikal?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnUpdItemsChck" OnClick="btnUpdItemsChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal delItems2Chck ▓-->
	<div class="modal fade" id="delItems2Chck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Upravo ćete obrisati selektovani artikal!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite obrisati selektovani artikal?</label>
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					<asp:Button ID="btnDelItems2Chck" OnClick="btnDelArtChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓STANJE▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!--▓▓▓▓▓▓▓▓ Modal showStanje ▓▓▓▓▓▓▓▓-->
	<div class="modal fade" id="showStanje" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" style="max-width: 800px">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Stanje</h5>
				</div>
				<div class="modal-body">
					<div class="row" id="showStanjeZaglavlje">
						<div class="col-4 mb-3">
							<asp:Label Text="Grupiši prema prodavnici" runat="server" /><br />
							<asp:DropDownList ID="stShop" runat="server" disabled></asp:DropDownList><br />
							<button type="button" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Prema prodavnici</button>
						</div>
						<div class="col-6 mb-3">
							<asp:Label Text="Grupiši prema artiklu" runat="server" /><br />
							<asp:DropDownList ID="stItem" runat="server" disabled></asp:DropDownList><br />
							<button type="button" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Prema artiklu</button>
						</div>
						<div class="col-2 mb-3">
							<button type="button" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Grupiši</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<asp:GridView runat="server" ID="stGrid"></asp:GridView>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-3">
						<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					</div>
					<div class="col-3">
						<button type="button" id="exportStanje" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Export</button>
					</div>
					<div class="col-3">
						<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#izmeniStanje" class="hl-btn btn-secondary">Izmeni</button>
					</div>
					<div class="col-3">
						<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#dodajStanje" class="hl-btn btn-secondary">Dodaj</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal izmeniStanje ▓-->
	<div class="modal fade" id="izmeniStanje" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" style="max-width: 600px">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena stanja</h5>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-4 mb-3">
							<asp:Label Text="Prodavnica" runat="server" /><br />
							<asp:DropDownList ID="chgStanjeShop" runat="server"></asp:DropDownList>
						</div>
						<div class="col-6 mb-3">
							<asp:Label Text="Artikal" runat="server" />
							<asp:DropDownList ID="chgStanjeArt" runat="server"></asp:DropDownList>
						</div>
						<div class="col-2 mb-3">
							<asp:Label Text="Količina" runat="server" />
							<input type="number" pattern="[0-9]{1,}" name="kolicina" id="chgStanjeQty" runat="server" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-6">
						<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					</div>
					<div class="col-6">
						<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#izmeniStanjeChck" class="hl-btn btn-secondary">Izmeni</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal izmeniStanjeChck ▓-->
	<div class="modal fade" id="izmeniStanjeChck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Izmena stanje!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite da izmenite selektovano stanje?</label>
				</div>
				<div class="modal-footer">
					<div class="col-6">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					</div>
					<div class="col-6">
						<asp:Button ID="btnIzmeniStanjeChck" OnClick="btnIzmeniStanjeChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ▓ Modal dodajStanje ▓-->
	<div class="modal fade" id="dodajStanje" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Dodavanje stanja</h5>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-4 mb-3">
							<asp:Label Text="Prodavnica" runat="server" /><br />
							<asp:DropDownList ID="newStanjeShop" runat="server"></asp:DropDownList>
						</div>
						<div class="col-6 mb-3">
							<asp:Label Text="Artikal" runat="server" />
							<asp:DropDownList ID="newStanjeArt" runat="server"></asp:DropDownList>
						</div>
						<div class="col-2 mb-3">
							<asp:Label Text="Količina" runat="server" />
							<input type="number" pattern="[0-9]{1,}" name="name" id="newStanjeQty" runat="server" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-6">
						<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
					</div>
					<div class="col-6">
						<button type="button" onclick="return false;" style="padding-bottom: 5px;" data-toggle="modal" data-target="#dodajStanjeChck" class="hl-btn btn-secondary">Dodaj</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal dodajStanjeChck ▓-->
	<div class="modal fade" id="dodajStanjeChck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Ubacivanje novog stanja!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite uneti novo stanje?</label>
				</div>
				<div class="modal-footer">
					<div class="col-6">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					</div>
					<div class="col-6">
						<asp:Button ID="btnDodajStanjeChck" OnClick="btnDodajStanjeChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓LogSTANJA▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!-- ▓ Modal logStanja ▓-->
	<div class="modal fade" id="logStanja" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" style="max-width: 900px">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Log stanja</h5>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-12">
							<asp:GridView runat="server" ID="logStanjaGrid"></asp:GridView>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-6">
							<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
						</div>
						<div class="col-6">
							<!--▓▓▓▓▓▓-->
							<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Export</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓Fakture▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓-->

	<!-- ▓ Modal showFakture ▓-->
	<div class="modal fade" id="showFakture" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Fakture</h5>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-4 mb-3">
							<asp:Label Text="Od" runat="server" />
							<input type="text" value="1/1/2000" style="width: 100px;" readonly="readonly" name="Date" id="showFaktureOd" class="hasDatepicker" disabled />
						</div>
						<div class="col-4 mb-3">
							<asp:Label Text="Do" runat="server" />
							<input type="text" value="1/1/2000" style="width: 100px;" readonly="readonly" name="Date" id="showFaktureDo" class="hasDatepicker" disabled />
						</div>
						<div class="col-4 mb-3">
							<button type="button" id="osveziFakturu" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Primeni</button>
						</div>
					</div>
					<div class="row">
						<div class="col-5">
							<asp:ListBox runat="server" ID="showFaktureList"></asp:ListBox>
						</div>
						<div class="col-7">
							<button type="button" class="hl-btn btn-secondary" id="showFakt">Otvori</button>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-4">
							<button type="button" class="hl-btn btn-secondary" data-dismiss="modal">Izađi</button>
						</div>
						<div class="col-4">
							<button type="button" style="padding-bottom: 5px;" data-toggle="modal" data-target="#uskoro" class="hl-btn btn-secondary uskoro">Export</button>
						</div>
						<div class="col-4">
							<button type="button" style="padding-bottom: 5px;" data-toggle="modal" onclick="return false;" data-target="#stornChck" class="hl-btn btn-secondary">Storn</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ▓ Modal stornChck ▓-->
	<div class="modal fade" id="stornChck" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Storniranje fakture!</h5>
				</div>
				<div class="modal-body">
					<label>Da li ste sigurni da želite da stornirate fakturu?</label>
				</div>
				<div class="modal-footer">
					<div class="col-6">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ne</button>
					</div>
					<div class="col-6">
						<asp:Button ID="btnStornChck" OnClick="btnStornChck_Click" class="hl-btn btn-default" runat="server" Text="Da" />
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Nesipravan unos -->
	<div class="modal fade" id="Neispravan" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Neispravan unos</h5>
				</div>
				<div class="modal-body">
					<label>Neispravan unos!</label>
					<br />
					<label>Molimo Vas da proverite unete podatke i pokušajte ponovo!</label>
				</div>
				<div class="modal-footer">
					<div class="col-12">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ok</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- SelektujteUpd -->
	<div class="modal fade" id="SelektujteUpd" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Selektujte</h5>
				</div>
				<div class="modal-body">
					<label>Molimo Vas da selektujete stavku koju želite da promenite!</label>
				</div>
				<div class="modal-footer">
					<div class="col-12">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ok</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- SelektujteDel -->
	<div class="modal fade" id="SelektujteDel" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Selektujte</h5>
				</div>
				<div class="modal-body">
					<label>Molimo Vas da selektujete stavku koju želite da obrišete!</label>
				</div>
				<div class="modal-footer">
					<div class="col-12">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ok</button>
					</div>
				</div>
			</div>
		</div>
	</div>
		<%-- modal selektujte fakturu --%>
	<div class="modal fade" id="selektuj" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Nije selektovna faktura!</h5>
				</div>
				<div class="modal-body">
					<asp:Label Text="Morate selektovati fakturu koju želite da pregledate!" runat="server" />
				</div>
				<div class="modal-footer">
					<button type="button" class="hl-btn btn-default" data-dismiss="modal">oK</button>
				</div>
			</div>
		</div>
	</div>
	<!-- USKORO -->
	<div class="modal fade" id="uskoro" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">U sledećoj verziji!</h5>
				</div>
				<div class="modal-body">
					<label>Ova funkcija još nije omogućen.</label>
					<br />
					<label>Uskoro ćete imati mogućnost:</label>
					<ul>
						<li>Exportovanja Vaših faktura u .xls fajl</li>
						<li>Exportovanja Vašeg stanja u .xls fajl</li>
						<li>Exportovanja Vašeg loga o promenama stanja u .xls fajl</li>
						<li>Filtriranje stanja prema prodavnici, prema artiklu i prema prodavnici i artiklu</li>
						<li>Filtriranje Vaših faktura prema datumu sa selekcijom datuma "od-do"</li>
						<li>Filtriranje Vašeg loga o promenama stanja prema datumu sa selekcijom datuma "od-do"</li>
						<li>i mnoge druge</li>
					</ul>
					<label>Molimo Vas za strpljenje.</label>
					<br />
					<label>Ostanite pretplaćeni na ovaj sajt.</label>
					<br />
					<label>Razvojni tim sajta Vam želi uspešno poslovanje.</label>
				</div>
				<div class="modal-footer">
					<div class="col-12">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ok</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		//▓▓▓ U P D A T E
		//updSupplier
		document.getElementById("updSupplier1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox1').val();
			if (id > 0) {
				$('#updSupplier2').modal('show');
				var objekat = { ID: id };
				$.ajax({
					url: "Podesavanja.aspx/updSupplier",
					method: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(objekat),
					success: function (result) {
						var supplier = JSON.parse(result.d);
						$('#MainContent_updSupplierName').val(supplier.Naziv);
						$('#MainContent_updSupplierAdress').val(supplier.Adresa);
						$('#MainContent_updSupplierCity').val(supplier.GradId);
						$('#MainContent_updSupplierPIB').val(supplier.Pib);
						$('#MainContent_updSupplierMatBr').val(supplier.MatBr);
					},
					error: function () {
						alert("ne radi");
					}
				})
			}
			else {
				$('#SelektujteUpd').modal('show');
			}
		});
		//updShop
		document.getElementById("updShop1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox2').val();
			if (id > 0) {
				$('#updShop2').modal('show');
				var objekat = { ID: id };
				$.ajax({
					url: "Podesavanja.aspx/updShop",
					method: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(objekat),
					success: function (result) {
						var shop = JSON.parse(result.d);
						$('#MainContent_updShopName').val(shop.Naziv);
						$('#MainContent_updShopAdress').val(shop.Adresa);
						$('#MainContent_updShopCity').val(shop.GradId);
						$('#MainContent_updShopDesc').val(shop.Opis);
					},
					error: function () {
						alert("ne radi");
					}
				})
			}
			else {
				$('#SelektujteUpd').modal('show');
			}
		});
		//updUser
		document.getElementById("updUser1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox5').val();
			if (id > 0) {
				$('#updUser2').modal('show');
				var objekat = { ID: id };
				$.ajax({
					url: "Podesavanja.aspx/updUser",
					method: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(objekat),
					success: function (result) {
						var korisnik = JSON.parse(result.d);
						$('#MainContent_updUserName').val(korisnik.UserName);
						$('#MainContent_hidUserName').val(korisnik.UserName);
						$('#MainContent_updUserPass').val(korisnik.Sifra);
						$('#MainContent_hidUserPass').val(korisnik.Sifra);
						$('#MainContent_updUserFirstName').val(korisnik.Ime);
						$('#MainContent_updUserLastName').val(korisnik.Prezime);
						$('#MainContent_updUserAdress').val(korisnik.Adresa);
						$('#MainContent_updUserCity').val(korisnik.GradId);
						$('#MainContent_updUserEmail').val(korisnik.Email);
						$('#MainContent_updUserPhone').val(korisnik.Tel);
						$('#MainContent_updUserMatBr').val(korisnik.Mb);
						$('#MainContent_updUser2Auth1').val(korisnik.Auth);
						$('#MainContent_updUser2Auth2').val(korisnik.Auth);
					},
					error: function () {
						alert("ne radi");
					}
				})
			}
			else {
				$('#SelektujteUpd').modal('show');
			}
		});
		//updCatArt
		document.getElementById("updCatArt1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox3').val();
			if (id > 0) {
				$('#updCatArt2').modal('show');
				var objekat = { katId: id };
				$.ajax({
					url: "Podesavanja.aspx/updCatArt",
					method: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(objekat),
					success: function (result) {
						var kat = JSON.parse(result.d);
						$('#MainContent_updCatArtName').val(kat.Naziv);
					},
					error: function () {
						alert("ne radi");
					}
				})
			}
			else {
				$('#SelektujteUpd').modal('show');
			}
		});
		//updArt
		document.getElementById("updArt1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox4').val();
			if (id > 0) {
				$('#updArt2').modal('show');
				var objekat = { artId: id };
				$.ajax({
					url: "Podesavanja.aspx/updArt",
					method: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(objekat),
					success: function (result) {
						var art = JSON.parse(result.d);
						$('#MainContent_updItemsName').val(art.Naziv);
						$('#MainContent_updItemsDesc').val(art.Opis);
						$('#MainContent_updItemsCatArt').val(art.KatArtId);
						$('#MainContent_updItemsPrice').val(art.Cena);
						$('#MainContent_updItemsSupplier').val(art.DobavljacId);
					},
					error: function () {
						alert("ne radi");
					}
				})
			}
			else {
				$('#SelektujteUpd').modal('show');
			}
		});
		//▓▓▓ D E L E T E
		//delSupplier
		document.getElementById("delSupplier1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox1').val();
			if (id > 0) {
				$('#delSupplier2Chck').modal('show');
			}
			else {
				$('#SelektujteDel').modal('show');
			}
		});
		//delShop
		document.getElementById("delShop1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox2').val();
			if (id > 0) {
				$('#delShop2Chck').modal('show');
			}
			else {
				$('#SelektujteDel').modal('show');
			}
		});
		//delUser
		document.getElementById("delUser1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox5').val();
			if (id > 0) {
				$('#delUser2Chck').modal('show');
			}
			else {
				$('#SelektujteDel').modal('show');
			}
		});
		//delCatArt
		document.getElementById("delCatArt1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox3').val();
			if (id > 0) {
				$('#delCatArt2Chck').modal('show');
			}
			else {
				$('#SelektujteDel').modal('show');
			}
		});
		//delArt
		document.getElementById("delArt1").addEventListener("click", function () {
			var id = $('#MainContent_ListBox4').val();
			if (id > 0) {
				$('#delItems2Chck').modal('show');
			}
			else {
				$('#SelektujteDel').modal('show');
			}
		});
		//▓▓▓ O T V O R I    F A K T U R U
        document.getElementById('showFakt').addEventListener('click', function () {
            var oznaka = $('#MainContent_showFaktureList').val();
			if (oznaka != null && oznaka != '') {
				var objekat = { racun: oznaka };
				$.ajax({
					url: "Default.aspx/openFakturu",
					method: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(objekat),
					success: function () {
						window.open('Faktura.aspx', '_blank');
					},
					error: function () {
						alert("ne radi");
					}
				})
			}
			else {
				$('#selektuj').modal('show');
			}
		});
	</script>
	<script src="Scripts/Podesavanja.js"></script>
	<link rel="stylesheet" type="text/css" href="Content/cssPodesavanja.css">
</asp:Content>
