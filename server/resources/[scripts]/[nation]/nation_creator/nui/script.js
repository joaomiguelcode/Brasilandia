var gender = "male";
var activeCam = 0;
var activePage = 0;
var inCreator = false;
var changingCam = false;
var componentCams = {};
var charInfos = {};
var player = {
    gender: "male",
    eyes: "2",
    'eyes-max': 32,
    'eyes-min': 0,
    eyebrows: 12,
    'eyebrows-max': 34,
    'eyebrows-color': 2,
    makeup: 0,
    'makeup-min': -1,
    'makeup-max': 81,
    'makeup-opacity': 50,
    'maekup-color': 1
};

const cams = [
    "body", "head", "eye", "mouth", "chest"
];

const getCamIndex = (cam) => {
    for (let i in cams) 
        if (cams[i] == cam) return i;
    return 0;
}

const keys = {
    [8]: "back",
    [13]: "enter",
    [27]: "esc",
    [32]: "space",
    [37]: "left",
    [38]: "up",
    [39]: "right",
    [40]: "down",
    [49]: "slot1",
    [50]: "slot2",
    [51]: "slot3",
    [52]: "slot4",
    [53]: "slot5",
    [65]: "a",
    [68]: "d",
    [88]: "x"
}


var colors = [
    [ 28, 31, 33],
    [ 39, 42, 44],
    [ 49, 46, 44],
    [ 53, 38, 28],
    [ 75, 50, 31],
    [ 92, 59, 36],
    [ 109, 76, 5],
    [ 107, 80, 5],
    [ 118, 92, 6],
    [ 127, 104,78 ],
    [ 153, 129,93 ],
    [ 167, 147,105 ],
    [ 175, 156,112 ],
    [ 187, 160,99 ],
    [ 214, 185,123 ],
    [ 218, 195,142 ],
    [ 159, 127, 89 ],
    [ 132, 80, 5],
    [ 104, 43, 3],
    [ 97, 18, 12],
    [ 100, 15, 1],
    [ 124, 20, 1],
    [ 160, 46, 2],
    [ 182, 75, 4],
    [ 162, 80, 4],
    [ 170, 78, 4],
    [ 98, 98, 98],
    [ 128, 128, 128],
    [ 170, 170, 170],
    [ 197, 197, 197],
    [ 70, 57, 85],
    [ 90, 63, 10],
    [ 118, 60, 1],
    [ 237, 116, 227],
    [ 235, 75, 1],
    [ 242, 153, 188],
    [ 4, 149, 15],
    [ 2, 95, 134],
    [ 2, 57, 116],
    [ 63, 161, 1],
    [ 33, 124, 9],
    [ 24, 92, 85],
    [ 182, 192, 52],
    [ 112, 169, 11],
    [ 67, 157, 1],
    [ 220, 184, 87],
    [ 229, 177, 3],
    [ 230, 145, 2],
    [ 242, 136, 49],
    [ 251, 128, 87],
    [ 226, 139, 88],
    [ 209, 89, 6],
    [ 206, 49, 3],
    [ 173, 9, 3],
    [ 136, 3, 2],
    [ 31, 24, 20],
    [ 41, 31, 25],
    [ 46, 34, 27],
    [ 55, 41, 30],
    [ 46, 34, 24],
    [ 35, 27, 21],
    [ 2, 2, 2],
    [ 112, 108, 102 ],
    [ 157, 122, 80 ],
]


var makeUpColors = [
    [153, 37, 50],
    [200, 57, 93],
    [189, 81, 108],
    [184, 99, 122],
    [166, 82, 107],
    [177, 67, 76],
    [127, 49, 51],
    [164, 100, 93],
    [193, 135, 121],
    [203, 160, 150],
    [198, 145, 143],
    [171, 111, 99],
    [176, 96, 80],
    [168, 76, 51],
    [180, 113, 120],
    [202, 127, 146],
    [237, 156, 190],
    [231, 117, 164],
    [222, 62, 129],
    [179, 76, 110],
    [113, 39, 57],
    [79, 31, 42],
    [170, 34, 47],
    [222, 32, 52],
    [207, 8, 19],
    [229, 84, 112],
    [220, 63, 181],
    [194, 39, 178],
    [160, 28, 169],
    [110, 24, 117],
    [115, 20, 101],
    [86, 22, 92],
    [109, 26, 157],
    [27, 55, 113],
    [29, 78, 167],
    [30, 116, 187],
    [33, 163, 206],
    [37, 194, 210],
    [35, 204, 165],
    [39, 192, 125],
    [27, 156, 50],
    [20, 134, 4],
    [112, 208, 65],
    [197, 234, 52],
    [225, 227, 47],
    [255, 221, 38],
    [250, 192, 38],
    [247, 138, 39],
    [254, 89, 16],
    [190, 110, 25],
    [247, 201, 127],
    [251, 229, 192],
    [245, 245, 245],
    [179, 180, 179],
    [145, 145, 145],
    [86, 78, 78],
    [24, 14, 14],
    [88, 150, 158],
    [77, 111, 140],
    [26, 43, 85],
    [160, 126, 107],
    [130, 99, 85],
    [109, 83, 70],
    [62, 45, 39],
]

const rotatePlayer = (increase) => {
    $.post("https://nation_creator/rotate", JSON.stringify({ increase: increase }));
}

const actionKeys = {
    back: () => {
        if(!inCreator) return;
        if ($(".popup").hasClass("popup-active"))
            deny();
        else
            slide(false, false, true);
    },
    left: () => {
        if ($("input").is(':focus') || !inCreator) return;
        slide(false, false, false);
    },

    right: () => {
        if ($("input").is(':focus') || !inCreator) return;
        slide(true, false, false);
    },


    a: () => {
        rotatePlayer(true);
    },

    d: () => {
        rotatePlayer(false);
    },

    slot1: () => {
        if(!inCreator) return;
        changeCam(false, 0);
    },

    slot2: () => {
        if(!inCreator) return;
        changeCam(false, 1);
    },

    slot3: () => {
        if(!inCreator) return;
        changeCam(false, 2);
    },

    slot4: () => {
        if(!inCreator) return;
        changeCam(false, 3);
    },

    slot5: () => {
        if(!inCreator) return;
        changeCam(false, 4);
    },
}



const pagesCam = [ "body", "body", "head", "head", "head", "head", "head" ]


const buildContainer = () =>{
    let popupInner = `<div class="popup">
        <div class="popup-header">
            <i class="fas fa-exclamation-circle"></i>
            <p>${lang.confirm}</p>
        </div>
        <div class="popup-text"></div>
        <div class="popup-buttons">
            <button id="yes" class="btn finish" onclick="finish()"><span>${lang.yes}</span></button>
            <button class="btn deny" onclick="deny()"><span>${lang.no}</span></button>
        </div>
        <div class="popup-loading">
            <div class="lds-ring"><div></div><div></div><div></div><div></div></div>
            <i class="far fa-check-circle success"></i>
            <i class="fas fa-ban fail"></i>
            <p></p>
        </div>
    </div>`;
    $(".popup-container").html(popupInner);
}



const startNui = () => {
    buildContainer();
    const actions = {
        show: (data) => {
            buildContainer();
            componentCams = data.componentCams;
            player = data.player;
            colors = data.colors;
            makeUpColors = data.makeUpColors;
            $(".creator").fadeIn(500);
            inCreator = true;
            changePage(0);
            setData();
        },

        hide: (data) => {
            if (!inCreator) return; 
            $(".creator").fadeOut(500);
            inCreator = false;
        },

        updatePlayer: (data) => {
            player = data.player;
            setData(true);
        },

        showMultiChar: (data) => {
            charInfos = data.charInfos;
            buildChars();
            $(".multichar").fadeIn(500);
        },

        hideMultiChar: (data) => {
            $(".multichar").fadeOut(500);
        },

       
    }

    window.addEventListener("message", (event) => {
        let action = event.data.action;
        if (actions[action]) actions[action](event.data);
    });

    document.onkeydown = (data) => {
        if ($("input[type=text]").is(':focus') || $("input[type=number]").is(':focus')) return;
        let key = keys[data.which];
        if (actionKeys[key]) actionKeys[key]();
    };
}




$(() => {
    var loaded = false;
    window.addEventListener("message", function (event) {
		let message = event.data.message;
		if (message === "authenticated " && !loaded) {
            loaded = true;
            startNui();
            $.post("https://nation_creator/loaded");
        }
	});
})





const changePage = (page) =>{
    activePage = page;
    let el = $(".top .option")[page];
    $(".top .option").removeClass("option-selected");
    $(el).addClass("option-selected");
    $(".creator .left").hide();
    $($(".creator .left")[page]).show();
    $(".creator .right").slideUp(500);
    changeCam(false, getCamIndex(pagesCam[activePage]));  
}



const changeCam = (increase, force) => {
    if (changingCam || (force != undefined && force == activeCam)) return;
    changingCam = true;
    if (force != undefined) 
        activeCam = force;
    else if (increase)  
        if (activeCam+1 < cams.length)
            activeCam++;
        else
            activeCam = 0;
    else 
        if (activeCam-1 >= 0) 
            activeCam--;
        else 
            activeCam = cams.length-1;
    $(".cam-icon").html(icons[cams[activeCam]]);
    $.post("https://nation_creator/changeCam", JSON.stringify({ cam: cams[activeCam] }));
    setTimeout(()=>{ changingCam = false;},600);
}



function toVh(px) {
	return px * (100 / document.documentElement.clientHeight);
}


const finish = () => {
    $(".popup-loading").addClass("popup-loading-active")
    $(".lds-ring").fadeIn(300);
    $.post("https://nation_creator/finish", JSON.stringify({}), (data)=>{
        let classe = ".fail";
        if (data) classe = ".success";
        $(".lds-ring").fadeOut(300, ()=>{
            $(classe).addClass("icon-active");
            setTimeout(() =>{
                deny();
            },2000)
        });
    });
}

const deny = () => {
    $(".popup").removeClass("popup-active");
    $(".popup-container").fadeOut(500, ()=>{
        $(".popup-loading").removeClass("popup-loading-active");
        $(".lds-ring").hide();
        $(".popup-loading i").removeClass("icon-active");
    });
}


const uppercaseWords = str => str.toLowerCase().replace(/^(.)|\s+(.)/g, c => c.toUpperCase());


const requestPopup = () => {
    $("#yes").attr("onclick", "finish()");
    $.post("https://nation_creator/requestPopup", 
    JSON.stringify({ name: uppercaseWords($("#name").val()), lastName: uppercaseWords($("#lastName").val()), age: parseInt($("#age").val()), }), 
    (data)=> {
        $(".popup-loading p").text("");
        if (data.success) {
            $(".popup-text").html("<p>"+data.message+"</p>");
            $(".popup-container").fadeIn(500, ()=>{
                $(".popup").addClass("popup-active");
            });
        } else {
            $(".popup-text").html("<p>"+data.message+"</p>");
            $(".popup-container").fadeIn(500, ()=>{
                $(".popup").addClass("popup-active");
            });
            $(".popup-loading").addClass("popup-loading-active");
            $(".lds-ring").fadeIn(300);
            setTimeout(()=>{
                $(".lds-ring").fadeOut(300, ()=>{
                    $(".fail").addClass("icon-active");
                    $(".popup-loading p").text(data.message);
                    setTimeout(() =>{
                        deny();
                        changePage(0);
                    },3000)
                });
            }, 2000);
        }
    });
}



const selectParent = (key, index, el) => {
    selectOption(key, index, el);
    let c = key == "shapeFirst" ? "mom" : "dad";
    $("."+c).attr("src", imgDir+"parents/"+index+".png");
}


const selectOption = (option, index, el) => {
    $(".grid-option").removeClass("grid-option-actived");
    $(el).addClass("grid-option-actived");
    if (!option.includes("color") && !option.includes("opacity")) {
        $("#"+option).html(index);
    }
    player[option] = index;
    $.post("https://nation_creator/change", JSON.stringify({ key: option, value: player[option] }));
}



const buildParentSelection = (key, title, showAll) =>{
    let container = $(".creator .right");
    let grid = "";
    let start = 0;
    if (key == "shapeFirst" && !showAll) start = 21;
    for (let i = start; i <= parents.length-1; i++) {
        if (!showAll)
            if (start == 0 && i > 20 && (i < 42 || i > 44)) continue;
            else if (start != 0 && (i < 21 || (i > 41 && i < 45))) continue;
        grid += `<div class="${i == player[key] ? "grid-option grid-option-actived" : "grid-option"}" onclick="selectParent('${key}', ${i}, this);">
            <img src="${imgDir}parents/${i}.png" alt="">
            <span>${parents[i]}</span>
            <i>${icons.check}</i>
        </div>`;
    } 
    if (!showAll)
        grid += `<div class="grid-option showAll" onclick="buildParentSelection('${key}', '${title}', true);">${icons.plus}</div>`;
    let div = `<div class="card">
        <img src="https://media.discordapp.net/attachments/952588860624338994/1217766131549474836/Sem_titulo.png?ex=66053816&is=65f2c316&hm=4d94ed1e8fa49fcfb2b291e405a1d42fd8cbe7960b09568d8f330e70587204c1&=&format=webp&quality=lossless&width=141&height=59" alt="">
        <div class="title">${title}</div>
    </div>
    <div class="grid-selector">${grid}</div>`;
    container.slideUp(500,()=>{ container.html(div).slideDown(500);});  
}

const buildShapeSelection = (key, title) =>{
    let container = $(".creator .right");
    let grid = "";
    let min = player[key+"-min"] != undefined ? player[key+"-min"] : -1 ;
    for (let i = min; i < player[key+"-max"]; i++) {
        grid += `<div class="${i == player[key] ? "grid-option grid-option-actived" : "grid-option"}" onclick="selectOption('${key}', ${i}, this);">
            <img src="${imgDir+player.gender}/${key}/${i}.png" alt="">
            <span>${i}</span>
            <i>${icons.check}</i>
        </div>`;
    } 
    let div = `<div class="card">
        <img src="https://media.discordapp.net/attachments/952588860624338994/1217766131549474836/Sem_titulo.png?ex=66053816&is=65f2c316&hm=4d94ed1e8fa49fcfb2b291e405a1d42fd8cbe7960b09568d8f330e70587204c1&=&format=webp&quality=lossless&width=141&height=59" alt="">
        <div class="title">${title}</div>
    </div>
    <div class="grid-selector">${grid}</div>`;

    if (componentCams[key]) 
        changeCam(false, getCamIndex(componentCams[key]));
    else
        changeCam(false, getCamIndex(pagesCam[activePage]));

    container.slideUp(500,()=>{ container.html(div).slideDown(500);});   
}


const selectColor = (key, index, el, makeup) => {
    let color = makeup ? makeUpColors[index] : colors[index];
    if (color) {
        let r = color[0], g = color[1], b = color[2];
        $("#"+key).css("background", `rgb(${r},${g},${b})`);
    } else
        $("#"+key).css("background", "transparent");
    selectOption(key, index, el);
}

const buildColorSelection = (key, title, makeup) =>{
    let container = $(".creator .right");
    let grid = "";

    if (key == "makeup-color")
        grid += `<div class="${-1 == player[key] ? "grid-option grid-option-actived" : "grid-option"} grid-option-color"
        onclick="selectColor('${key}', -1, this, ${makeup});"  style="background: linear-gradient(180deg, rgba(0,0,0,0.1) 0%, rgba(0,0,0,0,0.2) 100%);">
            <i>${icons.check}</i>
        </div>`;

    for (let k in makeUpColors) {
        let color = colors[k];
        if (makeup) color = makeUpColors[k];
        let r = color[0], g = color[1], b = color[2];
        

        grid += `<div class="${k == player[key] ? "grid-option grid-option-actived" : "grid-option"} grid-option-color"
        onclick="selectColor('${key}', ${k}, this, ${makeup});"  style="background: linear-gradient(180deg, rgba(${r},${g},${b},0.8) 0%, rgba(${r},${g},${b},1) 50%, rgba(${r},${g},${b},0.8) 100%);">
            <span>${k}</span>
            <i>${icons.check}</i>
        </div>`;
    } 

    let div = `<div class="card">
        <img src="https://media.discordapp.net/attachments/952588860624338994/1217766131549474836/Sem_titulo.png?ex=66053816&is=65f2c316&hm=4d94ed1e8fa49fcfb2b291e405a1d42fd8cbe7960b09568d8f330e70587204c1&=&format=webp&quality=lossless&width=141&height=59" alt="">
        <div class="title">${title}</div>
    </div>
    <div class="grid-selector">${grid}</div>`;

    container.slideUp(500,()=>{ container.html(div).slideDown(500);});   
}






const changeSliderValue = (slider, el, v) => {
    let value = v != undefined ? v : $(el).val();
    $(el).siblings('span').text((slider == "shapeMix" || slider == "skinMix") ? value+'%' : value);
    player[slider] = (slider == "shapeMix" || slider == "skinMix" || slider.includes("opacity")) ? parseFloat(value)/100 : parseFloat(value);
    $.post("https://nation_creator/change", JSON.stringify({ key: slider, value: player[slider] }));
}



const changeGender = (gender) => {
    $(".gender-button").removeClass("gender-button-actived");
    $(".gender-"+gender).addClass("gender-button-actived");
    player.gender = gender;
    $.post("https://nation_creator/change", JSON.stringify({ key: "gender", value: player.gender }));
}



const setData = (genderChanged) => {
    if (!genderChanged) changeGender(player.gender);
    selectParent("shapeFirst", player.shapeFirst);
    selectParent("shapeSecond", player.shapeSecond);
    $("#shapeMix").val( parseInt(player.shapeMix * 100));
    $("#skinMix").val( parseInt(player.skinMix * 100));
    $("#skinMix").siblings('span').text(parseInt(player.skinMix * 100)+'%');
    for (let i in player) {
        let v = player[i];
        let el = $("#"+i);
        if (el.length && el.is("input")) {
            if (i != "shapeMix" && i != "skinMix") {
                $("#"+i).attr("max", player[i+"-max"] != undefined ? player[i+"-max"]-1 : $("#"+i).attr("max"));
                $("#"+i).attr("min", player[i+"-min"] != undefined ? player[i+"-min"] : -1);
                el.siblings('span').text((i == "shapeMix" || i == "skinMix") ? v+'%' : i.includes("opacity") ? parseInt(v*100):  v);
                el.val(i.includes("opacity") ? parseInt(v*100) :  v);
            }
        }
        if ($("#"+i+"").length && !i.includes("color")) $("#"+i+"").text(v);
        if ($("#"+i+"-color").length) {
            let color = colors[player[i+"-color"]];
            if (i == "makeup" || i == "lipstick" || i == "blush") 
                color = makeUpColors[player[i+"-color"]];
            if (color) {
                let r = color[0], g = color[1], b = color[2];
                $("#"+i+"-color").css("background", "rgb("+r+","+g+","+b+")");
            } else
                $("#"+i+"-color").css("background", "transparent");
        }
    }
    let color = colors[player["hair-highlightcolor"]];
    if (color) {
        let r = color[0], g = color[1], b = color[2];
        $("#hair-highlightcolor").css("background", "rgb("+r+","+g+","+b+")");
    } else
        $("#hair-highlightcolor").css("background", "transparent");
}






const buildChars = () => {
    let inner = "";
    for (let i = 0; i < charInfos.maxChars; i++) {
        let charName = lang.empty;
        let charId = "";
        let icon = icons.plus;
        let classe = "char-selector";

        if (charInfos.chars[i]) {
            let info = charInfos.chars[i];
            charName = info.name;
            charId = info.id;
            icon = icons.player;
            classe = classe + " char-selector-active"
        }

        let div = `<div class="${classe}" onclick="selectChar(${i}, this)">
            ${icon}
            <div>
                <p>personagem</p>
                <p>
                    <span>${charName}</span>
                    <b>${charId}</b>
                </p>
            </div>
        </div>`
        inner += div;
    }
    $(".multichar .left .options").html(inner);
    // $(".multichar .left").slideDown(500);
    $(".multichar .right").slideUp(500);
}



const selectChar = (char, el) => {
    $(".char-selector").removeClass("char-selector-selected");
    $(el).addClass("char-selector-selected");
    let container = $(".multichar .right");
    if (charInfos.chars[char]) {
        let info = charInfos.chars[char];
        let infos = ["name", "age", "gender", "bank", "registration", "phone"];
        for (let i in infos) {
            let v = infos[i];
            let id = "#player-"+v;
            $(id).html(info[v]);
        }
        container.slideUp(500,()=>{
            container.slideDown(500);
            $(".play-button").attr("onclick", `buttonsF.playChar(${char})`);
            $(".delete-button").attr("onclick", `buttonsF.tryDeleteChar(${char})`);
        });  
    } else {
        $(".play-button").attr("onclick", `buttonsF.createChar(${char})`);
        $(".delete-button").attr("onclick", "");
        container.slideUp(500);
    }
    $.post("https://nation_creator/selectChar", JSON.stringify({ char: char }));
}



var btnDelay = false;
var buttons = ["playChar", "createChar", "tryDeleteChar"];
var buttonsF = {};


let btnCallbacks = {
    tryDeleteChar: (data) => {
        $("#yes").attr("onclick", `deleteChar(${data.char})`);
        $(".popup-loading p").text("");
        if (data.success) {
            $(".popup-text").html("<p>"+data.message+"</p>");
            $(".popup-container").fadeIn(500, ()=>{
                $(".popup").addClass("popup-active");
            });
        } else {
            $(".popup-text").html("<p>"+data.message+"</p>");
            $(".popup-container").fadeIn(500, ()=>{
                $(".popup").addClass("popup-active");
            });
            $(".popup-loading").addClass("popup-loading-active");
            $(".lds-ring").fadeIn(300);
            setTimeout(()=>{
                $(".lds-ring").fadeOut(300, ()=>{
                    $(".fail").addClass("icon-active");
                    $(".popup-loading p").text(data.message);
                    setTimeout(() =>{
                        deny();
                    },3000)
                });
            }, 2000);
        }
    }
}

const deleteChar = (char) =>{
    $(".popup-loading p").text("");
    $(".popup-loading").addClass("popup-loading-active")
    $(".lds-ring").fadeIn(300);
    $.post("https://nation_creator/deleteChar", JSON.stringify({ char: char }), (data)=>{
        let classe = ".fail";
        if (data.success){
            $(".delete-button").attr("onclick", "");
            $(".multichar .right").slideUp(500);
            classe = ".success";
        } 
        $(".popup-loading p").text(data.message);
        $(".lds-ring").fadeOut(300, ()=>{
            $(classe).addClass("icon-active");
            setTimeout(() =>{
                deny();
            },2000)
        });
    });
}

for (let i in buttons){
    let btn = buttons[i];
    buttonsF[btn] = (char) => {
        if (btnDelay) return;
        btnDelay = true;
        let cb =  btnCallbacks[btn];
        $.post("https://nation_creator/"+btn, JSON.stringify({ char: char }), cb);
        setTimeout(()=>{btnDelay = false;},3000);
    }
}
