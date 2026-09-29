local Tunnel = module("vrp", "lib/Tunnel")

src = {}
Tunnel.bindInterface("keyboard", src)

local pendingForm
local inProgress = false

RegisterNUICallback("sendFormulary", function(cbData, cb)
	cb(true)

	SetNuiFocus(false, false)

	local formulary = cbData.formulary
	local data = {}
	for i, v in ipairs(formulary.rows) do
		data[i] = { input = v.value }
	end

	pendingForm:resolve(data)
end)

RegisterNUICallback("cancelFormulary", function(_, cb)
	cb(true)

	SetNuiFocus(false, false)
	pendingForm:resolve(false)
end)

RegisterNUICallback("hideFrame", function(_, cb)
	cb(true)
end)

RegisterNUICallback("getColors", function(_, cb)
	cb("FACCA")
end)

local function validateArray(Array)
	if not Array then return false end

	for i = 1, #Array do
		if not Array[i]?.input then return false end
	end
	return true
end

function showFormulary(form)
	if inProgress then return end

	for i, v in ipairs(form.rows) do
		v.id = i
	end

	inProgress = true
	SetNuiFocus(true, true)
	SendNUIMessage({ typeId = "setFormulary", payload = form })

	pendingForm = promise.new()

	local data = Citizen.Await(pendingForm)

	inProgress = false

	if data then
		return data
	end
	return false
end

function Password(First)
	local Array = showFormulary({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "password",
				placeholder = First,
				value = ""
			}
		}
	})

	if not validateArray(Array) then return false end
	return { Array[1].input }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIMARY
-----------------------------------------------------------------------------------------------------------------------------------------
function showSingleForm(First)
	local Array = showFormulary({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			}
		}
	})

	if not validateArray(Array) then return false end
	return { Array[1].input }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SECONDARY
-----------------------------------------------------------------------------------------------------------------------------------------
function showDoubleForm(First, Second)
	local Array = showFormulary({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},
			{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			}
		}
	})

	if not validateArray(Array) then return false end
	return { Array[1].input, Array[2].input }
end

function showTripleForm(First, Second, Third)
	local Array = showFormulary({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "text",
				placeholder = First,
				value = ""
			},
			{
				id = 2,
				mode = "text",
				placeholder = Second,
				value = ""
			},
			{
				id = 3,
				mode = "text",
				placeholder = Third,
				value = ""
			}
		}
	})

	if not validateArray(Array) then return false end
	return { Array[1].input, Array[2].input, Array[3].input }
end

function showReadOnlyForm(First, Value)
	showFormulary({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 0,
				mode = "area",
				placeholder = First,
				value = Value,
				readOnly = true,
			}
		}
	})

    lib.setClipboard(Value)

	return { Value }
end

function showTextAreaForm(First)
	local Array = showFormulary({
		title = "Formulário",
		subtitle = "Preencha os campos abaixo",
		rows = {
			{
				id = 1,
				mode = "area",
				placeholder = First,
				value = ""
			}
		}
	})

	if not validateArray(Array) then return false end
	return { Array[1].input }
end

src.keyWord = Password
src.keySingle = showSingleForm
src.keyDouble = showDoubleForm
src.keyTertiary = showTripleForm
src.keyArea = showTextAreaForm
src.keyCopy = showReadOnlyForm
