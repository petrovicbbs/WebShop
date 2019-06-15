<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Faktura.aspx.cs" Inherits="WebApplication23.Faktura" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title><%=Session["oznakaRacuna"].ToString()%></title>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<script src="Scripts/jquery-3.3.1.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.0.js"></script>

</head>
<body>
	<form id="form1" runat="server">
		<div class="container noselect">
			<div class="row">
				<div class="col-3 ucesnici">
					<p runat="server" class="ucesnik">Kupac:</p>
					<p runat="server" id="imeKupca"></p>
					<p runat="server" id="prezimeKupca"></p>
					<p runat="server" id="adresaKupca"></p>
					<p runat="server" id="gradKupca"></p>
				</div>
				<div id="logo" class="col-6">
					<img src="Images/logo.png">
				</div>
				<div class="col-3 ucesnici">
					<p runat="server" class="ucesnik">Prodavac:</p>
					<p runat="server" id="nazivProdavca">Web Shop</p>
					<p runat="server" id="nazivPoslovnice"></p>
					<p runat="server" id="adresaPoslovnice"></p>
					<p runat="server" id="gradPoslovnice"></p>
				</div>
			</div>
			<br />
			<br />
			<br />
			<div class="row">
				<br />
				<br />
				<br />
				<br />
				<br />
				<div class="col-12" id="oznakaRac">
					<h4 runat="server" id="oznakaRacuna"></h4>
				</div>
			</div>
			<br />
			<br />
			<div class="row" runat="server" id="tabelaFakture">
			</div>
			<br />
			<br />
			<br />
			<br />
			<br />
			<p id="datumFakturisanja" runat="server">Dana: </p>
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
			<img id="pecat" src="Images/potpisIPecat.png" align="right" />
			<br />
			<img id="storno" runat="server" src="Images/storno.png"/>
			<br />
			<br />
			<br />
			<br />
			<br />
			<hr />
		</div>
	</form>
	<link href="Content/cssFaktura.css" rel="stylesheet" />
</body>
</html>
