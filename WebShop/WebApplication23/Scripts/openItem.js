$(".detaljnije").on("click", function () {
	var itemId = $(this).val();
	var objekat = { item: itemId };
	$.ajax({
		url: "Default.aspx/openItem",
		method: "POST",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(objekat),
		success: function () { location.href = "Artikal.aspx"; },
		error: function () { alert("ne radi");
		}
	})
})
