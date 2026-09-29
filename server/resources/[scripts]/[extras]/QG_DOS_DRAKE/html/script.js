let perguntas = []
let min_acertos = 2
let index = 0
let acertos = 0
let selectedAnswer = null

window.addEventListener('message', function(event) {
    if (event.data.action === "open") {
        document.body.style.display = "flex"
        document.getElementById("painel").style.display = "block"
        document.getElementById("notificacao").style.display = "none"
        perguntas = event.data.perguntas
        min_acertos = event.data.min_acertos || 2
        index = 0
        acertos = 0
        selectedAnswer = null
        carregarPergunta()
    }
})

document.addEventListener('keydown', function(event) {
    if (event.key === "Escape") {
        fecharPainel()
    }
})

function carregarPergunta() {
    selectedAnswer = null
    const perguntaAtual = perguntas[index]
    
    // Atualizar texto da pergunta
    document.getElementById("pergunta").innerText = perguntaAtual.pergunta
    
    // Atualizar contador
    document.getElementById("questionNumber").innerText = `QUESTÃO ${index + 1}/${perguntas.length}`
    
    // Atualizar progress bar
    const progress = ((index + 1) / perguntas.length) * 100
    document.getElementById("progress").style.width = progress + "%"
    
    // Gerar opções de resposta
    const answersContainer = document.getElementById("answersContainer")
    answersContainer.innerHTML = ""
    
    if (perguntaAtual.opcoes && perguntaAtual.opcoes.length > 0) {
        // Múltipla escolha
        perguntaAtual.opcoes.forEach((opcao, i) => {
            const answerDiv = document.createElement("div")
            answerDiv.className = "answer-option"
            answerDiv.onclick = () => selectAnswer(i, answerDiv)
            
            answerDiv.innerHTML = `
                <input type="radio" name="answer" id="answer${i}" value="${i}">
                <label for="answer${i}">${opcao}</label>
            `
            
            answersContainer.appendChild(answerDiv)
        })
    } else {
        // Resposta textual (fallback)
        const textInput = document.createElement("div")
        textInput.innerHTML = `
            <input type="text" id="resposta" placeholder="Digite sua resposta" style="width: 100%; padding: 15px; border-radius: 8px; border: 2px solid rgba(255,255,255,0.1); background: rgba(255,255,255,0.05); color: white; font-size: 14px;">
        `
        answersContainer.appendChild(textInput)
        
        // Adicionar event listener para input textual
        const inputElement = document.getElementById('resposta')
        if (inputElement) {
            inputElement.addEventListener('input', updateProximaButton)
        }
    }
    
    // Começar com botão desabilitado
    const btnProxima = document.querySelector('.btn-proxima')
    if (btnProxima) {
        btnProxima.disabled = true
    }
}

function selectAnswer(answerIndex, element) {
    // Remover seleção anterior
    document.querySelectorAll('.answer-option').forEach(opt => {
        opt.classList.remove('selected')
    })
    
    // Adicionar seleção atual
    element.classList.add('selected')
    selectedAnswer = answerIndex
    
    // Marcar radio button
    const radioBtn = document.getElementById(`answer${answerIndex}`)
    if (radioBtn) {
        radioBtn.checked = true
    }
    
    // Debug
    console.log('Resposta selecionada:', answerIndex, 'selectedAnswer:', selectedAnswer)
    
    // Habilitar botão próxima imediatamente
    const btnProxima = document.querySelector('.btn-proxima')
    if (btnProxima) {
        btnProxima.disabled = false
        console.log('Botão próxima habilitado')
    }
}

function updateProximaButton() {
    const btnProxima = document.querySelector('.btn-proxima')
    const hasSelection = selectedAnswer !== null || document.getElementById('resposta')?.value.trim() !== ''
    btnProxima.disabled = !hasSelection
}


function proxima() {
    let respostaCorreta = false
    const perguntaAtual = perguntas[index]
    
    // Verificar resposta
    if (perguntaAtual.opcoes && perguntaAtual.opcoes.length > 0) {
        // Múltipla escolha
        if (selectedAnswer !== null && perguntaAtual.resposta === selectedAnswer) {
            respostaCorreta = true
        }
    } else {
        // Resposta textual (fallback)
        let resposta = document.getElementById("resposta").value.toLowerCase()
        if (resposta === perguntaAtual.resposta.toLowerCase()) {
            respostaCorreta = true
        }
    }
    
    if (respostaCorreta) {
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

        document.getElementById("painel").style.display = "none"
        mostrarNotificacao(acertos)
    }
}

function mostrarNotificacao(acertos) {
    const notificacao = document.getElementById("notificacao")
    const titulo = document.getElementById("notificacao-titulo")
    const mensagem = document.getElementById("notificacao-mensagem")
    
    if (acertos >= min_acertos) {
        titulo.textContent = "APROVADO!"
        mensagem.textContent = `Você acertou ${acertos} de ${perguntas.length} perguntas. Parabéns!`
        notificacao.className = "notificacao aprovado"
    } else {
        titulo.textContent = "REPROVADO!"
        mensagem.textContent = `Você acertou apenas ${acertos} de ${perguntas.length} perguntas. Tente novamente!`
        notificacao.className = "notificacao reprovado"
    }
    
    notificacao.style.display = "block"
    
    // Auto-fechar após 5 segundos
    setTimeout(() => {
        fecharNotificacao()
    }, 5000)
}

function fecharPainel() {
    document.body.style.display = "none"
    document.getElementById("notificacao").style.display = "none"
    document.getElementById("painel").style.display = "none"
    
    // Enviar callback para o client liberar o NUI focus
    fetch(`https://${GetParentResourceName()}/fechar`, {
        method: "POST",
        body: JSON.stringify({})
    })
}

function fecharNotificacao() {
    document.getElementById("notificacao").style.display = "none"
    document.body.style.display = "none"
    
    // Enviar callback para o client liberar o NUI focus
    fetch(`https://${GetParentResourceName()}/fechar`, {
        method: "POST",
        body: JSON.stringify({})
    })
}
