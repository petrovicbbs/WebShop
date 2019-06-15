<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebApplication23.Settings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="Content/StyleSheet1.css" />
</head>
<body id="settings">
    <form id="form1" runat="server">
        <script src="Scripts/jquery-3.3.1.js"></script>

        <h2>Dobrodošli u podešavanja</h2>
        <div class="row text-center">
            <div class="col-sm-3">
                <asp:ListBox class="listBox" ID="ListBox1" runat="server"></asp:ListBox>
                <br />
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" name="Ubacivanje" id="newSupplier1" data-toggle="modal" data-target="#newSupplier2">+</button>
                    <button type="button" class="btn btn-secondary" name="Izmeni" id="updSupplier1" data-toggle="modal" data-target="#updSupplier2">&#x21bb;</button>
                    <button type="button" class="btn btn-secondary" name="Brisanje" id="delSupplier1" data-toggle="modal" data-target="#delSupplier2">-</button>
                </div>
            </div>
            <div class="col-sm-3">
                <asp:ListBox class="listBox" ID="ListBox2" runat="server"></asp:ListBox>
                <br />
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" name="Ubacivanje" id="newShop1" data-toggle="modal" data-target="#newShop2">+</button>
                    <button type="button" class="btn btn-secondary" name="Izmeni" id="updShop1" data-toggle="modal" data-target="#updShop2">&#x21bb;</button>
                    <button type="button" class="btn btn-secondary" name="Brisanje" id="delShop1" data-toggle="modal" data-target="#delShop2">-</button>
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
                    <button type="button" class="btn btn-secondary" name="Ubacivanje" id="newCatArt1" data-toggle="modal" data-target="#newCatArt2">+</button>
                    <button type="button" class="btn btn-secondary" name="Izmeni" id="updCatArt1" data-toggle="modal" data-target="#updCatArt2">&#x21bb;</button>
                    <button type="button" class="btn btn-secondary" name="Brisanje" id="delCatArt1" data-toggle="modal" data-target="#delCatArt2">-</button>
                </div>
            </div>
            <div class="col-sm-3">
                <asp:ListBox class="listBox" ID="ListBox4" runat="server"></asp:ListBox>
                <br />
                <div class="btn-group text-center">
                    <button type="button" class="btn btn-secondary" name="Ubacivanje" id="newArt1" data-toggle="modal" data-target="#newArt2">+</button>
                    <button type="button" class="btn btn-secondary" name="Izmeni" id="updArt1" data-toggle="modal" data-target="#updArt2">&#x21bb;</button>
                    <button type="button" class="btn btn-secondary" name="Brisanje" id="delArt1" data-toggle="modal" data-target="#delArt2">-</button>
                </div>
            </div>
        </div>

        <div>
            <div class="btn-group" role="group" aria-label="Basic example">
                <button type="button" id="Unos" onclick="" class="btn btn-secondary" data-toggle="modal" data-target="#Art">+</button>
                <button type="button" class="btn btn-secondary">Middle</button>
                <button type="button" class="btn btn-secondary">Right</button>
            </div>
        </div>

        <div>
            <div class="btn-group" role="group" aria-label="Basic example">
                <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#Dob">+</button>
                <button type="button" class="btn btn-secondary">Middle</button>
                <button type="button" class="btn btn-secondary">Right</button>
            </div>
        </div>

        <!-- Modal Art-->
        <div class="modal fade" id="Art" tabindex="-1" role="dialog" aria-labelledby="ArtModalLabel" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Unos novog artikla</h5>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="Naziv" runat="server" />
                        <asp:TextBox ID="Name" runat="server" />
                        <br />
                        <asp:Label Text="Kategorija artikla" runat="server" />
                        <asp:DropDownList ID="KatArt" runat="server"></asp:DropDownList>
                        <br />
                        <asp:Label Text="Opis" runat="server" />
                        <asp:TextBox ID="Desc" runat="server" />
                        <br />
                        <asp:Label Text="Dobavljac" runat="server" />
                        <asp:DropDownList ID="Supplier" runat="server"></asp:DropDownList>
                        <br />
                        <asp:Label Text="Cena" runat="server" />
                        <asp:TextBox ID="Price" runat="server" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                        <button type="button" data-toggle="modal" data-target="#delDob" class="btn btn-primary" aria-hidden="true">Save changes</button>
                        <%--                        <button type="button" data-toggle="modal" data-target="#delDob" class="btn btn-primary" aria-hidden="true">Save changes</button>--%>
                        <%--<asp:Button ID="Button1" OnClick="Button1_Click" runat="server" class="btn btn-primary" Text="Save changes" />--%>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Dob-->
        <div class="modal fade" id="Dob" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Unos novog dobavljaca</h5>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="Naziv" runat="server" /><br />
                        <asp:TextBox ID="Naziv" runat="server" />
                        <br />
                        <asp:Label Text="Adresa" runat="server" /><br />
                        <asp:TextBox ID="Adress" runat="server" />
                        <br />
                        <asp:Label Text="Grad" runat="server" /><br />
                        <asp:DropDownList ID="city" runat="server"></asp:DropDownList>
                        <br />
                        <asp:Label Text="PIB" runat="server" /><br />
                        <asp:TextBox ID="PIB" runat="server" />
                        <br />
                        <asp:Label Text="MatBr" runat="server" /><br />
                        <asp:TextBox ID="MatBr" runat="server" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="hl-btn btn-secondary" id="modalModalClose">Cancel</button>
                        <button type="button" class="hl-btn btn-primary">Upload</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal DelDob-->
        <div class="modal fade" id="delDob" tabindex="-1" role="dialog" aria-labelledby="SuppModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Unos novog dobavljaca</h5>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="Da li ste sigurni da želite obrisati stavku" runat="server" /><br />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="hl-btn btn-default" id="delDobClose">No</button>
                        <asp:Button ID="Button1" class="hl-btn btn-default" runat="server" Text="Yes" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>    
        $('#delDobClose').click(function () {
            $('#delDob').modal('toggle');
        });

        function reloadPage() {
            window.location.reload()
        }

        document.getElementById("ListBox3").addEventListener("change", function () {
            var value = document.getElementById("ListBox3").value;
            $.ajax({
                url: "Settings.aspx/loadArt",
                type: "POST",
                data: JSON.stringify({ vrednost: value }),
                contentType: "application/json; charset=utf-8",
                success: function () {
                    alert("uspeo");
                },
                error: function () {
                    alert(" nije uspeo");
                }
            });
    </script>
</body>
</html>
