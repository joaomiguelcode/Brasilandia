let perguntas = []
let index = 0
let acertos = 0

window.addEventListener('message', function(event) {
    if (event.data.action === "open") {
        document.body.style.display = "flex"
        perguntas = event.data.perguntas
        index = 0
        acertos = 0
        carregarPergunta()
    }
})

function carregarPergunta() {
    document.getElementById("pergunta").innerText = perguntas[index].pergunta
    document.getElementById("resposta").value = ""
}

function proxima() {
    let resposta = document.getElementById("resposta").value.toLowerCase()

    if (resposta === perguntas[index].resposta) {
        acertos++
    }

    index++

    if (index < perguntas.length) {
        carregarPergunta()
    } else {
        fetch(`https://${GetParentResourceName()}/finalizar`, {
            method: "POST",
            body: JSON.stringify({ acertos: acertos })
        })

        document.body.style.display = "none"
    }
}