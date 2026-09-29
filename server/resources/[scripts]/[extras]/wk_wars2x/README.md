# Wraith ARS 2X
The **Wraith ARS 2X** (Wraith Advanced Radar System) is a realistic police radar that takes heavy inspiration from the real Stalker DSR 2X radar system. It includes a plethora of features from the DSR 2X such as the new operator menu, to improve the realism and experience whilst using the newest instalment from the collection of Wraith radar systems. Previously with WraithRS, vehicle speeds were only displayed in the target window, with no priority to certain vehicles (such as large and slower vehicles, or smaller and faster vehicles). The Wraith ARS 2X tracks both large and faster, smaller targets and displays the speeds of both in the target windows, meaning the radar can track 4 different speeds with both antennas turned on and transmitting. Alongside the new radar system is also a plate reader that scans in front and behind the patrol vehicle, a BOLO plate can also be set, but developers can also hook into the scanner to link it into other resources. 

## Installation
Installing the Wraith ARS 2X into your FiveM can be done by following the listed steps below. 
1. Download the latest version of the resource from [here](https://github.com/WolfKnight98/wk_wars2x/releases)
2. Open the zip file and place the `wk_wars2x` folder into your server's resource folder
3. Open up your server configuration file and add `ensure wk_wars2x` to your resource start list 

It's now installed! When you boot your server you should see a Wraith ARS 2X message as well as the version check message. 

## Default key binds
Although these can be viewed ingame through the operator manual, the default key binds are listed below. 
| Action                    | Key                       | Description |
| ------------------------- | ------------------------- | ----------- |
| Open remote               | F5                        | Opens the remote control, this only works if you are the driver of a police vehicle (must have the vehicle class VC_EMERGENCY). |
| Close remote              | ESC or right mouse button | Closes the remote/all of the displayed UI elements, and returns focus to the game. |
| Lock/unlock front antenna | Numpad 8                  | Locks the current speed of the front antenna. If there is a fast speed displayed, the system will lock the fast speed. Otherwise it will lock the strong speed. When you lock a speed, the radar will audibly tell you which antenna is being locked, and the relative direction of the target compared to the patrol vehicle (e.g. "Front Closing"). |
| Lock/unlock rear antenna  | Numpad 5                  | Locks the current speed of the rear antenna. If there is a fast speed displayed, the system will lock the fast speed. Otherwise it will lock the strong speed. When you lock a speed, the radar will audibly tell you which antenna is being locked, and the relative direction of the target compared to the patrol vehicle (e.g. "Rear Away"). |
| Lock/unlock front plate   | Numpad 9                  | Locks the plate currently caught by the front plate reader, an audible beep will also be heard unless the plate reader audio option in the operator menu is changed. |
| Lock/unlock rear plate    | Numpad 6                  | Locks the plate currently caught by the rear plate reader, an audible beep will also be heard unless the plate reader audio option in the operator menu is changed. |
| Toggle keylock            | L                         | Toggles the keylock state. When enabled, none of the keybinds will work until keylock is toggled again. |

## Script configuration
All of the configuration for the Wraith ARS 2X is done inside the `config.lua` file, below is a copy of the configuration file. All of the options have comments to describe what they do, along with the available options you can set. You have the ability to change the key binds for the large and small key set, the default operator menu options, and the default UI element scale and safezone. 
```lua
-- Radar fast limit locking
-- When enabled, the player will be able to define a fast limit within the radar's menu, when a vehicle
-- exceeds the fast limit, it will be locked into the fast box. Default setting is disabled to maintain realism

-- Bloqueio de limite rápido de radar
-- Quando habilitado, o jogador poderá definir um limite rápido dentro do menu do radar, quando um veículo
-- exceder o limite rápido, ele será bloqueado na caixa rápida. A configuração padrão está desativada para manter o realismo

CONFIG.allow_fast_limit = true

-- Radar only lock players with auto fast locking
-- When enabled, the radar will only automatically lock a speed if the caught vehicle has a real player in it.

-- O radar bloqueia apenas jogadores com bloqueio rápido automático
-- Quando ativado, o radar só bloqueará automaticamente uma velocidade se o veículo capturado contiver um jogador real.
CONFIG.only_lock_players = false

-- In-game first time quick start video
-- When enabled, the player will be asked if they'd like to view the quick start video the first time they
-- open the remote.

-- Vídeo de início rápido da primeira vez no jogo
-- Quando ativado, será perguntado ao jogador se deseja ver o vídeo de início rápido na primeira vez que
-- abra o controle remoto.
CONFIG.allow_quick_start_video = true

-- Allow passenger view
-- When enabled, the front seat passenger will be able to view the radar and plate reader from their end.

-- Permitir visão do passageiro
-- Quando ativado, o passageiro do banco dianteiro poderá visualizar o radar e o leitor de placas de sua extremidade.
CONFIG.allow_passenger_view = true

-- Allow passenger control
-- Dependent on CONFIG.allow_passenger_view. When enabled, the front seat passenger will be able to open the
-- radar remote and control the radar and plate reader for themself and the driver.

-- Permitir controle de passageiros
-- Dependente de CONFIG.allow_passenger_view. Quando ativado, o passageiro do banco dianteiro poderá abrir o
-- radar remoto e controlar o radar e o leitor de placas para si e para o motorista.
CONFIG.allow_passenger_control = true

-- Set this to true if you use Sonoran CAD with the WraithV2 plugin

-- Defina como verdadeiro se você usar o Sonoran CAD com o plugin WraithV2
CONFIG.use_sonorancad = false

-- Sets the defaults of all keybinds
-- These keybinds can be changed by each person in their GTA Settings->Keybinds->FiveM

-- Define os padrões de todos os atalhos de teclado
-- Esses atalhos de teclado podem ser alterados por cada pessoa em Configurações do GTA->Keybinds->FiveM
CONFIG.keyDefaults =
{
	-- Remote control key
	-- Chave de controle remoto
	remote_control = "f6",

	-- Radar key lock key
	-- Chave de bloqueio da chave do radar
	key_lock = "l",

	-- Radar front antenna lock/unlock Key
	-- Chave de bloqueio/desbloqueio da antena frontal do radar
	front_lock = "numpad8",

	-- Radar rear antenna lock/unlock Key
	-- Chave de bloqueio/desbloqueio da antena traseira do radar
	rear_lock = "numpad5",

	-- Plate reader front lock/unlock Key
	-- Chave de bloqueio/desbloqueio frontal do leitor de placas
	plate_front_lock = "numpad9",

	-- Plate reader rear lock/unlock Key
	-- Chave de bloqueio/desbloqueio traseiro do leitor de placas
	plate_rear_lock = "numpad6"
}

-- Here you can change the default values for the operator menu, do note, if any of these values are not
-- one of the options listed, the script will not work.

-- Aqui você pode alterar os valores padrão para o menu do operador, observe, se algum desses valores não for
-- uma das opções listadas, o script não funcionará.
CONFIG.menuDefaults =
{
	-- Should the system calculate and display faster targets
	-- Options: true or false

	-- O sistema deve calcular e exibir alvos mais rápidos
    -- Opções: verdadeiro ou falso
	["fastDisplay"] = true,

	-- Sensitivity for each radar mode, this changes how far the antennas will detect vehicles
	-- Options: 0.2, 0.4, 0.6, 0.8, 1.0
	-- Sensibilidade para cada modo de radar, isso altera a distância que as antenas detectarão veículos
-- - Opções: 0,2, 0,4, 0,6, 0,8, 1,0
	["same"] = 0.6,
	["opp"] = 0.6,

	-- The volume of the audible beep
	-- Options: 0.0, 0.2, 0.4, 0.6, 0.8, 1.0

	-- O volume do sinal sonoro
-- - Opções: 0,0, 0,2, 0,4, 0,6, 0,8, 1,0
	["beep"] = 0.6,

	-- The volume of the verbal lock confirmation
	-- Options: 0.0, 0.2, 0.4, 0.6, 0.8, 1.0

	-- O volume da confirmação verbal do bloqueio
-- - Opções: 0,0, 0,2, 0,4, 0,6, 0,8, 1,0
	["voice"] = 0.6,

	-- The volume of the plate reader audio
	-- Options: 0.0, 0.2, 0.4, 0.6, 0.8, 1.0

-- 	- O volume do áudio do leitor de placas
-- - Opções: 0,0, 0,2, 0,4, 0,6, 0,8, 1,0
	["plateAudio"] = 0.6,

	-- The speed unit used in conversions
	-- Options: mph or kmh

	-- A unidade de velocidade usada nas conversões
    -- Opções: mph ou kmh
	["speedType"] = "kmh",

	-- The state for automatic speed locking. This requires CONFIG.allow_fast_limit to be true.
	-- Options: true or false

	-- O estado para bloqueio automático de velocidade. Isso requer que CONFIG.allow_fast_limit seja verdadeiro.
    -- Opções: verdadeiro ou falso
	["fastLock"] = false,

	-- The speed limit required for automatic speed locking. This requires CONFIG.allow_fast_limit to be true.
	-- Options: 0 to 200

	-- O limite de velocidade necessário para o bloqueio automático de velocidade. Isso requer que CONFIG.allow_fast_limit seja verdadeiro.
-- - Opções: 0 a 200
	["fastLimit"] = 60
}

-- Here you can change the default scale of the UI elements, as well as the safezone size

-- Aqui você pode alterar a escala padrão dos elementos da UI, bem como o tamanho da zona segura
CONFIG.uiDefaults =
{
	-- The default scale of the UI elements.
	-- Options: 0.25 - 2.5

	-- A escala padrão dos elementos da UI.
	-- Opções: 0,25 - 2,5
	scale =
	{
		radar = 0.75,
		remote = 0.75,
		plateReader = 0.75
	},

	-- The safezone size, must be a multiple of 5.
	-- Options: 0 - 100

	-- O tamanho da zona segura deve ser um múltiplo de 5.
	-- Opções: 0 - 100
	safezone = 20
}
```

## Suggestions
If there is an improvement that you think should be made, open a pull request with your modified code, I will then review your request and either accept/deny it. Code in a pull request should be well formatted and commented, it will make it much easier for others to read and understand. In the event that you want to suggest something, but don't know how to code, open an issue with the enhancement tag and then fully describe your suggestion. 

Se houver uma melhoria que você acha que deveria ser feita, abra uma solicitação pull com seu código modificado, irei então revisar sua solicitação e aceitá-la/negá-la. O código em uma solicitação pull deve ser bem formatado e comentado, o que tornará muito mais fácil para outras pessoas lerem e entenderem. Caso você queira sugerir algo, mas não saiba codificar, abra um issue com a tag de aprimoramento e descreva detalhadamente sua sugestão.

## Reporting issues/bugs
Open an issue if you encounter any problems with the resource, if applicable, try to include detailed information on the issue and how to reproduce it. This will make it much easier to find and fix. 

Abra um problema se encontrar algum problema com o recurso, se for o caso, tente incluir informações detalhadas sobre o problema e como reproduzi-lo. Isso tornará muito mais fácil encontrar e corrigir.