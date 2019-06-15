$("#dugme").click(function () {
	var ime = $("#ime").val();
    var email = $("#e-mail").val();
	var poruka = $("#poruka").val();        
    $.ajax({
        url: "Kontakt.aspx/posaljiMejl",
        method: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ime: ime, email: email, poruka: poruka }),
        success: function (result)
        {
            alert(result.d);
        },
        error: function ()
        {
            alert("Došlo je do greške.");
        }
    })
})