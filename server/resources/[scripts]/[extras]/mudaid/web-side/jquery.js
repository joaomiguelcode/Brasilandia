const isEnvBrowser = () => !(window).invokeNative

$(document).ready(function () {
    if (! isEnvBrowser()){
        // window.onload = () => {
        //       const link = document.createElement('link');
        //       link.href = 'index.css';
        //       link.rel = 'stylesheet';
        //       document.head.appendChild(link);
        // };
        let resourceName = (window).GetParentResourceName ? (window).GetParentResourceName(): "nui-frame-app";
        window.addEventListener('message', function (event) {
            let e = event.data;
            if (e.Action == "Open") {
                $('body').append(
                    `<div class="container">
                    <span class="tittle">MUDAR ID</span>
                    <div class="inputs">
                        <input type="number" id="id-antigo" class="input-id" placeholder="ID ANTIGO"></input>
                        <input type="number" id="id-new" class="input-id" placeholder="ID NOVO" ></input>
                    </div>
            
                    <div class="playersinfo">
                        <span id="name" class="text">Nome: Desconhecido</span>
                        <span id="bank" class="text">Banco: Desconhecido</span>
                        <span id="phone" class="text">Numero: Desconhecido</span>
                    </div>
                    <div class="buttons">
                        <button class="btn">Cancelar</button>
                        <button id="concluir" class="btn">Concluir</button>
                    </div>
                </div>`
                );
    
                $('.container').on('input', '#id-antigo', function () {
                    var id = $("#id-antigo").val();
                    $.post(`https://${resourceName}/getPlayerInfoById`, JSON.stringify({ id: id }), function (result) {
                        $('.playersinfo').empty();
                        $('.playersinfo').append(
                            `<span id="name" class="text">${result.name}</span>
                            <span id="bank" class="text">${result.bank}</span>
                            <span id="phone" class="text">${result.phone}</span>`
                        );
                    });
                });
                $('.container').on('click', '#concluir', function () {
                    var old_id = $("#id-antigo").val();
                    var new_id = $("#id-new").val();
                    $.post(`https://${resourceName}/UpdateId`, JSON.stringify({ old_id: old_id,new_id: new_id }), function (result) {   
                        
                    });
                });
    
    
                $('.container').on('click', '.btn', function () {
                    $.post(`https://${resourceName}/Close`,function () {   
                        $('body').empty();
                    });
                });
            };
    
    
            // $('.container').on('click', '.Apresentardocument', function () {
            // });
            // $('body').empty();
            // $('.modalabrirdocumento').remove();
            // $.each(DataDocuments, function (Index, Value) {
            // });
            // $.post("https://durateston_documents/setaprovedocument", JSON.stringify({ documentID: DocumentID }), function (result) {
            // });
            // $('.container').append(
            // );
        });
    }else{
        $('body').empty();
    }
});