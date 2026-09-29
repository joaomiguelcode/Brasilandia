$(document).ready(function(){
	var notifyNumber = 0;

	// Demonstração automática em navegadores fora do FiveM
	if (window.location.protocol === "file:" || !window.invokeNative){
		setTimeout(function(){
			window.postMessage({ notify: true, css: "verde", mensagem: "Ação realizada com <b>sucesso</b>!", timer: 5000 }, "*");
			setTimeout(function(){
				window.postMessage({ notify: true, css: "vermelho", mensagem: "Você não possui <b>permissão</b> para isso.", timer: 5000 }, "*");
			}, 500);
			setTimeout(function(){
				window.postMessage({ notify: true, css: "azul", mensagem: "Novo <b>chamado de emergência</b> recebido.", timer: 5000 }, "*");
			}, 1000);
			setTimeout(function(){
				window.postMessage({ notify: true, css: "locked", mensagem: "Veículo <b>trancado</b> com sucesso.", timer: 4000 }, "*");
			}, 1500);
			setTimeout(function(){
				window.postMessage({ notify: true, css: "hunger", mensagem: "Você está começando a sentir <b>fome</b>.", timer: 4500 }, "*");
			}, 2000);
		}, 300);
	}

	window.addEventListener("message",function(event){
		if (event["data"]["notify"] !== undefined){
			var current = ++notifyNumber;
			var duration = event["data"]["timer"] || 3500;
			var html = `<div id="${event.data.css}" class="notify-card" data-id="${current}">
				<div class="notify-icon-glow"></div>
				<div class="notify-text">${event["data"]["mensagem"]}</div>
				<div class="timer-bar">
					<div class="timer-bar-fill timer-${current}"></div>
				</div>
			</div>`;

			var $el = $(html);
			$el.appendTo("#notifications");

			setTimeout(function(){
				$(`.timer-${current}`).css({
					"transition": `width ${duration}ms linear`,
					"width": "0%"
				});
			}, 30);

			setTimeout(function(){
				$el.addClass("leaving");
				setTimeout(function(){
					$el.remove();
				}, 350);
			}, duration);
		}

		if (event["data"]["shortcuts"] !== undefined){
			if (event["data"]["shortcuts"] == true){
				if ($("#Shortcuts").css("display") === "none"){
					$("#Shortcuts").css("display","flex");
				}

				if (event["data"]["shorts"]){
					for (var i = 1; i <= 5; i++){
						var item = event["data"]["shorts"][i];
						if (item && item !== ""){
							$(`.Shorts-${i}`)
								.css("background-image", `url(nui://inventory/web-side/images/${item}.png)`)
								.addClass("populated");
						} else {
							$(`.Shorts-${i}`)
								.css("background-image", "none")
								.removeClass("populated");
						}
					}
				}
			} else {
				if ($("#Shortcuts").css("display") === "flex"){
					$("#Shortcuts").css("display","none");
				}
			}
		}
	});
});