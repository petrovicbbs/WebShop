<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kontakt.aspx.cs" Inherits="WebApplication23.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<link rel="stylesheet" type="text/css" href="Content/cssKontakt.css">
	<div class="container bg-light text-secondary contact-form">
		<h1>Kontakt</h1>
		<hr>
		<div class="row">
			<div class="col-6" id="logoPicDiv">
				<img class="noselect logoPic" id="logImg" src="Images/logo.png" alt="" width="200" height="200">
			</div>
			<div class="col-6 d-block">
				<div class="form-group">
					<label>Ime:</label>
					<input id="ime" type="text" class="form-control">
				</div>

				<div class="form-group">
					<label>E-mail:</label>
					<input id="e-mail" type="text" class="form-control">
				</div>

				<div class="form-group">
					<label>Poruka:</label>
					<textarea id="poruka" class="form-control" rows="5"></textarea>
				</div>

				<div class="form-group">
					<button id="dugme" type="submit" class="btn btn-secondary" onclick="return false">Pošalji</button>
				</div>
			</div>
		</div>
		<h1 class="font-italic">ILI ako ne volite mnogo mejlove već volite da popričate sa našim stručnim osobljem uvek možete svratiti do nas na neku od sledećih lokacija</h1>
		<div id="prodavnice" runat="server">
		</div>
		<script src="Scripts/Kontakt.js"></script>
	</div>
</asp:Content>




