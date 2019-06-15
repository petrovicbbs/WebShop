<%@ Page Title="Setup" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Setup.aspx.cs" Inherits="WebApplication23.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Dobrodošli u podešavanja</h2>
    <div class="row text-center">
        <div class="col-sm-3">
            <asp:ListBox class="listBox" ID="ListBox1" runat="server"></asp:ListBox>
            <br />
            <div class="btn-group">
                <button type="button" name="Ubacivanje" id="ButtonID1" class="btn btn-secondary" onclick="Ubacivanje()">+</button>
                <button type="button" name="Izmeni" id="ButtonID2" class="btn btn-secondary">&#x21bb;</button>
                <button type="button" name="Brisanje" id="ButtonID3" class="btn btn-secondary">-</button>
            </div>
        </div>
        <div class="col-sm-3">
            <asp:ListBox class="listBox" ID="ListBox2" runat="server"></asp:ListBox>
            <br />
            <div class="btn-group">
                <button type="button" name="Ubacivanje" id="ButtonID4" class="btn btn-secondary">+</button>
                <button type="button" name="Izmeni" id="ButtonID5" class="btn btn-secondary">&#x21bb;</button>
                <button type="button" name="Brisanje" id="ButtonID6" class="btn btn-secondary">-</button>
            </div>
        </div>
    </div>
    <br />
    <br />
    <div class="row text-center">
        <div class="col-sm-3">
            <asp:ListBox class="listBox" ID="ListBox3" runat="server" OnSelectedIndexChanged="ListBox3_SelectedIndexChanged"></asp:ListBox>
            <br />
            <div class="btn-group">
                <button type="button" name="Ubacivanje" id="moj" class="btn btn-secondary">+</button>
                <button type="button" name="Izmeni" id="ButtonID8" class="btn btn-secondary">&#x21bb;</button>
                <button type="button" name="Brisanje" id="ButtonID9" class="btn btn-secondary">-</button>
            </div>
        </div>
        <div class="col-sm-3">
            <asp:ListBox class="listBox" ID="ListBox4" runat="server"></asp:ListBox>
            <br />
            <div class="btn-group text-center">
                <button type="button" name="Ubacivanje" id="ButtonID10" class="btn btn-secondary">+</button>
                <button type="button" name="Izmeni" id="ButtonID11" class="btn btn-secondary">&#x21bb;</button>
                <button type="button" name="Brisanje" id="ButtonID12" class="btn btn-secondary">-</button>
            </div>
        </div>
    </div>
        <link rel="stylesheet" type="text/css" href="Content/StyleSheet1.css">

</asp:Content>
