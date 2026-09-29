window.addEventListener('load', function() {
    document.querySelector('.nui').style.display = 'none'; // Garante que a NUI esteja invisível ao carregar

    const timeSlider = document.getElementById("time-slider");
    const minuteSlider = document.getElementById("minute-slider"); 
    const applyButton = document.getElementById("apply-button");
    const timeDisplay = document.getElementById("time-display");

    function formatTime(hours, minutes) {
        const formattedHours = hours < 10 ? `0${hours}` : hours;
        const formattedMinutes = minutes < 10 ? `0${minutes}` : minutes;
        return `${formattedHours}:${formattedMinutes}`;
    }

    if (timeSlider) {
        timeSlider.addEventListener('input', function() {
            const minutes = minuteSlider ? minuteSlider.value : 0;
            timeDisplay.innerHTML = formatTime(timeSlider.value, minutes);
        });
    }

    if (minuteSlider) {
        minuteSlider.addEventListener('input', function() {
            timeDisplay.innerHTML = formatTime(timeSlider.value, minuteSlider.value);
        });
    }

    const initialMinutes = minuteSlider ? minuteSlider.value : 0;
    timeDisplay.innerHTML = formatTime(timeSlider.value, initialMinutes);

    applyButton.addEventListener('click', function() {
        const selectedTime = timeSlider.value;
        const selectedMinute = minuteSlider ? minuteSlider.value : 0;
        
        // Captura o clima selecionado
        const weatherOptions = document.querySelectorAll('input[name="weather"]');
        let selectedWeather = 'CLEAR'; // Valor padrão
        
        weatherOptions.forEach(option => {
            if (option.checked) {
                selectedWeather = option.value;
            }
        });

        fetch(`https://${GetParentResourceName()}/applyTime`, {
            method: 'POST',
            body: JSON.stringify({ 
                time: parseInt(selectedTime, 10),
                minute: parseInt(selectedMinute, 10),
                weather: selectedWeather,
                blackout: 0 // Se precisar do blackout, adicione lógica aqui
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        });
    });
});

window.addEventListener('message', function(event) {
    if (event.data.type === "toggleNUI") {
        const displayStyle = event.data.display ? "block" : "none";
        document.querySelector('.nui').style.display = displayStyle;
    }
});

window.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        fetch(`https://${GetParentResourceName()}/toggleNUI`, {
            method: 'POST',
            body: JSON.stringify({ display: false }),
            headers: {
                'Content-Type': 'application/json'
            }
        });
    }
});
