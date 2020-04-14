<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakas Lista</title>
<style>
	#lista {
	border: 1px solid;
	border-collapse: collapse;
	}
	#lista tr:nth-child(even){
	background-color: #f2f2f2;
	}

	#lista tr:hover {background-color: #ddd;
	}
	
	th {
	background-color: powderblue;
	border: 1px solid;
	border-collapse: collapse;
	padding: 5px;
	text-align: left;
	}
	
	td {
	border: 1px solid;
	border-collapse: collapse;
	padding: 5px;
	}
	#hakunappi {
	font-weight: bold;
	}
	#hakunappi: hover {background-color: #ddd;}
	
</style>
</head>
<body>
	<table id="lista">
		<thead>
			<tr>
			<th>Hakusana:</th>
			<th colspan="2"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi"></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
			</tr>
		</thead>
		<tbody>
		
		</tbody>
	</table>
<script>
$(document).ready(function() {
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();
});

function haeAsiakkaat(){
	$("#lista tbody").empty();
	$.ajax({
		url:"asiakkaat/"+$("#hakusana").val(),
		type:"GET",
		dataType:"json",
		success:function(result) {
			$.each(result.asiakkaat, function(i, field) {
				var htmlStr;
				htmlStr+="<tr>";
				htmlStr+= "<td>"+field.etunimi+"</td>";
				htmlStr+= "<td>"+field.sukunimi+"</td>";
				htmlStr+= "<td>"+field.puhelin+"</td>";
				htmlStr+= "<td>"+field.sposti+"</td>";
				htmlStr+="</tr>";
				$("#lista tbody").append(htmlStr);
			});
		}
	});	
}

</script>

</body>
</html>