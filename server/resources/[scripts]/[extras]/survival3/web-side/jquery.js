// -------------------------------------------------------------------------------------------
window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Display":
			$("#deathDiv").css("display",event["data"]["Mode"]);
		break;

		case "Message":
			$("#deathText").html(event["data"]["Message"]);
		break;
	}
});