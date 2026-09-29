// ============================================
// DYNAMIC MENU SYSTEM - MODERN VERSION
// ============================================

class DynamicMenu {
	constructor() {
		this.buttons = [];
		this.submenus = [];
		this.normalButtons = [];
		this.currentMenu = 'main';
		this.menuStack = [];
		
		this.menuWrapper = document.getElementById('menuWrapper');
		this.menuContent = document.getElementById('menuContent');
		this.identityWrapper = document.getElementById('identityWrapper');
		this.identityElems = {
			title: document.getElementById('identityTitle'),
			name: document.getElementById('identityName'),
			id: document.getElementById('identityId'),
			regRow: document.getElementById('identityRegRow'),
			reg: document.getElementById('identityReg'),
			phoneRow: document.getElementById('identityPhoneRow'),
			phone: document.getElementById('identityPhone')
		};
		this.identityTimer = null;
		this.closing = false;
		this.closeTimer = null;
		
		this.icons = {
			"Ponto Eletrônico": './public/images/clock.svg',
			"Animações Policiais": './public/images/anim.svg',
			"Modo Patrulhamento": './public/images/car.svg',
			"Controladora Giroflex": './public/images/siren.svg',
			"Propriedade": './public/images/house.svg',
			"Tablet": './public/images/info.svg',
			"Uniformes": './public/images/clothes.svg',
			"Fardamentos": './public/images/clothes.svg',
			"Opções staff": './public/images/star.svg',
			"Jogador": './public/images/avatar.svg',
			"Roupas": './public/images/clothes.svg',
			"Armário de Roupas": './public/images/clothes.svg',
			"Armário": './public/images/clothes.svg',
			"Armário Extra": './public/images/clothes.svg',
			"Gerenciar Outfits": './public/images/clothes.svg',
			"Outfits Salvos": './public/images/clothes.svg',
			"Experiência": './public/images/star.svg',
			"hypex_misc_cloackroom": './public/images/star.svg',
			"Serviços": './public/images/info.svg',
			"Documentos": './public/images/documents.svg',
			"Outros": './public/images/info.svg',
			"Portas": './public/images/doors.svg',
			"Veículo": './public/images/car.svg'
		};
		
		this.init();
	}
	
	init() {
		// Listener para tecla ESC
		document.addEventListener('keyup', (e) => {
			if (e.key === 'Escape' || e.keyCode === 27) {
				this.closeMenu();
				this.hideIdentity();
			}
		});
		
		// Listener para mensagens NUI
		window.addEventListener('message', (event) => {
			this.handleMessage(event.data);
		});
		
		// Delegation para cliques nos botões
		this.menuContent.addEventListener('click', (e) => {
			const button = e.target.closest('.menu-button');
			if (!button) return;
			
			if (button.classList.contains('submenu-button')) {
				this.openSubmenu(button.dataset.menuId);
			} else if (button.id === 'backButton') {
				this.goBack();
			} else {
				this.handleButtonClick(button);
			}
		});
	}
	
	handleMessage(data) {
		if (data.addbutton === true) {
			this.abortCloseIfPending();
			this.addButton(data);
		} else if (data.addmenu === true) {
			this.abortCloseIfPending();
			this.addSubmenu(data);
		} else if (data.close === true) {
			this.scheduleClose();
		} else if (data.show === true) {
			this.abortCloseIfPending();
			this.showMenu();
		} else if (data.showIdentity === true || data.identity === 'show') {
			this.showIdentity(data);
		} else if (data.hideIdentity === true || data.identity === 'hide') {
			this.hideIdentity();
		}
	}
	
	createButton(data, isNormal = false) {
		const button = document.createElement('div');
		button.className = 'menu-button';
		
		if (data.title === "Guardar" || data.title === "Voltar") {
			button.classList.add('warning');
		}
		
		if (!isNormal && data.id) {
			button.id = data.id;
		} else if (isNormal) {
			button.dataset.normalButton = 'true';
		}
		
		if (data.trigger) {
			button.dataset.trigger = data.trigger;
			button.dataset.param = data.par || '';
			button.dataset.server = data.server || 'false';
		}
		
		// Ícone
		const iconSrc = this.icons[data.title] || null;
		const iconHtml = iconSrc 
			? `<div class="button-icon"><img src="${iconSrc}" alt="${data.title}"></div>`
			: '';
		
		// Texto
		const textHtml = `
			<div class="button-text">
				<div class="button-title">${this.escapeHtml(data.title)}</div>
				<div class="button-description">${this.escapeHtml(data.description || '')}</div>
			</div>
		`;
		
		// Seta
		const arrowHtml = `
			<div class="button-arrow">
				<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M6 12L10 8L6 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
			</div>
		`;
		
		button.innerHTML = `
			<div class="button-content">
				${iconHtml}
				${textHtml}
			</div>
			${arrowHtml}
		`;
		
		return button;
	}
	
	addButton(data) {
		const isNormal = !data.id || data.id === false || data.id === null;
		
		if (isNormal) {
			// Botão normal (sem ID específico)
			// Evitar duplicados por (título + trigger + param)
			const exists = this.normalButtons.some(item => {
				const d = item.data || {};
				return (d.title === data.title) && (d.trigger === data.trigger) && (String(d.par || '') === String(data.par || ''));
			});
			if (exists) return;

			const button = this.createButton(data, true);
			this.normalButtons.push({
				element: button,
				data: data
			});
			this.menuContent.appendChild(button);
		} else {
			// Botão com ID (para submenus)
			// Evitar duplicados por (id + título + trigger + param)
			const exists = this.buttons.some(item => {
				const d = item.data || {};
				return (item.id === data.id) && (d.title === data.title) && (d.trigger === data.trigger) && (String(d.par || '') === String(data.par || ''));
			});
			if (exists) return;

			const button = this.createButton(data);
			this.buttons.push({
				id: data.id,
				element: button,
				data: data
			});
		}
	}
	
	addSubmenu(data) {
		// Evitar duplicados por (menuId) ou (título)
		const exists = this.submenus.some(item => item.menuId === data.menuid || (item.data && item.data.title === data.title));
		if (exists) return;

		const button = document.createElement('div');
		button.className = 'menu-button submenu-button';
		button.dataset.menuId = data.menuid;
		
		const iconSrc = this.icons[data.title] || null;
		const iconHtml = iconSrc 
			? `<div class="button-icon"><img src="${iconSrc}" alt="${data.title}"></div>`
			: '';
		
		button.innerHTML = `
			<div class="button-content">
				${iconHtml}
				<div class="button-text">
					<div class="button-title">${this.escapeHtml(data.title)}</div>
					<div class="button-description">${this.escapeHtml(data.description || '')}</div>
				</div>
			</div>
			<div class="button-arrow">
				<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M6 12L10 8L6 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
			</div>
		`;
		
		this.submenus.push({
			menuId: data.menuid,
			element: button,
			data: data
		});
		
		this.menuContent.appendChild(button);
	}
	
	openSubmenu(menuId) {
		// Salvar estado atual (salvar referências, não clones)
		this.menuStack.push({
			submenus: this.submenus.map(item => ({ ...item })),
			normalButtons: this.normalButtons.map(item => ({ ...item }))
		});
		
		// Esconder submenus e botões normais atuais
		this.submenus.forEach(item => {
			item.element.classList.add('hidden');
		});
		
		this.normalButtons.forEach(item => {
			item.element.classList.add('hidden');
		});
		
		// Adicionar botão voltar no início
		let backButton = document.getElementById('backButton');
		if (!backButton) {
			backButton = document.createElement('div');
			backButton.id = 'backButton';
			backButton.className = 'menu-button back-button warning';
			backButton.innerHTML = `
				<div class="button-content">
					<div class="button-icon">
						<svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
						</svg>
					</div>
					<div class="button-text">
						<div class="button-title">Voltar</div>
						<div class="button-description">Clique para voltar às opções anteriores</div>
					</div>
				</div>
				<div class="button-arrow">
					<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M6 12L10 8L6 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</div>
			`;
			this.menuContent.insertBefore(backButton, this.menuContent.firstChild);
		} else {
			backButton.classList.remove('hidden');
		}
		
		// Mostrar botões do submenu
		const submenuButtons = this.buttons.filter(btn => btn.id === menuId);
		submenuButtons.forEach(btn => {
			if (!this.menuContent.contains(btn.element)) {
				this.menuContent.appendChild(btn.element);
			}
			btn.element.classList.remove('hidden');
		});
	}
	
	goBack() {
		if (this.menuStack.length === 0) return;
		
		// Esconder botão voltar
		const backButton = document.getElementById('backButton');
		if (backButton) {
			backButton.classList.add('hidden');
		}
		
		// Esconder todos os botões com ID (do submenu atual)
		this.buttons.forEach(btn => {
			btn.element.classList.add('hidden');
		});
		
		// Restaurar estado anterior
		const previousState = this.menuStack.pop();
		
		// Mostrar submenus anteriores
		previousState.submenus.forEach(item => {
			if (item.element && this.menuContent.contains(item.element)) {
				item.element.classList.remove('hidden');
			}
		});
		
		// Mostrar botões normais anteriores
		previousState.normalButtons.forEach(item => {
			if (item.element && this.menuContent.contains(item.element)) {
				item.element.classList.remove('hidden');
			}
		});
	}
	
	handleButtonClick(button) {
		const trigger = button.dataset.trigger;
		const param = button.dataset.param || '';
		const server = button.dataset.server || 'false';
		
		if (!trigger) return;
		
		// Enviar para o client-side
		fetch(`https://dynamic/clicked`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				trigger: trigger,
				param: param,
				server: server
			})
		}).then(res => {
			if (!res.ok) {
				throw new Error(`HTTP error! status: ${res.status}`);
			}
			return res.json();
		}).catch(err => {
			console.error('Error sending click:', err);
		});
	}
	
	showMenu() {
		this.menuWrapper.classList.add('active');
		
		// Forçar remoção de qualquer contorno que possa aparecer
		const removeBorder = () => {
			if (this.menuWrapper) {
				this.menuWrapper.style.setProperty('background', 'transparent', 'important');
				this.menuWrapper.style.setProperty('outline', 'none', 'important');
				this.menuWrapper.style.setProperty('border', 'none', 'important');
				this.menuWrapper.style.setProperty('box-shadow', 'none', 'important');
				
				// Remover qualquer pseudo-elemento
				const style = document.createElement('style');
				style.textContent = `
					.menu-wrapper::before,
					.menu-wrapper::after {
						display: none !important;
						content: none !important;
						background: none !important;
						box-shadow: none !important;
					}
				`;
				if (!document.getElementById('dynamic-menu-fix')) {
					style.id = 'dynamic-menu-fix';
					document.head.appendChild(style);
				}
			}
		};
		
		// Remover imediatamente
		removeBorder();
		
		// Aguardar a animação terminar (400ms) e remover novamente
		// Usar requestAnimationFrame para garantir execução após renderização
		this.menuWrapper.addEventListener('animationend', () => {
			removeBorder();
			setTimeout(removeBorder, 10);
			setTimeout(removeBorder, 50);
			setTimeout(removeBorder, 100);
		}, { once: true });
		
		// Fallback caso animationend não dispare
		setTimeout(() => {
			removeBorder();
			setTimeout(removeBorder, 10);
			setTimeout(removeBorder, 50);
			setTimeout(removeBorder, 100);
		}, 450);
		
		// Observar mudanças no elemento
		if (typeof MutationObserver !== 'undefined') {
			const observer = new MutationObserver((mutations) => {
				mutations.forEach((mutation) => {
					if (mutation.type === 'attributes' && 
					    (mutation.attributeName === 'style' || mutation.attributeName === 'class')) {
						removeBorder();
					}
				});
			});
			
			observer.observe(this.menuWrapper, {
				attributes: true,
				attributeFilter: ['style', 'class']
			});
			
			// Guardar o observer para limpar depois
			this.styleObserver = observer;
		}
	}
	
	closeMenu() {
		this.closing = false;
		if (this.closeTimer) {
			clearTimeout(this.closeTimer);
			this.closeTimer = null;
		}
		// Parar o observer de estilos
		if (this.styleObserver) {
			this.styleObserver.disconnect();
			this.styleObserver = null;
		}
		
		// Limpar tudo
		this.buttons = [];
		this.submenus = [];
		this.normalButtons = [];
		this.menuStack = [];
		this.menuContent.innerHTML = '';
		this.menuWrapper.classList.remove('active');
		this.hideIdentity();
		
		// Notificar o cliente
		fetch(`https://dynamic/close`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({})
		}).then(res => res.json()).then(data => {
			// Callback recebido
		}).catch(err => console.error('Error closing menu:', err));
	}
	
	scheduleClose() {
		this.closing = true;
		if (this.closeTimer) {
			clearTimeout(this.closeTimer);
		}
		this.closeTimer = setTimeout(() => {
			this.closeMenu();
		}, 150);
	}
	
	abortCloseIfPending() {
		if (this.closing && this.closeTimer) {
			clearTimeout(this.closeTimer);
			this.closing = false;
			this.closeTimer = null;
		}
	}
	
	showIdentity(data) {
		if (!this.identityWrapper) return;
		
		const title = data.title || 'RG Nacional';
		const name = data.name || '';
		const id = data.id != null ? String(data.id) : '';
		const registration = data.registration || '';
		const phone = data.phone || '';
		
		this.identityElems.title.textContent = title;
		this.identityElems.name.textContent = name;
		this.identityElems.id.textContent = id;
		
		if (registration && String(registration).trim() !== '') {
			this.identityElems.reg.textContent = String(registration);
			this.identityElems.regRow.classList.remove('hidden');
		} else {
			this.identityElems.reg.textContent = '';
			this.identityElems.regRow.classList.add('hidden');
		}
		
		if (phone && String(phone).trim() !== '') {
			this.identityElems.phone.textContent = String(phone);
			this.identityElems.phoneRow.classList.remove('hidden');
		} else {
			this.identityElems.phone.textContent = '';
			this.identityElems.phoneRow.classList.add('hidden');
		}
		
		this.identityWrapper.classList.add('active');
		
		if (this.identityTimer) {
			clearTimeout(this.identityTimer);
			this.identityTimer = null;
		}
		this.identityTimer = setTimeout(() => this.hideIdentity(), data.duration || 7000);
	}
	
	hideIdentity() {
		if (!this.identityWrapper) return;
		this.identityWrapper.classList.remove('active');
		if (this.identityTimer) {
			clearTimeout(this.identityTimer);
			this.identityTimer = null;
		}
	}
	
	escapeHtml(text) {
		if (!text) return '';
		
		const textStr = String(text);
		
		// Converter <yellow>texto</yellow> para placeholder temporário único
		const yellowPlaceholders = [];
		let placeholderIndex = 0;
		const placeholderPattern = /<yellow>(.*?)<\/yellow>/gi;
		let processedText = textStr.replace(placeholderPattern, (match, content) => {
			const placeholder = `__DYNAMIC_YELLOW_PLACEHOLDER_${placeholderIndex}_${Date.now()}__`;
			yellowPlaceholders.push({ placeholder, content });
			placeholderIndex++;
			return placeholder;
		});
		
		// Escapar HTML normalmente (o placeholder será preservado como texto)
		const div = document.createElement('div');
		div.textContent = processedText;
		let escaped = div.innerHTML;
		
		// Restaurar os placeholders com spans amarelos (conteúdo já escapado)
		yellowPlaceholders.forEach(({ placeholder, content }) => {
			// Escapar o conteúdo dentro do yellow também
			const contentDiv = document.createElement('div');
			contentDiv.textContent = content;
			const escapedContent = contentDiv.innerHTML;
			escaped = escaped.replace(placeholder, `<span style="color: #ef4444; font-weight: 600;">${escapedContent}</span>`);
		});
		
		return escaped;
	}
}

// Inicializar quando o DOM estiver pronto
if (document.readyState === 'loading') {
	document.addEventListener('DOMContentLoaded', () => {
		new DynamicMenu();
	});
} else {
	new DynamicMenu();
}
