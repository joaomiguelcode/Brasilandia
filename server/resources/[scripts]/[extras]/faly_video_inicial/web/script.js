// create youtube player
var player;
function onYouTubePlayerAPIReady() {
    player = null
}

// autoplay video
function onPlayerReady(event) {
    event.target.playVideo();
}

// when video ends
function onPlayerStateChange(event) {        
    if(event.data === 0) {            
        $('#player').fadeOut();
        $.post("http://faly_video_inicial/Close")
    }
}

function OpenPlayer(){
    player = new YT.Player('player', {
        videoId: 'GTqOhdWxKKo', 
        // playerVars: { 'autoplay': 1 },
        playerVars: { 'autoplay': 1, 'controls': 0, 'disablekb': 1 },
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
    });
}

$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event["data"]["Action"]){
			case "Open":
                OpenPlayer()
				$("#player").fadeIn();
			break;
		}
	});
});