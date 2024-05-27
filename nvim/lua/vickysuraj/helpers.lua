function Dump(data)
   if type(data) == 'table' then
      local s = '{ '
      for k,v in pairs(data) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. Dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(data)
   end
end

function Stringify(tableWithData)
    local result
    for key, value in pairs(tableWithData) do
        -- prepare json key-value pairs and save them in separate table
        print(key, value)
        table.insert(result, string.format("\"%s\":%s", key, value))
    end
    print(result)

    return "{" .. table.concat(result, ",") .. "}"
end

function Keyify(tableWithData)
    local result ={};
    local n =0
    for key, _ in pairs(tableWithData) do
        -- prepare json key-value pairs and save them in separate table
        n = n+1;
        result[n] = key;
    end

    return "{" .. Dump(result) .. "}"
end
