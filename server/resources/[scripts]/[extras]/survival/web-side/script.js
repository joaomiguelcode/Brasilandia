// ============================================
// SURVIVAL SYSTEM
// ============================================

class SurvivalSystem {
	constructor() {
		this.screen = document.getElementById('survivalScreen');
		this.deathText = document.getElementById('deathText');
		this.statusIcon = document.getElementById('statusIcon');
		this.heartBeat = document.querySelector('.heart-beat');
		this.statusIndicator = document.querySelector('.status-indicator');
		this.pulseRings = document.querySelectorAll('.pulse-ring');
		
		// SVG do coração (padrão)
		this.heartSVG = '<svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M1.24264 8.24264L8 15L14.7574 8.24264C15.553 7.44699 16 6.36786 16 5.24264V5.05234C16 2.8143 14.1857 1 11.9477 1C10.7166 1 9.55233 1.55959 8.78331 2.52086L8 3.5L7.21669 2.52086C6.44767 1.55959 5.28338 1 4.05234 1C1.8143 1 0 2.8143 0 5.05234V5.24264C0 6.36786 0.44699 7.44699 1.24264 8.24264Z" fill="currentColor"/></svg>';
		
		// SVG do ícone de desistir
		this.giveUpSVG = '<svg height="200px" width="200px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 274.989 274.989" xml:space="preserve" fill="#dc2626"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><g><path style="fill:#dc2626;" d="M179.567,216.044c-5.609,11.237-8.425,16.844-14.02,19.641c-5.609,5.603-16.837,5.603-28.068,5.603 c-14.02,0-22.432,0-28.038-5.603c-5.624-2.797-8.432-8.404-14.03-19.641c0,0-2.816-2.781-2.816-5.611l-11.228,2.83l8.429,28.025 l16.827,14.049c5.598,14.022,16.835,19.652,30.855,19.652c5.609,0,14.039-2.836,16.835-5.63c5.623-2.816,11.232-8.415,14.04-14.022 l16.826-14.049l8.425-28.025l-11.222-2.83C179.567,213.263,179.567,216.044,179.567,216.044L179.567,216.044z M210.458,25.266 C190.794,8.448,168.355,0,137.48,0c-30.855,0-53.295,8.448-72.948,25.266C47.701,39.287,36.493,61.729,36.493,87.009 c0,22.422,2.787,39.249,8.4,47.7c8.426,14.008,14.04,22.428,14.04,28.032l2.797,22.43l39.28,19.663l8.432,16.84 c2.782,0,5.607,0,11.222,2.797c5.613,0,11.222,0,16.817,0c14.039,0,22.459-2.797,30.875-2.797l5.603-16.84l39.291-19.663 l2.796-22.43c2.818-5.604,2.818-8.426,2.818-11.216c14.018-19.648,19.633-42.094,19.633-64.517 C238.496,61.729,230.086,39.287,210.458,25.266L210.458,25.266z M95.412,162.742c-16.845,0-22.44-11.216-22.44-28.032 c0-8.451,0-16.867,5.595-19.652c2.802-5.626,8.434-8.415,16.845-8.415c16.812,0,25.252,8.415,25.252,25.237 C120.664,151.526,112.224,162.742,95.412,162.742L95.412,162.742z M145.921,193.597c-2.831,0-5.633,0-8.44-2.806 c-2.817,2.806-2.817,2.806-5.595,2.806c-2.836,0-5.609,0-8.425-2.806c-2.797,0-2.797-2.791-2.797-5.618 c0-2.776,2.797-8.387,5.613-11.198c5.609-5.621,8.387-11.232,11.204-16.837c2.807,5.604,8.44,11.216,11.231,16.837 c5.604,2.811,5.604,8.422,5.604,11.198C154.316,190.791,151.519,193.597,145.921,193.597L145.921,193.597z M182.385,162.742 c-16.837,0-25.263-11.216-25.263-28.032c0-16.867,8.426-28.068,25.263-28.068c8.409,0,14.018,2.79,16.826,8.415 c5.613,2.785,5.613,8.411,5.613,16.821C204.823,151.526,196.403,162.742,182.385,162.742L182.385,162.742z"></path></g></g></svg>';
		
		this.init();
	}
	
	init() {
		window.addEventListener('message', (event) => {
			this.handleMessage(event.data);
		});
	}
	
	handleMessage(data) {
		if (data.Action === 'Display') {
			if (data.Mode === 'block') {
				this.showScreen();
			} else if (data.Mode === 'none') {
				this.hideScreen();
			}
		} else if (data.Action === 'Message') {
			this.updateMessage(data.Message);
		}
	}
	
	showScreen() {
		this.screen.classList.add('active');
		// Resetar para o ícone do coração quando mostrar a tela
		this.changeIcon('heart');
	}

	hideScreen() {
		this.screen.classList.remove('active');
		this.deathText.innerHTML = '';
		// Resetar para o ícone do coração quando esconder a tela
		this.changeIcon('heart');
	}
	
	updateMessage(message) {
		if (!message) return;
		
		// Verificar se a mensagem indica que o timer acabou e pode pressionar E
		const canGiveUp = message.includes('Pressione') && message.includes('E') && message.includes('desistir');
		
		// Trocar o ícone se necessário
		if (canGiveUp) {
			this.changeIcon('giveUp');
		} else {
			this.changeIcon('heart');
		}
		
		// Destacar números (segundos) primeiro
		let processedMessage = message.replace(/(\d+)\s*(segundos?|s)/gi, '<span class="seconds-highlight">$1 $2</span>');
		
		// Processar tags <color> - se for E, usar command-highlight
		processedMessage = processedMessage.replace(/<color>(E)<\/color>/gi, '<span class="command-highlight">$1</span>');
		processedMessage = processedMessage.replace(/<color>(.*?)<\/color>/g, '<span class="highlight-text">$1</span>');
		
		this.deathText.innerHTML = processedMessage;
	}
	
	changeIcon(type) {
		if (!this.statusIcon) return;
		
		if (type === 'giveUp') {
			this.statusIcon.innerHTML = this.giveUpSVG;
			this.statusIcon.classList.remove('heart-icon');
			this.statusIcon.classList.add('give-up-icon');
			// Ocultar o ponto de batimento quando trocar para give-up
			if (this.heartBeat) {
				this.heartBeat.style.display = 'none';
			}
			// Ocultar os anéis pulsantes
			if (this.pulseRings && this.pulseRings.length > 0) {
				this.pulseRings.forEach(ring => {
					ring.style.display = 'none';
				});
			}
		} else {
			this.statusIcon.innerHTML = this.heartSVG;
			this.statusIcon.classList.remove('give-up-icon');
			this.statusIcon.classList.add('heart-icon');
			// Mostrar o ponto de batimento quando voltar para coração
			if (this.heartBeat) {
				this.heartBeat.style.display = 'block';
			}
			// Mostrar os anéis pulsantes
			if (this.pulseRings && this.pulseRings.length > 0) {
				this.pulseRings.forEach(ring => {
					ring.style.display = 'block';
				});
			}
		}
	}
}

if (document.readyState === 'loading') {
	document.addEventListener('DOMContentLoaded', () => {
		new SurvivalSystem();
	});
} else {
	new SurvivalSystem();
}
