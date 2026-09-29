const config = {
    imgDir: 'http://131.0.202.203/vehicles/', 
    defaultImg: 'images/no-image.png',
};

let selectedColor = "#c9a227";
let pickr = null;
let previousPage = "home";
let vehiclesData = [];
let myVehiclesData = [];
let currentSelectedVehicle = null;
let isMenuOpen = false;
let isLoadingVehicles = false;
let isLoadingMyVehicles = false;
let isClosing = false;

const categories = [
    { id: "hatch", name: "Hatch & Sedans", icon: "fas fa-car", img: "https://heits.com.br/golfgtihatch4.png" },
    { id: "suvs", name: "SUVs & Picapes", icon: "fas fa-truck-pickup", img: "https://heits.com.br/porschemacansuv2.png" },
    { id: "motos", name: "Motos", icon: "fas fa-motorcycle", img: "https://heits.com.br/s1000rrmotos3.png" },
    { id: "aereo", name: "Aeronaves", icon: "fas fa-plane", img: "https://heits.com.br/aviao.png" },
    { id: "barcos", name: "Náutica", icon: "fas fa-ship", img: "https://heits.com.br/barcos.png" },
];

function getCategoryFromClass(className, modelName = "") {
    if (!className) return "hatch";
    const classLower = className.toLowerCase();
    const modelLower = (modelName || "").toLowerCase();

    // Prioritize explicit class names over keywords to avoid false positives 
    // (e.g., S1000 motorcycle matching the 's10' truck keyword)
    if (classLower === "motorcycles" || classLower === "cycles" || classLower === "moto" || classLower === "motos" || classLower === "moto rara") return "motos";
    if (classLower === "boats" || classLower === "barco" || classLower === "jetski" || classLower === "boat" || classLower === "embarcações") return "barcos";
    if (classLower === "helicopters" || classLower === "helicoptero" || classLower === "helicopter" || classLower === "plane" || classLower === "planes") return "aereo";

    const suvKeywords = ["suv", "x1", "x5", "x6", "x7", "q7", "q8", "cayenne", "macan", "velar", "rover", "jeep", "compass", "santafe", "santa fe", "tiggo", "sw4", "trail", "explorer", "purosangue", "urus", "bentayga", "levante", "cullinan", "dbx"];
    const truckKeywords = ["hilux", "l200", "ranger", "frontier", "s10", "marok", "ram", "trx", "silverado", "saveiro", "f250", "picape", "pickup", "strada", "montana", "toro"];

    if (suvKeywords.some(k => modelLower.includes(k)) || 
        truckKeywords.some(k => modelLower.includes(k)) ||
        classLower.includes("suv") || 
        classLower.includes("off-road") ||
        classLower.includes("picape") || 
        classLower.includes("utilit") || 
        classLower.includes("caminh") ||
        classLower === "industrial" || 
        classLower === "utility" || 
        classLower === "commercial" ||
        classLower === "vans") {
        return "suvs";
    }

    return "hatch";
}

let resourceName = "pdm";

function nuiCallback(name, data, callback) {
    if (!window.invokeNative) {
        if (callback) callback({});
        return;
    }

    $.post(`https://${resourceName}/${name}`, JSON.stringify(data || {}), function (response) {
        if (callback && typeof callback === "function") {
            try {
                const result = typeof response === "string" ? JSON.parse(response) : response;
                callback(result);
            } catch (e) {
                callback(response);
            }
        }
    }).fail(function (xhr, status, error) {
        if (callback && typeof callback === "function") callback({});
    });
}

$(document).ready(function () {
    window.addEventListener("message", function (event) {
        console.log("[PDM-JS] Mensagem recebida:", event.data);
        let data = event.data;
        let action = (data.Action || data.action || "").toLowerCase();
        console.log("[PDM-JS] Action:", action);
        
        if (action == "open" || action == "dealership") {
            console.log("[PDM-JS] Tentando abrir menu...");
            console.log("[PDM-JS] isMenuOpen:", isMenuOpen);
            console.log("[PDM-JS] isClosing:", isClosing);
            
            if (!isMenuOpen && !isClosing) {
                if (data.Payload || data.payload) {
                    console.log("[PDM-JS] Processando payload...");
                    processPayload(data.Payload || data.payload);
                }
                console.log("[PDM-JS] Chamando openMenu()...");
                openMenu();
            } else {
                console.log("[PDM-JS] Menu já está aberto ou fechando");
            }
        }
        if (action == "close" || action == "hidemenu") {
            if (isMenuOpen && !isClosing) closeMenu();
        }
    });

    $(document).keyup(function (e) {
        if (e.key === "Escape" && isMenuOpen && !isClosing) {
            closeMenu();
        }
    });

    initColorPicker();
    // if (!window.invokeNative) openMenu(); // Debug code removed
});

function initColorPicker() {
    if (pickr) pickr.destroyAndRemove();

    pickr = Pickr.create({
        el: ".pickr-mount",
        theme: "nano",
        default: selectedColor,
        swatches: ["#C9A227", "#FF0000", "#00FF00", "#0000FF", "#FFFFFF", "#000000"],
        components: {
            preview: true,
            opacity: false,
            hue: true,
            interaction: { hex: true, rgba: true, input: true, save: true }
        }
    });

    pickr.on("change", (color) => {
        const hexColor = color.toHEXA().toString();
        selectedColor = hexColor;
        $("#color-preview").css("background", hexColor);
    });
}

function openMenu() {
    if (isMenuOpen) return;
    isMenuOpen = true;
    $(".app-container").css("display", "flex").hide().fadeIn(200);
    loadVehiclesData();
}

function closeMenu() {
    if (isClosing || !isMenuOpen) return;
    isClosing = true;
    isMenuOpen = false;
    $(".app-container").fadeOut(150, function() {
        nuiCallback("Close", {});
        isClosing = false;
    });
}

function processPayload(payload) {
    console.log("[PDM-NUI] Processing Payload:", payload);
    if (!payload || !payload[0]) {
        console.error("[PDM-NUI] Payload empty or invalid.");
        return;
    }
    const list = payload[0];
    const discount = payload[1] || 0;

    vehiclesData = [];
    for (let k in list) {
        let v = list[k];
        const vName = String(v.name || v.Name || k);
        const vClass = String(v.class || v.Class || v.type || "NORMAL").toUpperCase();
        
        // Filter out specific names/classes if needed
        if (vName.includes("[PM]") || vName.includes("[ROTA]") || vName.includes("[GCM]") || vClass === "SERVIÇOS" || vClass === "WORK") continue;

        const originalPrice = parseInt(v.price || v.Price || 0);
        const discountedPrice = discount > 0 ? Math.floor(originalPrice * (1 - discount / 100)) : originalPrice;

        vehiclesData.push({
            model: v.spawn || k,
            name: vName,
            price: discountedPrice,
            originalPrice: originalPrice,
            discount: discount,
            capacity: v.trunk || v.Weight || 0,
            class: vClass,
            category: getCategoryFromClass(vClass, vName),
            stock: v.stock || 0,
            vip: v.vip || false,
        });
    }
    console.log("[PDM-NUI] vehiclesData populated:", vehiclesData.length);
}

function loadVehiclesData() {
    if (vehiclesData.length > 0) { 
        openHome(); 
        return; 
    }

    if (isLoadingVehicles) return;
    isLoadingVehicles = true;

    openHome();

    nuiCallback("Mount", {}, function (response) {
        isLoadingVehicles = false;
        if (response && response.list) {
            processPayload([response.list, response.discount || 0]);
            // if (response.dir) config.imgDir = response.dir; // Comentado para forçar o XAMPP externo
            requestAnimationFrame(() => openHome()); // Use requestAnimationFrame for smoother UI update
        }
    });
}

function openHome() {
    previousPage = "home";
    $("#current-page-title").text("Concessionária Oficial");
    $("#current-page-subtitle").text("Seja bem-vindo à melhor seleção de veículos");
    $("#search-container").hide();
    
    updateActiveNav("nav-home");
    hideAllPages();
    $("#page-home").show();

    if (vehiclesData && vehiclesData.length > 0) {
        let heroCar = vehiclesData[0];
        $("#hero-name").text(heroCar.name);
        $("#hero-price").text(formatPrice(heroCar.price));
        $("#hero-class").text(heroCar.class).show();
        $("#hero-img").attr("src", getImgUrl(heroCar.model));
        $("#hero-btn").off("click").on("click", () => openDetails(heroCar.model));
    } else {
        $("#hero-name").text("Buscando ofertas...");
        $("#hero-price").text("Aguarde...");
        $("#hero-class").hide();
    }

    let catHtml = categories.map(c => `
        <div class="category-card" onclick="openGrid('${c.id}', '${c.name}')">
            <img src="${c.img}" alt="${c.name}" onerror="this.src='${config.fallbackImg}'">
            <div class="category-name">${c.name}</div>
        </div>`).join("");
    $("#categories-container").html(catHtml);

    let featuredVehicles = vehiclesData.length > 1 ? vehiclesData.slice(1, 9) : (vehiclesData.length === 1 ? [vehiclesData[0]] : []);
    let featuredHtml = featuredVehicles.length > 0 ? featuredVehicles.map(v => createCardHtml(v)).join("") : '<p class="no-data">Nenhum veículo disponível no momento.</p>';
    $("#home-cards-container").html(featuredHtml);
}

function updateActiveNav(id) {
    $(".nav-item").removeClass("active");
    $(`#${id}`).addClass("active");
}

function openGrid(categoryId, categoryName) {
    previousPage = "grid";
    $("#current-page-title").text(categoryName);
    $("#current-page-subtitle").text(`Explorando categoria ${categoryName}`);
    $("#search-container").fadeIn();
    
    hideAllPages();
    $("#page-grid").show();
    $("#searchInput").val("");

    let filtered = vehiclesData.filter(v => v.category === categoryId);
    let gridHtml = filtered.length > 0 ? filtered.map(v => createCardHtml(v)).join("") : '<div class="no-results">Nenhum veículo encontrado nesta categoria.</div>';
    $("#grid-content").html(gridHtml);
}

function openMyVehicles() {
    previousPage = "myvehicles";
    updateActiveNav("nav-myvehicles");
    $("#current-page-title").text("Meus Veículos");
    $("#current-page-subtitle").text("Gerencie sua garagem pessoal");
    $("#search-container").fadeIn();
    
    hideAllPages();
    $("#page-grid").show();
    $("#grid-content").html('<div class="spinner"></div>');

    nuiCallback("requestMyVehicles", {}, function (response) {
        if (response && response.list) {
            myVehiclesData = response.list.map(v => ({
                model: v.spawn,
                name: v.name,
                price: v.price,
                capacity: v.trunk || v.Weight || 0,
                class: (v.type || "NORMAL").toUpperCase(),
                category: getCategoryFromClass(v.type || "NORMAL", v.name),
                stock: 1
            }));
            let gridHtml = myVehiclesData.length > 0 ? myVehiclesData.map(v => createCardHtml(v, "sell")).join("") : '<div class="no-results">Você ainda não possui veículos.</div>';
            $("#grid-content").html(gridHtml);
        }
    });
}

function openDetails(model) {
    let vehicle = vehiclesData.find(v => v.model === model) || myVehiclesData.find(v => v.model === model);
    if (!vehicle) return;

    currentSelectedVehicle = vehicle;
    const isOwner = myVehiclesData.some(v => v.model === model);
    
    // Call Mount to spawn the vehicle in the showroom
    nuiCallback("Mount", { vehicle: model });

    hideAllPages();
    $("#page-details").fadeIn(400);
    $("#current-page-title").text("Especificações");
    $("#current-page-subtitle").text(vehicle.name);
    $("#search-container").hide();

    $("#detail-name").text(vehicle.name);
    $("#detail-class").text(vehicle.class);
    $("#detail-price .value").text(formatPrice(vehicle.price));
    $("#detail-capacity").text(`${vehicle.capacity}L`);
    $("#detail-stock").text(isOwner ? "Na Garagem" : vehicle.stock);
    $("#detail-img").attr("src", getImgUrl(vehicle.model));

    if (isOwner) {
        $("#btn-buy-vehicle").text("Vender Veículo").off("click").on("click", handleSellVehicle);
        $("#btn-test-drive").hide();
    } else {
        $("#btn-buy-vehicle").text("Comprar Veículo").off("click").on("click", () => vehicle.stock > 0 ? openColorPopup() : showResult(false, "Erro", "Veículo sem estoque"));
        $("#btn-test-drive").show().off("click").on("click", handleTestDrive);
    }

    let related = vehiclesData.filter(v => v.category === vehicle.category && v.model !== vehicle.model).slice(0, 4);
    $("#related-container").html(related.map(v => createCardHtml(v)).join(""));
}

function rotateVehicle(dir) {
    nuiCallback("Rotate", { direction: dir });
}

function createCardHtml(v, type = "buy") {
    return `
    <div class="vehicle-card" onclick="openDetails('${v.model}')">
        <div class="card-image">
            <span class="card-badge">${v.class}</span>
            <img src="${getImgUrl(v.model)}" loading="lazy" onerror="console.log('Erro ao carregar imagem: ' + this.src); this.onerror=null; this.src='${config.defaultImg}';">
        </div>
        <div class="card-body">
            <h4 class="card-title">${v.name}</h4>
            <div class="card-meta">
                <span><i class="fas fa-boxes"></i> ${v.capacity}L</span>
                <span><i class="fas fa-layer-group"></i> ${v.stock}</span>
            </div>
        </div>
        <div class="card-footer">
            <div class="card-price">${formatPrice(v.price)}</div>
            <div class="card-btn">${type === "sell" ? "VENDER" : "DETALHES"}</div>
        </div>
    </div>`;
}

function formatPrice(val) {
    return "R$ " + val.toLocaleString("pt-BR", { minimumFractionDigits: 0 });
}

function getImgUrl(model) {
    return `${config.imgDir}${model}.jpg`;
}

function hideAllPages() {
    $("#page-home, #page-grid, #page-details, .modal").hide();
}

function handleTestDrive() {
    showConfirm(`Deseja realizar o teste em um <b>${currentSelectedVehicle.name}</b>?`, () => {
        showLoading();
        nuiCallback("Drive", { vehicle: currentSelectedVehicle.model }, () => {
            hideLoading();
            closeMenu();
        });
    });
}

function handleSellVehicle() {
    showConfirm(`Deseja vender seu <b>${currentSelectedVehicle.name}</b> por <b>${formatPrice(currentSelectedVehicle.price)}</b>?`, () => {
        showLoading();
        nuiCallback("sellVehicle", { vehicle: currentSelectedVehicle.model }, (res) => {
            hideLoading();
            showResult(true, "Sucesso", "Veículo vendido com sucesso!", openMyVehicles);
        });
    });
}

function openColorPopup() {
    $("#popup-color").fadeIn().css("display", "flex");
    $("#color-preview").css("background", selectedColor);
    $("#btn-confirm-color").off("click").on("click", finishPurchase);
}

function closeColorPopup() {
    $("#popup-color").fadeOut();
}

function finishPurchase() {
    closeColorPopup();
    showConfirm(`Confirmar a compra do <b>${currentSelectedVehicle.name}</b>?`, () => {
        showLoading();
        nuiCallback("Buy", { vehicle: currentSelectedVehicle.model, color: selectedColor }, (res) => {
            hideLoading();
            if (res && res.success) {
                showResult(true, "Sucesso", "Parabéns pela sua nova aquisição!", closeMenu);
            } else {
                showResult(false, "Erro", res.message || "Saldo insuficiente ou problema no servidor.");
            }
        });
    });
}

function searchVehicle() {
    let term = $("#searchInput").val().toLowerCase();
    $(".vehicle-card").each(function () {
        let name = $(this).find(".card-title").text().toLowerCase();
        $(this).toggle(name.includes(term));
    });
}

function showConfirm(message, onYes) {
    $("#popup-confirm-message").html(message);
    $("#popup-confirm").fadeIn().css("display", "flex");
    $("#popup-confirm-yes").off("click").on("click", () => { $("#popup-confirm").hide(); onYes(); });
    $("#popup-confirm-no").off("click").on("click", () => $("#popup-confirm").hide());
}

function showResult(success, title, message, onOk) {
    $("#popup-result-title").text(title);
    $("#popup-result-message").text(message);
    $("#result-icon").removeClass("icon-success icon-error").addClass(success ? "icon-success" : "icon-error");
    $("#result-icon i").removeClass("fa-check-circle fa-times-circle").addClass(success ? "fa-check-circle" : "fa-times-circle");
    $("#popup-result").show().css("display", "flex");
    $("#popup-result-ok").off("click").on("click", () => {
        $("#popup-result").hide();
        if (onOk) onOk();
    });
}

function showLoading() {
    $("#popup-loading").show().css("display", "flex");
}

function hideLoading() {
    $("#popup-loading").hide();
}
