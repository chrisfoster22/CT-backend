
$.ajax({
	url: "https://www.googleapis.com/books/v1/volumes",
	method: "GET",
	data:{q: "dune"},
	contentType:"application/json",
	success: function(response){
		console.log(response);
	}

})
