document.getElementById("moj").addEventListener("click", function () {
    var naziv = prompt("Unesi naziv");
    var objekat = { ime: naziv };
    $.ajax({
        url: "Default.aspx/Vrati",
        method: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(objekat),
        success: function () { alert("radi"); },
        error: function () {
            alert("ne radi");
        }
    })
})