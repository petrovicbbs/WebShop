<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Artikal.aspx.cs" Inherits="WebApplication23.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<br />
	<div class="row">
		<div class="col-12 col-sm-12 col-md-7 col-lg-7">
			<div class="carousel slide" data-ride="carousel" id="carousel">
				<ol class="carousel-indicators" runat="server" id="Indikatori">
				</ol>
				<div class="carousel-inner" id="Galerija" runat="server">
				</div>
				<a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="sr-only">Prethodna</span>
				</a>
				<a class="carousel-control-next" href="#carousel" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="sr-only">Sledeća</span>
				</a>
			</div>
		</div>
		<div class="col-12 col-sm-12 col-md-5 col-lg-5">
			<h2 class="newarrival text-center" id="artikalKategorija" runat="server"></h2>
			<h3 id="artikalNaziv" runat="server"></h3>
			<p id="artikalOpis" runat="server"></p>
			<p id="artikalCena" runat="server" class="price thicker"></p>
			<label>Količina: </label>
			<asp:TextBox runat="server" ID="itemQty" Min="1" Style="min-width: 45px; max-width: 45px;" type="number" />
			<asp:Button Text="Ubaci u korpu" ID="inBasket" class="btn btn-secondary cart" runat="server" OnClick="inBasket_Click" />
		</div>
	</div>

	<%-- modal notEnough --%>
		<div class="modal fade" id="notEnough" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Nemamo željenu količinu proizvoda</h5>
					</div>
					<div class="modal-body">
						<p id="txtNotEnough"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="hl-btn btn-default" data-dismiss="modal">Ok</button>
					</div>
				</div>
			</div>
		</div>
	<link rel="stylesheet" type="text/css" href="Content/cssArtikal.css">
</asp:Content>
