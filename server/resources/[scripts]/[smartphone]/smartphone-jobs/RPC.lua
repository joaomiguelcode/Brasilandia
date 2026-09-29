emitNet = TriggerClientEvent or TriggerServerEvent
emit = TriggerEvent
local is_server = IsDuplicityVersion()

local last_id

function next_id()
  local id = (last_id or 0) + 1
  last_id = id
  return id
end

Main = {}
Net = setmetatable({ __callbacks={} }, {
  __index = function(o, name)
    o[name] = function(...)
      local id = next_id()
      local p = promise.new()
      o.__callbacks[id] = p

      local is_async = name:match('(.+)_async$')
      local args = { ... }
      table.insert(args, is_server and 2 or 1, id)
      table.insert(args, is_server and 3 or 2, is_async or name)

      emitNet('smartphone-jobs:req', table.unpack(args))

      if is_async then
        return p
      end

      return table.unpack(Citizen.Await(p))
    end
    return o[name]
  end
})

RegisterNetEvent('smartphone-jobs:res', function(id, ok, ...)
  local p = Net.__callbacks[id]
  if p then
    if ok then
      p:resolve({...})
    else
      p:reject(...)
    end
    Net.__callbacks[id] = nil
  end
end)

RegisterNetEvent('smartphone-jobs:req', function(id, name, ...)
  if is_server then
    local source = source
    local ok, err = pcall(Main[name], source, ...)
    emitNet('smartphone-jobs:res', source, id, ok, err) 
  else
    emitNet('smartphone-jobs:res', id, pcall(Main[name], ...))
  end
end)