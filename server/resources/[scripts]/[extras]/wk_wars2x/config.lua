--[[---------------------------------------------------------------------------------------

	Wraith ARS 2X
	Created by WolfKnight

	For discussions, information on future updates, and more, join
	my Discord: https://discord.gg/fD4e6WD

	MIT License

	Copyright (c) 2020-2021 WolfKnight

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

---------------------------------------------------------------------------------------]]--

-- Do not touch this
CONFIG = {}

-- Radar fast limit locking
-- When enabled, the player will be able to define a fast limit within the radar's menu, when a vehicle
-- exceeds the fast limit, it will be locked into the fast box. Default setting is disabled to maintain realism

-- Bloqueio de limite rápido de radar
-- Quando habilitado, o jogador poderá definir um limite rápido dentro do menu do radar, quando um veículo
-- exceder o limite rápido, ele será bloqueado na caixa rápida. A configuração padrão está desativada para manter o realismo
CONFIG.allow_fast_limit = true

-- Radar fast limit menu order
-- When enabled, the fast limit options menu will be displayed first followed by fast lock toggle, then all default menu options. 

-- Ordem do menu de limite rápido do radar
-- Quando ativado, o menu de opções de limite rápido será exibido primeiro, seguido pela alternância de bloqueio rápido e, em seguida, todas as opções de menu padrão.
CONFIG.fast_limit_first_in_menu = false

-- Radar only lock players with auto fast locking
-- When enabled, the radar will only automatically lock a speed if the caught vehicle has a real player in it.

-- - O radar bloqueia apenas jogadores com bloqueio rápido automático
-- - Quando ativado, o radar só bloqueará automaticamente uma velocidade se o veículo capturado contiver um jogador real.
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
CONFIG.allow_passenger_view = false

-- Allow passenger control
-- Dependent on CONFIG.allow_passenger_view. When enabled, the front seat passenger will be able to open the
-- radar remote and control the radar and plate reader for themself and the driver.

-- Permitir controle de passageiros
-- Dependente de CONFIG.allow_passenger_view. Quando ativado, o passageiro do banco dianteiro poderá abrir o
-- radar remoto e controlar o radar e o leitor de placas para si e para o motorista.
CONFIG.allow_passenger_control = false

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
	remote_control = "F5",

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

	-- Chave de bloqueio/desbloqueio frontal do leitor de placas
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
	-- Opções: 0,2, 0,4, 0,6, 0,8, 1,0
	["same"] = 0.6,
	["opp"] = 0.6,

	-- The volume of the audible beep
	-- Options: 0.0, 0.2, 0.4, 0.6, 0.8, 1.0

	-- O volume do sinal sonoro
	-- Opções: 0,0, 0,2, 0,4, 0,6, 0,8, 1,0
	["beep"] = 0.6,

	-- The volume of the verbal lock confirmation
	-- Options: 0.0, 0.2, 0.4, 0.6, 0.8, 1.0

	-- O volume da confirmação verbal do bloqueio
	-- Opções: 0,0, 0,2, 0,4, 0,6, 0,8, 1,0
	["voice"] = 0.6,

	-- The volume of the plate reader audio
	-- Options: 0.0, 0.2, 0.4, 0.6, 0.8, 1.0

	-- O volume do áudio do leitor de placas
	-- Opções: 0,0, 0,2, 0,4, 0,6, 0,8, 1,0
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
	-- Opções: 0 a 200
	["fastLimit"] = 60
}

-- Here you can change the default scale of the UI elements, as well as the safezone size

-- Aqui você pode alterar a escala padrão dos elementos da UI, bem como o tamanho da zona segura
CONFIG.uiDefaults =
{
	-- The default scale of the UI elements.
	-- Options: 0.25 - 2.5
	scale =
	{
		radar = 0.75,
		remote = 0.75,
		plateReader = 0.75
	},

	-- The safezone size, must be a multiple of 5.
	-- Options: 0 - 100
	safezone = 20
}