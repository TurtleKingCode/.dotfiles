local table = {
	item1 = "value1",
	item2 = "value2",
}

-- file: table_file.lua

--goal: write the value of table into table_file.lua so that it can be required later

local function serialize(t)
  local s = "return {\n"
  for k, v in pairs(t) do
    s = s .. string.format("  %s = %q,\n", k, v)
  end
  s = s .. "}\n"
  return s
end

local info = debug.getinfo(1, "S")
local dir = info.source:sub(2):match("^(.*[/\\])") or ""
local filepath = dir .. "table_file.lua"

local f = assert(io.open(filepath, "w"))
f:write(serialize(table))
f:close()
