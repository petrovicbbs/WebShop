$(document).ready(function () {
	$("#flip").click(function () {
		$("#panel").slideToggle("slow");
	});
});

$(document).ready(function () {
	$("#menu-toggle").click(function (e) {
		$("#wrapper").toggleClass("toggled");
	});
});

$(".kategorije").on("click", function () {
	var categoryName = $(this).val();
	var objekat = { category: categoryName };
	$.ajax({
		url: "Default.aspx/openCategory",
		method: "POST",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(objekat),
		success: function () { location.href = "Default.aspx"; },
		error: function () {
			alert("ne radi");
		}
	})
})

function check(input) {
	if (input.value != document.getElementById('regUserPass').value) {
		input.setCustomValidity('Niste ispravno ponovili korisničku šifru.');
	} else {
		input.setCustomValidity('');
	}
}

function openLogIn() {
	$('#LogIn').modal('show');
}

function notEnough(Stanje) {
	$("#txtNotEnough").text("Raspolažemo sa " + Stanje + " proizvoda");
	$('#itemQty').text = '';
	$('#notEnough').modal('show');
}

function neispravan() {
	$('#Neispravan').modal('show');
}

function badLogIn() {
	$('#LogIn').modal('show');
	$('#BadLogIn').modal('show');
}