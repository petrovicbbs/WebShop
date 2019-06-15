<%@ Page Title="Web Shop" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication23._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<script src="Scripts/jquery-3.3.1.js"></script>
	<link rel="stylesheet" type="text/css" href="Content/cssDefault.css">
	<div id="showAll" runat="server">
		<main role="main">
			<div class="album py-5 bg-transparent">
				<div class="container">
					<div class="row" id="parent" runat="server">
					</div>
				</div>
			</div>
		</main>
	</div>
	<script>
		$(".inBasket").on("click", function () {
			var value = $(this).val();
			var objekat = { Id: value };
			$.ajax({
				url: "Default.aspx/Kupi",
				method: "POST",
				contentType: "application/json; charset=utf-8",
				data: JSON.stringify(objekat),
				success: function () { window.location.href = "Default.aspx"; },
				error: function () {
					alert("ne radi");
				}
			})
		});
	</script>
	<script src="Scripts/openItem.js"></script>
</asp:Content>


