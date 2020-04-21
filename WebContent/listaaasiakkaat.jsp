<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakas Lista</title>

	

</head>
<body>
	<table id="lista">
		<thead>
		<tr>
			<th colspan="5" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>	
		
			<tr>
			<th>Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi"></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		
		</tbody>
	</table>
<script>
$(document).ready(function() {
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
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
				htmlStr+="<tr id='rivi "+field.etunimi+"'>";
				htmlStr+= "<td>"+field.etunimi+"</td>";
				htmlStr+= "<td>"+field.sukunimi+"</td>";
				htmlStr+= "<td>"+field.puhelin+"</td>";
				htmlStr+= "<td>"+field.sposti+"</td>";
				htmlStr+= "<td><span class='poista' onclick=poista('"+field.etunimi+"')>Poista</span></td>";
				htmlStr+="</tr>";
				$("#lista tbody").append(htmlStr);
			});
		}
	});	
}
function poista(etunimi) {
	if(confirm("Poista asiakas " + etunimi +"?")){
		$.ajax({url:"asiakkaat/"+etunimi, type:"DELETE", dataType:"json", success:function(result) { 
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+etunimi).css("background-color", "red"); 
	        	alert("Asiakkaan " + etunimi +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
		
	}
}
</script>

</body>
</html>