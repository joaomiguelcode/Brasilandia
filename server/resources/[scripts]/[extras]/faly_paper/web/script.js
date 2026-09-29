const { createApp } = Vue;
const app = createApp({
    data(){
        return{
            paper: {}
        }
    },
    methods: {
        open({paper}){
            this.paper = paper
            $("#app").fadeIn();
        },
        close(){
            $("#app").fadeOut()
            $.post("https://faly_paper/close");
        },
       
    },
    destroyed(){
        window.removeEventListener('message', this.listener);
    },
    mounted() {
        this.listener = window.addEventListener('message', (event) => {
            const item = event.data || event.detail;
            if (this[item.action]) {
              this[item.action](item);
            }
        });
        
        document.onkeyup = data => {
            if (data["key"] === "Escape"){
                this.close();
            }
        };
        
    }
}).mount("#app")