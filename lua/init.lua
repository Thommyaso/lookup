local function create_floating_window(config, enter, filename)
	if enter == nil then
		enter = false
	end
	config = config or {}


	local temp_width = math.floor(vim.o.columns * 0.8)
	local temp_height = math.floor(vim.o.lines * 0.8)

	local width = temp_width
	local height = temp_height
	local row = math.floor((vim.o.lines - temp_height) / 2)
	local col = math.floor((vim.o.columns - temp_width) / 2)

	config.width = width
	config.height = height
	config.row = row
	config.col = col

	local buf = vim.api.nvim_create_buf(false, false) -- false = not listed, true = scratch buffer
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe") -- Wipe buffer on close

	local win = vim.api.nvim_open_win(buf, true, config)

	vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:Normal")
	vim.api.nvim_command("silent! edit /home/thomas/devilbox/data/www/lookup/lua/" ..filename)

	return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("Look", function ()
	create_floating_window({
		relative = "editor",
		border = "rounded",
	}, nil, 'quicklist.md')
end,
	{}
)
