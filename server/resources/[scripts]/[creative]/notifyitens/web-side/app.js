$(document).ready(function () {
	window.addEventListener("message", function (event) {
		if (!event.data || !event.data.item) return;

		var mode = (event.data.mode || "").toLowerCase();
		var html = `<div class="item ${mode}">
			<div class="top">
				<div class="itemWeight">${event.data.mode}</div>
				<div class="itemAmount">${event.data.amount}x</div>
			</div>
			<img src="nui://inventory/web-side/images/${event.data.item}.png">
			<div class="nameItem">${event.data.name}</div>
		</div>`;

		$(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500, function () {
			$(this).remove();
		});
	});
});