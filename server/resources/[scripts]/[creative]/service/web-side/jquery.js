/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://service/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
window.addEventListener("message",function(event){
	switch (event["data"]["action"]){
		case "openSystem":
			$("#Body").css("display","flex");
			$(".Title p").html(event["data"]["title"]);
			Groups();
		break;

		case "closeSystem":
			$(".InputPass").val("")
			$("#Body").css("display","none");
			$("#Modal").css("display","none");
		break;

		case "Update":
			Groups();
		break;
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const Groups = () => {
	$.post("http://service/Request","",(data) => {
		var List = data["Result"].sort((a,b) => (a["Passport"] > b["Passport"]) ? 1: -1);

		$("#Content tbody").html(`
			${List.map((item) => (`
				<tr class="Line" data-passport="${item["Passport"]}">
					<td width="91%">
						<div class="Name">
							<div class="Status ${item["Status"] == undefined ? "Vermelho":"Verde"}"></div>
							<span>${item["Passport"]} | ${item["Name"]}</span>
						</div>
					</td>
					<td width="3%" nowrap>${item["Hierarchy"]}</td>
					<td width="3%" nowrap>${item["Phone"]}</td>
					<td width="3%">
						<div class="Management">
							<button type="button" id="Up" ${item["Me"] || item["maxHierarchy"] ? "disabled" : ""}>
								<img src="images/arrowUp.svg">
							</button type="button">
							<button type="button" id="Down" ${item["Me"] || item["minHierarchy"] ? "disabled" : ""}>
								<img src="images/arrowDown.svg">
							</button type="button">
							<button type="button" id="Remove" ${item["Me"] ? "disabled" : ""}>
								<img src="images/close.svg">
							</button type="button">
						</div>
					</td>
				</tr>
			`)).join('')}
		`);
	});
};
/* ----------REMOVE---------- */
$(document).on("click","#Remove",function(e){
	$("#Modal").find(".ModalTitle").find("b").html($(this).parent().parent().parent().find(".Name").find("span").html())
	$("#Modal").find("#Confirm").data("passport", $(this).parent().parent().parent().data("passport"))
	$("#Modal").css("display","flex");
});
/* ----------REMOVE---------- */
$(document).on("click","#Cancel",function(e){
	$("#Modal").css("display","none");
});
/* ----------CONFIRMREMOVE---------- */
$(document).on("click","#Confirm",function(e){
	$.post("http://service/Remove",JSON.stringify({ passport: $(this).data("passport") }));
	$("#Modal").css("display","none");
});
/* ----------ADD---------- */
$(document).on("click","#Save",function(e){
	if ($(".InputPass").val()) {
		$.post("http://service/Add",JSON.stringify({ passport: $(".InputPass").val() }));
		$(".InputPass").val("")
	}
});
/* ----------UP---------- */
$(document).on("click","#Up",function(e){
	$.post("http://service/Hierarchy",JSON.stringify({ passport: $(this).parent().parent().parent().data("passport"), mode: 'Promote' }));
});
/* ----------DOWN---------- */
$(document).on("click","#Down",function(e){
	$.post("http://service/Hierarchy",JSON.stringify({ passport: $(this).parent().parent().parent().data("passport"), mode: 'Demote' }));
});