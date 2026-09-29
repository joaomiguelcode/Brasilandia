Config = {
    Control = 1,
    Comando = "Corte",
    Tempo = 100,

    Notificacoes = {
        Ativado = {
            Cor = "sucesso",
            Mensagem = "Cortagiro foi Ativado!"
        },
        Desativado = {
            Cor = "sucesso",
            Mensagem = "Cortagiro foi Desativado!"
        },
        VeiculoNaoAutorizado = {
            Cor = "negado",
            Mensagem = "Este veículo não está autorizado para usar o cortagiro."
        },
        SemVeiculo = {
            Cor = "negado",
            Mensagem = "Você precisa estar dentro de um veículo para usar o cortagiro."
        }
    },

    Particulas = {
        tipo = "bone",
        particle = "veh_backfire",
        particle_asset = "core",
        particle_size = 3.5,

        Lista = {
            ["Fogo"] = {tipo = "bone", particle = "veh_backfire", asset = "core", size = 3.5},
            ["Turbo"] = {tipo = "bone", particle = "veh_exhaust_afterburner", asset = "core", size = 4.0},
            ["Fumaca"] = {tipo = "coord", particle = "scr_rcbarry2_car_smoke", asset = "core", size = 5.0},
            ["Fogos"] = {tipo = "coord", particle = "scr_indep_firework_starburst", asset = "scr_indep_fireworks", size = 5.0}
        }
    },

    Veiculos = {
        "kuruma",
        "kuruma2",
        "adder",
        "2f2fgts",
        "t20",
        "nissangtr",
        "bf400",
        "t800",
        "s25",
        "titan25eterno",
        "1200explorer",
        "r1200",
        "f900",
        "bajajdk",
        "yamahar1"
    }
}
