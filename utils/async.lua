--[[ bewlib.utils.async ]]--


-- Grab environement

-- Module dependencies
local lain_async = require("lain.asyncshell")

-- Module environement
local async = {}

function async.get_all(cmd, callback)
	lain_async.request(cmd, function(file_out)
		local stdout = file_out:read("*all")
		file_out:close()
		callback(stdout)
	end)
end

function async.get_line(cmd, lineNo, callback)
	lain_async.request(cmd, function(file_out)
		local i = 1
		local line = nil
		while i <= lineNo do
			line = file_out:read("*line")
			i = i + 1
		end
		file_out:close()
		callback(line)
	end)
end

function async.get_first_line(cmd, callback)
	lain_async.request(cmd, function(file_out)
		local line = file_out:read("*line")
		file_out:close()
		callback(line)
	end)
end

function async.just_exec(cmd, callback)
	lain_async.request(cmd, function(file_out)
		file_out:close()
		callback()
	end)
end

return setmetatable(async, { __call = async.just_exec })
