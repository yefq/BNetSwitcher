local path = os.getenv("TEMP"):match([[.*\AppData]]) .. [[\Roaming\Battle.net\Battle.net.config]]

local function findNames()
	for line in io.lines(path) do
		line = line:match([[%s*"SavedAccountNames": "(.*)",]])
		if line then
			local names = {}
			for name in line:gmatch([[([^,]*),?]]) do
				table.insert(names, name)
			end
			return names
		end
	end
end

local function saveNames(names)
	local output = ''
	for line in io.lines(path) do
		local tab = line:match([[(%s*)"SavedAccountNames": ".*",]])
		if tab then
			output = output .. string.format([[%s"SavedAccountNames": "%s",]], tab, names) .. '\n'
		else
			output = output .. line .. '\n'
		end
	end
	local file = io.open(path, 'w+')
	local result = file:write(output)
	io.close(file)
	return result
end

local function main()
	-- 选择账号:
	print("选择账号: ")
	local names = findNames()
	for i,name in ipairs(names) do
		print(string.format("[%d] %s", i, name))
	end
	print("")
	-- 用户输入:
	print("输入数字:")
	local i = io.read('*num') or 1
	print("")
	-- 账号置顶
	local user = table.remove(names, i)
	table.insert(names, 1, user)
	names = table.concat(names, ',')
	-- 完成
	if saveNames(names) then
		print(string.format("切换成功! (当前账号: %s)", user))
	else
		print("配置文件写入失败!")
	end
	print("")
end

main()
