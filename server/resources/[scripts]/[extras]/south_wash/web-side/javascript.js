class MessageListener {
  eventHandlers = {};

  constructor() {
    window.addEventListener("message", (event) => {
      if (!event || !event.data || !event.data.action) return;

      const func = this.eventHandlers[event.data.action];
      if (func) func(event.data);
    });
  }

  addHandler(actionName, func) {
    this.eventHandlers[actionName] = async function (data) {
      func(data);
      if (actionName === "showTerminal") {
        initializeContent();
      }
    };
  }
}

const messageListener = new MessageListener();
let inTerminal = false;


const terminal = document.getElementById("terminal");
messageListener.addHandler("showTerminal", ({ data, time }) => {
  inTerminal = true;

  terminal.style.display = "flex";

  terminal.classList.remove("modal-exit");
  terminal.classList.add("modal-enter");

  // initializeContent(); // Reinicia o conteúdo quando o evento showTerminal é chamado
});

document.addEventListener('DOMContentLoaded', initializeContent);

document.onkeydown = function(evt) {
  evt = evt || window.event;
  var isEscape = false;
  if ("key" in evt) {
      isEscape = (evt.key === "Escape" || evt.key === "Esc");
  } else {
      isEscape = (evt.keyCode === 27);
  }
  if (isEscape && inTerminal) {
      inTerminal = false;
      terminal.classList.add("modal-exit");
      setTimeout(() => {
          terminal.style.display = "none";
          sendData('close', {});
      }, 350);
  }
};

function sendData(path, object) {
  fetch(`http://${GetParentResourceName()}/_${path}`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify(object),
  }).then().catch((e) => console.log(e, "[take a screenshot of the console and send it to the administrator]"));
}

function initializeContent() {
  const outputContainer = document.getElementById('outputContainer');
  const outputLines = [
    { text: '└╶ Estabelecendo conexão segura...', color: 'lime' },
    { text: '└╶╶ Autenticando usuário...', color: 'lime' },
    { text: '└╶╶╶ Bypassing firewalls...', color: 'lime' },
    { text: '└╶╶╶╶ Criptografando comunicações...', color: 'lime' },
    { text: '└╶╶╶╶╶ Acessando sistemas bancários...', color: 'lime' },
    { text: '└╶╶╶╶╶╶ Desviando rastreamento...', color: 'lime' },
    { text: '└╶╶╶╶╶╶╶ Ocultando localização...', color: 'lime' },
    { text: '└╶╶╶╶╶╶╶╶ Estabelecendo túnel de comunicação...', color: 'lime' },
    { text: '└╶╶╶╶╶╶╶╶╶ Infiltrando-se nos servidores darkweb...', color: 'lime' },
    { text: '└╶╶╶╶╶╶╶╶╶╶ Contornando protocolos de segurança...', color: 'lime' },
    { text: '└╶╶╶╶╶╶╶╶╶╶╶ Finalizando conexão segura...', color: 'lime' },
    { text: '└╶╶╶╶╶╶╶╶╶╶╶╶ Conexão estabelecida com sucesso!', color: 'lime' }
  ];

  function showOutputLines() {
    outputContainer.innerHTML = ''; // Limpa o conteúdo do container

    outputLines.forEach((line, index) => {
      setTimeout(() => {
        const outputLine = document.createElement('div');
        outputLine.className = 'kali-terminal-content uptext';
        outputLine.innerHTML = `<span class="kali-output" style="color: ${line.color}">${line.text}</span>`;
        outputContainer.appendChild(outputLine);
        outputContainer.scrollTop = outputContainer.scrollHeight; // Scroll automático para a parte inferior

        if (index === outputLines.length - 1) {
          // Última linha de saída, exibe o prompt de entrada
          showInputPrompt();
        }
      }, (index + 1) * 1000); // Atraso de 1,5 segundos entre cada linha (ajuste conforme necessário)
    });
  }
  
  function showInputPrompt() {
    const inputLine = document.createElement('div');
    inputLine.className = 'kali-terminal-content uptext';
    inputLine.innerHTML = '<span class="kali-prompt">$</span> <input type="text" id="moneyInput" placeholder="Valor a ser lavado: " />';
    outputContainer.appendChild(inputLine);
    outputContainer.scrollTop = outputContainer.scrollHeight; // Scroll automático para a parte inferior
  
    const moneyInput = document.getElementById('moneyInput');
    moneyInput.addEventListener('keydown', (event) => {
      if (event.key === 'Enter') {
        const money = moneyInput.value;
        if (parseFloat(money) > 0) {
          processMoney(money);
        }
      }
    });
  }
  
  function processMoney(money) {
  
    const inputLine = document.getElementById('moneyInput').parentNode;
    inputLine.innerHTML = `<span class="kali-prompt">$</span> <span class="kali-command">ls && chmod +x clearmoney.sh && ./clearmoney.sh && . ./clearmoney.sh && clearspecifymoney</span>`;
  
    setTimeout(() => {
      const startingLine = document.createElement('div');
      startingLine.className = 'kali-terminal-content uptext';
      startingLine.innerHTML = '<span class="kali-output" style="color: lime">└╶ Iniciando lavagem...</span>';
      outputContainer.appendChild(startingLine);
      outputContainer.scrollTop = outputContainer.scrollHeight; // Scroll automático para a parte inferior
  
      setTimeout(() => {
        const processingLine = document.createElement('div');
        processingLine.className = 'kali-terminal-content uptext';
        processingLine.innerHTML = '<span class="kali-output" style="color: lime">└╶╶ Processando...</span>';
        outputContainer.appendChild(processingLine);
        outputContainer.scrollTop = outputContainer.scrollHeight; // Scroll automático para a parte inferior
  
        setTimeout(() => {
          const processingLine = document.createElement('div');
          processingLine.className = 'kali-terminal-content uptext';
          processingLine.innerHTML = '<span class="kali-output" style="color: lime">└╶╶╶ Fechando...</span>';
          outputContainer.appendChild(processingLine);
          outputContainer.scrollTop = outputContainer.scrollHeight; // Scroll automático para a parte inferior
          
          inTerminal = false;
          document.getElementById("terminal").classList.add("modal-exit");
          setTimeout(() => {
              document.getElementById("terminal").style.display = "none";
              sendData('close', { money: money });
          }, 1000);
        }, 1000); // Delay de 3 segundos antes de adicionar a segunda linha
      }, 1000); // Delay de 15 segundos antes de adicionar a segunda linha
    }, 1000); // Delay de 3 segundos antes de adicionar a primeira linha
  }
  
  // Chamada da função para iniciar o processo de exibição gradual das linhas
  showOutputLines();
}