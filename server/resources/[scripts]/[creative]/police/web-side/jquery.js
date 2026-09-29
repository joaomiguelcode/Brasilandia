let textEditor;
var selectPage = "Prender";
var reversePage = "Prender";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function () {
	window.onerror = err => err === "ResizeObserver loop limit exceeded" ? true : e(...arguments);
	functionPrender();
	window.addEventListener("message", function (event) {
		switch ( event["data"]["action"] ) {
			case "openSystem":
				$("#mainPage").css("display", "block");
				UpdatePoliceFines();
				break;
			case "closeSystem":
				$("#mainPage").css("display", "none");
				break;
			case "reloadPrison":
				limpar();
				functionPrender();
				break;
			case "reloadFine":
				functionMultar();
				break;
			case "reloadProcurados":
				functionProcurados();
				break;
			case "reloadPortes":
				functionPortes();
				break;
			case "reloadSearch":
				functionSearch(event["data"]["data"]);
				break;
		}
	});
	document.onkeyup = function (data) {
		if ( data["which"] === 27 ) {
			$.post("http://police/closeSystem");
		}
	};
	if ( localStorage.getItem("prenderTexto") ) localStorage.removeItem("prenderTexto");
});
/* ATIVAR .ACTIVE QUANDO A PÁGINA FOR SELECIONADA */
$(document).on("click", "#mainMenu .nav li", function () {
	let isActive = $(this).hasClass("active");
	$("#mainMenu .nav li").removeClass("active");
	if ( !isActive ) {
	$(this).addClass("active");
	reversePage = selectPage;
	$("#content").css("height", "540px");
	$("#content").css("margin", "30px 10px 30px 10px");
	}
});
const UpdatePoliceFines = () => {
	fetch("./police-fines.json")
	// fetch("https://api-distrito.fivem.com.br/api/police-fines?pagination[pageSize]=100")
		.then(response => response.json())
		.then(data => {
			const leftModal = document.getElementById("modalLeft");
			const rightModal = document.getElementById("modalRight");
			if ( !leftModal || !rightModal ) return;
			leftModal.innerHTML = "";
			rightModal.innerHTML = "";
			const headingInfractions = document.createElement("h3");
			headingInfractions.innerText = "INFRAÇÕES";
			headingInfractions.classList.add("colorH3");
			leftModal.appendChild(headingInfractions);
			const headingRobbery = document.createElement("h3");
			headingRobbery.innerText = "AÇÕES FECHADAS";
			headingRobbery.classList.add("colorH3");
			leftModal.appendChild(headingRobbery);
			const headingCrims = document.createElement("h3");
			headingCrims.innerText = "CRIMES";
			headingCrims.classList.add("colorH3");
			rightModal.appendChild(headingCrims);
			for ( const Fine of data.data ) {
				const { infracao, multa, fianca, apreender_veiculo, descricao, categoria } = Fine.attributes;
				const p = document.createElement("p");
				p.classList.add("colorCrimes");
				const input = document.createElement("input");
				input.type = "checkbox";
				input.name = "crime[]";
				input.value = `${infracao.toUpperCase()}|${multa}|${fianca}`;
				input.addEventListener("click", calcular);
				p.appendChild(input);
				const span = document.createElement("span");
				span.innerText = infracao.toUpperCase();
				p.appendChild(span);
				switch ( categoria ) {
					case "INFRAÇÕES":
						headingInfractions.after(p);
						break;
					case "CRIMES":
						headingCrims.after(p);
						break;
					case "AÇÕES FECHADAS":
						headingRobbery.after(p);
						break;
				}
			}
		}).catch(error => console.log("Error:", error));
};
/* ---------- BUSCA PRISÃO POR ID ---------- */
const functionVisualizarPrisao = (idprisao) => {
	if ( idprisao !== "" ) {
		$.post("http://police/checkPrisionId", JSON.stringify({ idprisao: parseInt(idprisao) }), (data) => {
			if ( data["result"][0] === true ) {
				$("#content").html(`
					<div id="titleContent">Prisão: ${data["result"][1]}</div>
					<div id="pageCenter">
	
						<div class="infoPrisao">
							<b>Passaporte:</b> ${data["result"][2]["nuser_id"]}<br>
							<b>Serviços:</b> ${data["result"][2]["services"]}<br>
							<b>Multas:</b> ${data["result"][2]["fines"]}<br>
							<br>
							<b>Oficial responsável:</b> ${data["result"][2]["police"]}<br>
							<b>Demais oficiais:</b> ${(data["result"][2]["cops"] != null && data["result"][2]["cops"] != "") ? data["result"][2]["cops"] : "Sem outros oficiais"}<br>
							<b>Associação criminosa:</b> ${(data["result"][2]["association"] != null && data["result"][2]["association"] != "") ? data["result"][2]["association"] : "Sem associação"}<br>
							<b>Material genético:</b> ${data["result"][2]["residual"] == 0 ? "Não coletado" : "Coletado"}<br>
							<br>
							<b>Data:</b> ${data["result"][2]["date"]}<br>
							<b>Motivos:</b> ${data["result"][2]["text"]}<br>
						</div>
						<div class="infoPrisaoFoto">
							<img class="foto" src="${data["result"][2]["url"]}" />
						</div>
					</div>
				`);
			} else {
				$("#content").html(`
					<div id="titleContent">Prisão</div>
					Não conseguimos carregar as informações desta prisão.
				`);
			}
		});
	}
};
/* ---------- BUSCA PROCURADO POR ID ---------- */
const functionVisualizarProcurado = (idprocurado) => {
	if ( idprocurado !== "" ) {
		$.post("http://police/checkWarrantId", JSON.stringify({ idprocurado: parseInt(idprocurado) }), (data) => {
			if ( data["result"][0] === true ) {
				$("#content").html(`
					<div id="titleContent">Informações do procurado: ${data["result"][1]}</div>
					<div id="pageCenter">
	
						<div class="infoBox">
							<b>Passaporte:</b> ${data["result"][2]["user_id"]}<br>
							<b>Nome:</b> ${data["result"][2]["identity"]}<br>
							<b>Status:</b> ${data["result"][2]["status"]}<br>
							<b>Motivo:</b> ${data["result"][2]["reason"]}<br>
							<b>Oficial:</b> ${data["result"][2]["nidentity"]}<br>
							<b>Data de expedição:</b> ${data["result"][2]["timeStamp"]}<br>
						</div>
						<label class="buttonVoltar" onclick="functionProcurados();">Voltar</label>

					</div>
				`);
			} else {
				$("#content").html(`
					<div id="titleContent">Procurados</div>
					Não conseguimos carregar as informações deste procurado.
				`);
			}
		});
	}
};
/* ---------- BUSCA DE INFORMAÇÃO DO CIDADÃO POR ID ---------- */
const functionSearch = (passaporte) => {
	if ( passaporte !== "" ) {
		$.post("http://police/searchUser", JSON.stringify({ passaporte: parseInt(passaporte) }), (data) => {
			if ( data["result"][0] === true ) {
				$("#content").html(`
					<div id="titleContent">${data["result"][1]}</div>
					<div id="pageLeftSearch">
						<div class="searchBox">
							<b>Passaporte:</b> ${formatarNumero(passaporte)}<br>
							<b>Nome:</b> ${data["result"][1]}<br>
							<b>Telefone:</b> ${data["result"][2]}<br>
							<b>Multas:</b> $${data["result"][3]}<br>
						</div>
						${data["result"][6].map((data) => (`
						
							<div class="searchBox" style="margin-top: 5px;">
								<div class="fineSeachTitle3">
									<span style="width: 280px; float: left;"><b>Porte:</b> ${data["portType"]}</span>
									<span style="width: 280px; float: left;"><b>Serial:</b> ${data["serial"]}</span>
								</div>
							</div>
						`)).join("")}
						${data["result"][4].map((data) => (`
							<div class="recordBox">
								<div class="fineSeachTitle">
									<span style="width: 180px; float: left;"><b>Policial:</b> ${data["police"]}</span>
									<span style="width: 130px; float: left;"><b>Serviços:</b> ${formatarNumero(data["services"])}</span>
									<span style="width: 130px; float: left;"><b>Multa:</b> $${formatarNumero(data["fines"])}</span>
									<span style="width: 130px; float: left;">${data["date"]}</span>
									<span style="width: 55px; float: right; text-align: right;">
										<button id="buttonPrisao${data["id"]}" class="buttonPrisao"><i class="fa fa-eye"></i></button>
									</span>
								</div>
								<b>Motivo:</b><br> - ${data["text"]}
							</div>
						`)).join("")}
					</div>

					<div id="pageRight">
						<h2>OBSERVAÇÕES:</h2>
						<b>1:</b> Todas as informações encontradas são de uso exclusivo policial, tudo que for encontrado na mesma são informações em tempo real.<br><br>
						<b>2:</b> Nunca forneça qualquer informação dessa página para outra pessoa, apenas se a mesma for o proprietário ou o advogado do mesmo.
					</div>
				`);
			} else {
				$("#content").html(`
					<div id="titleContent">RESULTADO</div>
					Não foi encontrado informações sobre o passaporte procurado.
				`);
			}
		});
	}
};
const displayGoogleDoc = (doc_id) => {
	$("#content").html(`<iframe src="https://docs.google.com/document/d/${doc_id}/preview" style="width: 100%;height: 95%;border: none"></iframe>`);
};
/* ---------- CHAMA FUNÇÃO DE BUSCAR INFO CIDADÃO PASSANDO PARAMETRO ID ---------- */
$(document).on("click", ".buttonSearch", function (e) {
	const passaporte = $("#searchPassaporte").val();
	functionSearch(passaporte);
});
/* ---------- CHAMA FUNÇÃO DE PRISÃO PASSANDO PARAMETRO ID  --------- */
$(document).on("click", ".buttonPrisao", function (e) {
	e.preventDefault();
	const idpri = $(this).attr("id");
	const idprisao = idpri.replace("buttonPrisao", "");
	functionVisualizarPrisao(idprisao);
});
/* ---------- CHAMA FUNÇÃO DE PROCURADO PASSANDO PARAMETRO ID --------- */
$(document).on("click", ".buttonProcurado", function (e) {
	e.preventDefault();
	const idprocurado = $(this).attr("id");
	const strSemId = idprocurado.replace("buttonProcurado", "");
	functionVisualizarProcurado(strSemId);
});
/* ---------- CHAMA FUNÇÃO DE EXCLUIR PROCURADO PASSANDO PARAMETRO ID ---------- */
$(document).on("click", ".buttonExcluirProcurado", function (e) {
	e.preventDefault();
	const idexprocurado = $(this).attr("id");
	const excluirpro = idexprocurado.replace("buttonExcluirProcurado", "");
	$.post("http://police/deleteWarrant", JSON.stringify({ excluirpro: excluirpro }));
});
/* ---------- CHAMA FUNÇÃO DE EXCLUIR PORTE PASSANDO PARAMETRO ID ---------- */
$(document).on("click", ".buttonExcluirPorte", function (e) {
	e.preventDefault();
	const idexporte = $(this).attr("id");
	const excluirporte = idexporte.replace("buttonExcluirPorte", "");
	$.post("http://police/deletePort", JSON.stringify({ excluirporte: excluirporte }));
});
/* ---------- CHAMA FUNÇÃO DE EDITAR PORTE PASSANDO PARAMETRO ID --------- */
$(document).on("click", ".buttoneditPort", function (e) {
	e.preventDefault();
	const ideditporte = $(this).attr("id");
	if ( !ideditporte ) return;
	const idedporte = ideditporte.replace("buttoneditPort", "");
	functionEditPorte(idedporte);
});
/* ----------CLICKBUY---------- */
$(document).on("click", "#policeUpdate", function (e) {
	$.post("http://police/updatePolice", JSON.stringify({ passaporte: e["target"]["dataset"]["id"] }));
});

/* ---------------------------------------------------------------------------------------------------------------- */
function calcular() {
	let Multa = 0;
	let Fianca = 0;
	/* Crimes */
	let crimes = document.getElementsByName("crime[]");
	for ( let i = 0; i < crimes.length; i++ ) {
		if ( crimes[i].checked ) {
			const valores_crime = crimes[i].value.split("|");
			Multa += parseInt(valores_crime[1]);
			Fianca += parseInt(valores_crime[2]);
		}
	}
	/* TENTATIVA DE HOMICIDIO */
	const drogas = parseInt(document.getElementById("drogas").value);
	if ( drogas > 0 ) {
		Multa += drogas * 1000;
		Fianca += drogas * 25;
	}
	/* TENTATIVA DE HOMICIDIO A OFICIAL */
	const sujo = parseInt(document.getElementById("sujo").value);
	if ( sujo > 0 ) {
		Multa += sujo * 1500;
		Fianca += sujo * 35;
	}
	/* HOMICIDIO */
	const multas = parseInt(document.getElementById("multas").value);
	if ( multas > 0 ) {
		Multa += multas * 1500;
		Fianca += multas * 30;
	}
	/* HOMICIDIO A OFICIAL */
	const municao = parseInt(document.getElementById("muniçao").value);
	if ( municao > 0 ) {
		Multa += municao * 2000;
		Fianca += municao * 40;
	}
	const multa_txt = document.getElementById("prenderMultas");
	multa_txt.value = Multa;
	const fianca_txt = document.getElementById("prenderServices");
	fianca_txt.value = Fianca;
	/* Crimes */
	const crimess = document.getElementsByName("crime[]");
	let crimeid = "";
	let crimeidd = "";
	for ( let i = 0; i < crimess.length; i++ ) {
		if ( crimess[i].checked ) {
			const valores_crimee = crimess[i].value.split("|");
			crimeid = valores_crimee[0];
			crimeidd = crimeid + ", " + crimeidd;
		}
	}
	crimes = crimeidd;
	const crimes_txt = document.getElementById("prenderTexto");
	crimes_txt.value = crimes;
	let textContent = localStorage.getItem("prenderTexto") ?? "";
	const criminalList = textContent.match(/<p data-criminal="true">(.*?)<\/p>/);
	if ( criminalList ) textContent = textContent.slice(0, criminalList.index);
	textContent += `<p data-criminal="true">${crimes}</p>`;
	if ( textEditor ) textEditor.setData(textContent);
}

function limpar() {
	var crimes = document.getElementsByName("crime[]");
	for ( var i = 0; i < crimes.length; i++ ) {
		crimes[i].checked = false;
	}
	var drogas = document.getElementById("drogas");
	drogas.value = 0;
	var sujo = document.getElementById("sujo");
	sujo.value = 0;
	var sujo = document.getElementById("multas");
	sujo.value = 0;
	var sujo = document.getElementById("muniçao");
	sujo.value = 0;
	document.getElementById("prenderMultas").value = "0";
	document.getElementById("prenderServices").value = "0";
	document.getElementById("prenderTexto").value = "";
	localStorage.removeItem("prenderMultas");
}

const functionPrender = () => {
	selectPage = "Prender";
	$("#content").html(`
		<div id="titleContent">PRENDER</div>
		<div id="pageLeft">
			<input class="inputTentativas" id="prenderPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."/>
			<input class="inputTentativas2" id="prenderUrl" type="text" value="" placeholder="Url da foto."/>

			<label class="buttonCrimes" for="modal-1">Adicionar crimes</label>
			
			<div style="display: inline-block">
				<input class="inputTentativas" id="prenderServices" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Serviços."/>
				<input class="inputTentativas2" id="prenderMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."/>
			</div>
			<div class="textareaPrison" id="prenderTexto"></div>
			<div style="display: inline-block">
				<select class="inputPrison" name="prenderMaterial" id="prenderMaterial"><option value="Não">Sem coleta de material genético.</option><option value="Sim">Material genético coletado.</option></select>
				<input class="inputPrison" id="prenderAssociacao" type="text" value="" placeholder="Associação (Ex: 1, 2, 3)."/>
			</div>
			<input class="inputPrison" id="prenderPenais" type="text" value="" placeholder="Oficiais Penais (Ex: 1, 2, 3)."/>
			<input class="inputPrison" id="prenderMilitares" type="text" value="" placeholder="Demais policiais (Ex: 1, 2, 3)."/>
			<button class="buttonPrison">Prender</button>
			<button class="buttonPrisonLimpar" onclick="limpar()">Limpar</button>
			
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
			<b>3:</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.
		</div>
	`);
	setTimeout(() => {
		InlineEditor.create(document.querySelector("#prenderTexto"), {
			placeholder:   "Todas as informações dos crimes.",
			htmlSupport:   { allow: [{ name: "p", attributes: { "data-criminal": true } }] },
			removePlugins: ["Markdown"]
		}).then(editor => {
			textEditor = editor;
			let previousData = localStorage.getItem("prenderTexto");
			if ( previousData ) editor.setData(previousData);
			editor.model.document.on("change:data", () => localStorage.setItem("prenderTexto", editor.getData()));
		}).catch(console.error);
	}, 100);
};
/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA CLIENTE DO INSERIR PRISÃO ---------- */
$(document).on("click", ".buttonPrison", function (e) {
	const passaporte = $("#prenderPassaporte").val();
	const servicos = $("#prenderServices").val();
	const url = $("#prenderUrl").val();
	const multas = $("#prenderMultas").val();
	const texto = localStorage.getItem("prenderTexto") || "";
	const material = $("#prenderMaterial").val();
	const associacao = $("#prenderAssociacao").val();
	const penais = $("#prenderPenais").val();
	const militares = $("#prenderMilitares").val();
	if ( texto.includes("script") ) {
		localStorage.removeItem("prenderTexto");
		textEditor?.setData("");
		return;
	}
	if ( passaporte !== "" && servicos !== "" && multas !== "" && texto !== "" && url !== "" ) {
		$.post("http://police/initPrison", JSON.stringify({
			passaporte: parseInt(passaporte),
			servicos:   parseInt(servicos),
			multas:     parseInt(multas),
			texto:      texto,
			associacao: associacao,
			material:   material,
			url:        url,
			penais:     penais,
			militares:  militares
		}));
	}
});
/* --------- LISTAR PORTES ---------- */
const functionPortes = () => {
	selectPage = "Portes";
	$.post("http://police/searchPort", JSON.stringify({ type: "consultar" }), (data) => {
		if ( data["result"][0] === true ) {
			$("#content").html(`
				<div id="titleContent">Portes</div>
				<div id="pageCenter">
					<label class="buttonAddPortes" onclick="functionAddPorte();">Adicionar Porte</label>
					${data["result"][1].map((data) => (`
						<div class="centerBox">
							
							<div class="fineSeachTitle3" style="display: inline-block;">
								<span style="width: 480px; float: left;"><b>Passaporte:</b> ${data["user_id"]}</span>
								<span style="width: 380px; float: left;"><b>Nome:</b> ${data["identity"]}</span>
								<span style="width: 100px; float: right;">
									<button id="buttoneditPort${data["portId"]}" class="buttoneditPort"><i class="fa fa-pencil"></i></button>
									<button id="buttonExcluirPorte${data["portId"]}" class="buttonExcluirPorte"><i class="fa fa-trash"></i></button>
								</span>
								<span style="width: 480px; float: left;"><b>Tipo de porte:</b> ${data["portType"]}</span>
								<span style="width: 480px; float: left;"><b>Serial:</b> ${data["serial"]}</span>
								<span style="width: 480px; float: left;"><b>Oficial:</b> ${data["nidentity"]}</span>
								<span style="width: 480px; float: left;"><b>Data:</b> ${data["date"]}</span>
					
							</div>
						</div>
					`)).join("")}
				</div>
			`);
		} else {
			$("#content").html(`
				<div id="titleContent">Portes</div>
				Não foi encontrado informações sobre portes.
				<label class="buttonAddPortes" onclick="functionAddPorte();">Adicionar Porte</label>
			`);
		}
	});
};
/* ---------- FUNÇÃO DO EDITAR PORTE TRAZENDO AS INFORMAÇÕES PASSANDO PARAMETRO ID ---------- */
const functionEditPorte = (idedporte) => {
	if ( idedporte !== "" ) {
		$.post("http://police/getPortById", JSON.stringify({ idedporte: parseInt(idedporte) }), (data) => {
			if ( data["result"][0] === true ) {
				$("#content").html(`
					<div id="titleContent">Editar Porte</div>
					<div id="pageCenter">
						<input type="hidden" class="inputFormCenter" id="porteId" value="${data["result"][1]["portId"]}"></input>
						<input class="inputFormCenter" id="portePassaporte" value="${data["result"][1]["user_id"]}" placeholder="Passaporte"></input>
						<input class="inputFormCenter" id="porteNome" value="${data["result"][1]["identity"]}" placeholder="Nome completo"></input>
						<input class="inputFormCenter2" id="porteSerial" value="${data["result"][1]["serial"]}" placeholder="Serial de arma"></input>
						<input class="inputFormCenter2" id="porteStatus" value="${data["result"][1]["portType"]}" placeholder="Tipo de porte"></input>
						<input class="inputFormCenter3" id="porteExame" value="${data["result"][1]["exam"]}" placeholder="Resultado toxicológico"></input>
						<button class="buttonVoltar" onclick="functionPortes();">Voltar</button>
						<button class="buttonEditarPorte">Editar</button>
					</div>
				`);
			} else {
				$("#content").html(`
					<div id="titleContent">RESULTADO</div>
					Não foi encontrado informações sobre o passaporte procurado.
				`);
			}
		});
	}
};
/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA EDITAR PRISÃO ---------- */
$(document).on("click", ".buttonEditarPorte", function (e) {
	const id = $("#porteId").val();
	const passaporte = $("#portePassaporte").val();
	const nome = $("#porteNome").val();
	const serial = $("#porteSerial").val();
	const status = $("#porteStatus").val();
	const exame = $("#porteExame").val();
	if ( passaporte !== "" && id !== "" && nome !== "" && serial !== "" && status !== "" && exame !== "" ) {
		$.post("http://police/editPort", JSON.stringify({
			id:         id,
			passaporte: parseInt(passaporte),
			nome:       nome,
			serial:     serial,
			status:     status,
			exame:      exame
		}));
	}
});
/* ---------- CHAMANDO PAGINA DE INSERIR PORTE ---------- */
const functionAddPorte = () => {
	selectPage = "Porte";
	$("#content").html(`
		<div id="titleContent">Adicionar Porte</div>
		<div id="pageCenter">
			<input class="inputFormCenter" id="portePassaporte" value="" placeholder="Passaporte"></input>
			<input class="inputFormCenter" id="porteNome" value="" placeholder="Nome completo"></input>
			<input class="inputFormCenter2" id="porteSerial" value="" placeholder="Serial de arma"></input>
			<input class="inputFormCenter2" id="porteStatus" value="" placeholder="Tipo de porte"></input>
			<input class="inputFormCenter3" id="porteExame" value="" placeholder="Resultado toxicológico"></input>
			<button class="buttonAddPorte">Adicionar</button>
		</div>
	`);
};
/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA INSERIR PORTE ---------- */
$(document).on("click", ".buttonAddPorte", function (e) {
	const passaporte = $("#portePassaporte").val();
	const nome = $("#porteNome").val();
	const serial = $("#porteSerial").val();
	const status = $("#porteStatus").val();
	const exame = $("#porteExame").val();
	if ( passaporte !== "" && nome !== "" && serial !== "" && status !== "" && exame !== "" ) {
		$.post("http://police/givePort", JSON.stringify({
			passaporte: parseInt(passaporte),
			nome:       nome,
			serial:     serial,
			status:     status,
			exame:      exame
		}));
	}
});
/* --------- LISTAR PROCURADOS ---------- */
const functionProcurados = () => {
	selectPage = "Procurados";
	$.post("http://police/getWarrants", JSON.stringify({ type: "consultar" }), (data) => {
		if ( data["result"][0] == true ) {
			$("#content").html(`
				<div id="titleContent">Procurados</div>
				<div id="pageCenter">
					<label class="buttonAddProcurado" onclick="functionAddProcurado();">Adicionar Procurado</label>
					${data["result"][1].map((data) => (`
						<div class="centerBox">
							
							<div class="fineSeachTitle2" style="display: inline-block;">
								<span style="width: 320px; float: left;"><b>Passaporte:</b> ${data["user_id"]}</span>
								<span style="width: 320px; float: left;"><b>Nome:</b> ${data["identity"]}</span>
								<span style="width: 320px; float: left;"><b>Status:</b> ${data["status"]}</span>
								<span style="width: 320px; float: left;"><b>Oficial:</b> ${data["nidentity"]}</span>
								<span style="width: 320px; float: left;"><b>Data:</b> ${data["timeStamp"]}</span>
								<span style="width: 320px; float: right;">
								<button id="buttonProcurado${data["id"]}" class="buttonProcurado"><i class="fa fa-eye"></i></button>
								<button id="buttonExcluirProcurado${data["id"]}" class="buttonExcluirProcurado"><i class="fa fa-trash"></i></button>
								</span>
							</div>
							<br />
							<div style="display: inline-block;">
								<b>Motivo:</b><br> - ${data["reason"]}
							</div>
						</div>
					`)).join("")}
				</div>
			`);
		} else {
			$("#content").html(`
				<div id="titleContent">Procurados</div>
				Não foi encontrado informações sobre procurados.
				<label class="buttonAddProcurado" onclick="functionAddProcurado();">Adicionar Procurado</label>
			`);
		}
	});
};
/* ---------- CHAMANDO PAGINA DE INSERIR PROCURADO ---------- */
const functionAddProcurado = () => {
	selectPage = "Procurado";
	$("#content").html(`
		<div id="titleContent">Adicionar Procurado</div>
		<div id="pageCenter">
			<input class="inputFormCenter" id="procuradoPassaporte" value="" placeholder="Passaporte."></input>
			<input class="inputFormCenter" id="procuradoNome" value="" placeholder="Nome."></input>
			<textarea class="textareaFormCenter" id="procuradoTexto" maxlength="500" placeholder="Todas as informações."></textarea>
			<button class="buttonAddP">Adicionar</button>
		</div>
	`);
};
/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA INSERIR PROCURADO ---------- */
$(document).on("click", ".buttonAddP", function (e) {
	const passaporte = $("#procuradoPassaporte").val();
	const nome = $("#procuradoNome").val();
	const texto = $("#procuradoTexto").val();
	if ( passaporte !== "" && nome !== "" && texto !== "" ) {
		$.post("http://police/setWarrant", JSON.stringify({
			passaporte: parseInt(passaporte),
			nome:       nome,
			texto:      texto
		}));
	}
});
/* ---------- CHAMANDO PAGINA DE INSERIR MULTA ---------- */
const functionMultar = () => {
	selectPage = "Multar";
	// add depois:
	// <input style="margin-top: 8px;" class="inputFine" id="multarCnh" type="number" onKeyPress="if(this.value.length==2) return false;" value="" placeholder="Pontos da CNH a retirar. (Em branco não retira)"></input>
	$("#content").html(`
		<div id="titleContent">MULTAR</div>
		<div id="pageLeft">
			<input class="inputFine" id="multarPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputFine2" id="multarMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaFine" id="multarTexto" maxlength="500" value="" placeholder="Todas as informações da multa."></textarea>
			<button class="buttonFine">Multar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com a multa, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
		</div>
	`);
};
const functionRegisterBoletim = () => {
	const victimId = document.getElementById("boletim-victim-id");
	const victimName = document.getElementById("boletim-victim-name");
	if ( victimId?.value !== "" || victimName?.value !== "" ) {
		const boletimText = textEditor.getData();
		if ( boletimText !== "" ) {
			$.post("http://police/addReport", JSON.stringify({
				victim_id:     victimId?.value,
				victim_name:   victimName?.value,
				victim_report: boletimText
			})).then(() => {
				functionBoletins();
			})
			localStorage.setItem("boletimTexto", "");
		}
	}
};
const functionAddBoletim = () => {
	selectPage = "Porte";
	$("#content").html(`
		<div id="titleContent">Registrar novo Boletim</div>
		<div id="pageLeft">
			<input class="inputFine" id="boletim-victim-id" type="number" value="" placeholder="Passaporte da vítima"/>
			<input class="inputFine2" id="boletim-victim-name" type="text" value="" placeholder="Nome da vitima"/>
			<div class="textareaBoletim" id="boletimTexto"></div>
			<button class="buttonAddPortes" style="float: left" onclick="functionBoletins()">Voltar</button>
			<button class="buttonReport" onclick="functionRegisterBoletim()">Registrar</button>
		</div>
	`);
	setTimeout(() => {
		InlineEditor.create(document.querySelector("#boletimTexto"), {
			placeholder:   "Descreva o ocorrido.",
			removePlugins: ["Markdown"]
		}).then(editor => {
			textEditor = editor;
			let previousData = localStorage.getItem("boletimTexto");
			if ( previousData ) editor.setData(previousData);
			editor.model.document.on("change:data", () => localStorage.setItem("boletimTexto", editor.getData()));
		}).catch(console.error);
	}, 100);
};
const functionBoletimSolved = (id) => {
	const reportElem = document.getElementById(`report-status-${id}`);
	const reportCheckElem = document.getElementById(`report-check-${id}`);
	if ( reportElem && reportCheckElem ) {
		reportElem.style.color = `#2DC937`;
		reportElem.innerText = "Sim";
		const reportDelElem = document.getElementById(`report-delete-${id}`);
		if ( reportDelElem ) {
			reportDelElem.style.visibility = "hidden";
			setTimeout(() => {
				reportDelElem.style.visibility = "visible";
			}, 3000);
		}
		reportCheckElem.remove();
		$.post("http://police/setReportSolved", JSON.stringify({ id }));
	}
};
const functionBoletimDelete = (id) => {
	const reportDelElem = document.getElementById(`report-${id}`);
	if ( reportDelElem ) {
		reportDelElem.remove();
		$.post("http://police/setReportRemoved", JSON.stringify({ id }));
	}
};

// Função para formatar a data no formato "YYYY-MM-DD"
function formatarData(date) {
	const ano = date.getFullYear();
	const mes = String(date.getMonth() + 1).padStart(2, "0");
	const dia = String(date.getDate()).padStart(2, "0");
	return `${ano}-${mes}-${dia}`;
}
const functionBoletins = () => {
	$.post("http://police/getReports", JSON.stringify({ type: "consultar" }), (data) => {
		$("#content").html(`
			<div id="titleContent">BOLETIM DE OCORRÊNCIA</div>
			<div id="pageCenter">
				<label class="buttonAddPortes" onclick="functionAddBoletim()">Registrar Boletim</label>
				${data.map(item => (`<div class="centerBox" id="report-${item.id}">
					<div class="fineSeachTitle3" style="display: inline-block;">
						<span style="width: 480px; float: left;"><b>Passaporte:</b>${item.victim_id} </span>
						<span style="width: 380px; float: left;"><b>Oficial Resp:</b> ${item.police_name}</span>
						<span style="width: 100px; float: right;">
							${!item.solved ? `<button onclick="functionBoletimSolved(${item.id})" id="report-check-${item.id}" style="background-color: transparent;border: none;cursor: pointer;"><i class="fa fa-check"></i></button>` : ""}
							<button id="report-delete-${item.id}" onclick="functionBoletimDelete(${item.id})" style="background-color: transparent;border: none;cursor: pointer;"><i class="fa fa-trash"></i></button>
						</span>
						<span style="width: 480px; float: left;"><b>Nome:</b> ${item.victim_name}</span>
						<span style="width: 480px; float: left;"><b>Data:</b> ${item.created_at}</span>
						<span style="width: 480px; float: left;"><b>Ocorrido:</b> ${item.victim_report}</span>
						<span style="width: 480px; float: left;"><b>Ult. Atualização:</b> ${item.updated_at}</span>
						<span style="width: 480px; float: left;"><b>Resolvido:</b> ${item.solved ? `<span style="color: #2dc937">Sim</span>` : `<span style="color: #cc3232" id="report-status-${item.id}">Não</span>`}</span>
					</div>
				</div>`))}
			</div>
		`);
	});
};
/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA INSERIR MULTA ---------- */
$(document).on("click", ".buttonFine", function (e) {
	const passaporte = $("#multarPassaporte").val();
	const multas = $("#multarMultas").val();
	const texto = $("#multarTexto").val();
	//const cnh = $('#multarCnh').val()
	if ( passaporte !== "" && multas !== "" && texto !== "" ) {
		$.post("http://police/initFine", JSON.stringify({
			passaporte: parseInt(passaporte),
			multas:     parseInt(multas),
			texto:      texto,
			/*cnh: cnh,*/
			cnh: 0
		}));
	}
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	n = n.toString();
	let r = "";
	let x = 0;
	for ( let i = n.length; i > 0; i-- ) {
		r += n.substr(i - 1, 1) + (x === 2 && i !== 1 ? "." : "");
		x = x === 2 ? 0 : x + 1;
	}
	return r.split("").reverse().join("");
};