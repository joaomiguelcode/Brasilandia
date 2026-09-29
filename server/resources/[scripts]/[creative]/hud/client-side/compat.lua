-----------------------------------------------------------------------------------------------------------------------------------------
-- OX_LIB FALLBACK COMPATIBILITY
-----------------------------------------------------------------------------------------------------------------------------------------
lib = lib or {}

if not lib.string then
	lib.string = {}
	function lib.string.random(pattern)
		local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		local len = (pattern and type(pattern) == "string") and #pattern or 10
		local result = {}
		for i = 1, len do
			local r = math.random(1, #chars)
			result[i] = chars:sub(r, r)
		end
		return table.concat(result)
	end
end

if not lib.print then
	lib.print = {
		debug = function(...) end
	}
end

if not lib.setClipboard then
	function lib.setClipboard(text)
		SendNUIMessage({
			type = "clipboard",
			data = text
		})
	end
end
