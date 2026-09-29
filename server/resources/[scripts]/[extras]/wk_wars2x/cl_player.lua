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

--[[----------------------------------------------------------------------------------
	Player info variables
----------------------------------------------------------------------------------]]--
PLY =
{
	ped = PlayerPedId(),
	veh = nil,
	inDriverSeat = false,
	inPassengerSeat = false,
	vehClassValid = false
}

-- Returns if the current vehicle fits the validity requirements for the radar to work
-- Retorna se o veículo atual atende aos requisitos de validade para o funcionamento do radar

function PLY:VehicleStateValid()
	return DoesEntityExist( self.veh ) and self.veh > 0 and self.vehClassValid
end

-- Used to check if the player is in a position where the radar should be allowed operation
-- Usado para verificar se o jogador está em uma posição onde o radar deveria ter permissão de operação

function PLY:IsDriver()
	return self:VehicleStateValid() and self.inDriverSeat
end

-- Returns if the player is in the front passenger seat of an emergency vehicle
-- Retorna se o jogador estiver no banco do passageiro dianteiro de um veículo de emergência

function PLY:IsPassenger()
	return self:VehicleStateValid() and self.inPassengerSeat
end

-- Returns if the player can view the radar, ensures their vehicle state is valid and that they are a driver or
-- a passenger (where valid)
-- Retorna se o jogador pode ver o radar, garante que o estado do veículo é válido e que ele é motorista ou
-- 	- um passageiro (quando válido)

function PLY:CanViewRadar()
	return self:IsDriver() or ( self:IsPassenger() and RADAR:IsPassengerViewAllowed() )
end

-- Returns if the player is allowed to control the radar from the passenger seat
-- Retorna se o jogador tiver permissão para controlar o radar do banco do passageiro

function PLY:CanControlRadar()
	return self:IsDriver() or ( self:IsPassenger() and RADAR:IsPassengerControlAllowed() )
end

-- Returns the ped in the opposite seat to the player, e.g. if we're the passenger, then return the driver
-- Retorna o ped no assento oposto ao jogador, por ex. se formos o passageiro, devolva o motorista

function PLY:GetOtherPed()
	if ( self:IsDriver() ) then
		return GetPedInVehicleSeat( PLY.veh, 0 )
	elseif ( self:IsPassenger() ) then
		return GetPedInVehicleSeat( PLY.veh, -1 )
	end

	return nil
end

-- Returns the server ID of the player in the opposite seat (driver/passenger)
function PLY:GetOtherPedServerId()
	local otherPed = self:GetOtherPed()

	if ( otherPed ~= nil and otherPed ~= 0 and IsPedAPlayer( otherPed ) ) then
		local otherPly = GetPlayerServerId( NetworkGetPlayerIndexFromPed( otherPed ) )

		return otherPly
	end

	return nil
end

-- The main purpose of this thread is to update the information about the local player, including their
-- ped id, the vehicle id (if they're in one), whether they're in a driver seat, and if the vehicle's class
-- is valid or not
Citizen.CreateThread( function()
	while ( true ) do
		PLY.ped = PlayerPedId()
		PLY.veh = GetVehiclePedIsIn( PLY.ped, false )
		PLY.inDriverSeat = GetPedInVehicleSeat( PLY.veh, -1 ) == PLY.ped
		PLY.inPassengerSeat = GetPedInVehicleSeat( PLY.veh, 0 ) == PLY.ped
		PLY.vehClassValid = GetVehicleClass( PLY.veh ) == 18

		Citizen.Wait( 500 )
	end
end )

-- This thread is used to check when the player is entering a vehicle and then triggers the sync system 
Citizen.CreateThread( function()
	while ( true ) do
		-- The sync trigger should only start when the player is getting into a vehicle
		if ( IsPedGettingIntoAVehicle( PLY.ped ) and RADAR:IsPassengerViewAllowed() ) then
			-- Get the vehicle the player is entering
			local vehEntering = GetVehiclePedIsEntering( PLY.ped )

			-- Only proceed if the vehicle the player is entering is an emergency vehicle
			if ( GetVehicleClass( vehEntering ) == 18 ) then
				-- Wait two seconds, this gives enough time for the player to get sat in the seat
				Citizen.Wait( 2000 )

				-- Get the vehicle the player is now in
				local veh = GetVehiclePedIsIn( PLY.ped, false )

				-- Trigger the main sync data function if the vehicle the player is now in is the same as the one they
				-- began entering
				if ( veh == vehEntering ) then
					SYNC:SyncDataOnEnter()
				end
			end
		end

		Citizen.Wait( 500 )
	end
end )