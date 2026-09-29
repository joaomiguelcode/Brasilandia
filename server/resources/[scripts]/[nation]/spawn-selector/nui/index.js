var App = new Vue ({
    el: '#app',
    data: {
        menu: 0,
        places: [
           /*  {
                label: 'HypeTrain',
                sreetName : 'Lombadas',
                coords : { x : 171.2, y: -1003.47, z: 29.34},
                desc : 'Junte-se as pessoas localizadas em nosso maior ponto turistico'
            },
            {
                label: 'Sandy',
                sreetName : 'Lombadas',
                coords : { x: 426.69, y :-981.71, z: 30.7},
                desc : 'Cuidado com o tumultuo, muitas autoridades presentes no local.'
            },
            {
                label: 'Paleto',
                sreetName : 'Lombadas',
                coords : {x: 291.86, y: -575.48, z: 43.17},
                desc : 'Fique em silêncio pois muitos doentes la se encontram'
            }, */
            
        ],
        showingPlaces: [
            /* {
                label: 'HypeTrain',
                sreetName : 'Lombadas',
                coords : { x : 171.2, y: -1003.47, z: 29.34},
                desc : 'Junte-se as pessoas localizadas em nosso maior ponto turistico'
            },
            {
                label: 'Sandy',
                sreetName : 'Lombadas',
                coords : { x: 426.69, y :-981.71, z: 30.7},
                desc : 'Cuidado com o tumultuo, muitas autoridades presentes no local.'
            },
            {
                label: 'HospPaletoital',
                sreetName : 'Lombadas',
                coords : {x: 291.86, y: -575.48, z: 43.17},
                desc : 'Fique em silêncio pois muitos doentes la se encontram'
            }, */
        ],
        personalInfo: {
            lastLocation: '1577.47,578887.1477,1488.1000',
        },
        animationL: false,
        animationR: false,
        spawnAnimation: false,
      
    },
   
    methods: {
        loadSpawners(data){
            this.loadInfos()
            /* console.log(JSON.stringify(data))
            this.places = data
             */
        },
        loadInfos () {
          
            this.showingPlaces.splice(0, this.showingPlaces.length);
            this.showingPlaces.push(this.places[0], this.places[1], this.places[2])
        },
        changeInfos (index) {
            if (index == 0){
                this.animationL = true
            } else if (index == 2) {
                this.animationR = true
            } else if (index == 1) {
                return 0;
            }
            setTimeout(() => {
                if (index == 2){
                    let firstElement = this.places.shift()
                    this.places.push(firstElement)
                    this.loadInfos()
                } else if (index == 0) {
                    let lastElement = this.places.pop()
                    this.places.splice(0, 0, lastElement)
                    this.loadInfos()
                } else if (index == 1) {
                    return 0;
                }
                
                this.animationL = false
                this.animationR = false
            }, "900")
        },
        spawn () {
            this.spawnAnimation = true
            //let spawnLocation = this.showingPlaces[1].coords
            
            setTimeout(() => {
                this.menu = 0
            }, "900")
            axios.post('http://spawn-selector/selectSpawn',{
                mode : 1,
                coord : this.showingPlaces[1].coords
            })
        },
        openMenu(lastCoord,spawners){
            this.menu = 1
            this.places = spawners
            this.loadInfos(lastCoord)
        },
        spawnLastLocation () {
            this.spawnAnimation = true
           
            
            setTimeout(() => {
                this.menu = 0
            }, "900")
            axios.post('http://spawn-selector/selectSpawn',{
                mode : 0,
            })
        }
    },
    mounted () {
     
        

        window.addEventListener('message', ({data}) => {
            if (!data) return
            const [name,...args] = data;
            if (!App[name]) return
            App[name](...args)
         })
    },
})