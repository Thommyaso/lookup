print "hello there"

local M = {}

M.setup = function ()
	-- nothing 
end
local ts = vim.treesitter
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

	-- local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	--
	local buf = vim.api.nvim_create_buf(false, false) -- false = not listed, true = scratch buffer
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe") -- Wipe buffer on close

	local win = vim.api.nvim_open_win(buf, true, config)

	-- Set transparent background to avoid the black box effect
	vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:Normal")
	vim.api.nvim_command("silent! edit /home/thomas/Projects/lookup/lua/" ..filename)

	vim.keymap.set("n", "j",function ()
		local cursor_row , cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
		cursor_row = cursor_row - 1 -- Convert 1-based row to 0-based (Treesitter uses 0-based indexing)

		-- Get Treesitter parser & root tree
		local parser = ts.get_parser(buf, vim.bo.filetype)
		local tree = parser:parse()[1]
		local root = tree:root()

		-- local current_node = root:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)
		-- if not current_node then return end

		local node = root:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)
		if not node then return end

		while node do
			node = node:next_named_sibling() -- Move to the next node
			if node and node:type() == "atx_h1_marker" then
				-- Move the cursor to the found node
				local next_row, next_col = node:start()
				vim.api.nvim_win_set_cursor(0, { next_row + 1, next_col })
				return
			end
		end

		-- local next_node = current_node
		--
		-- if next_node and next_node:type() == "atx_h1_marker" then
		-- 	print(next_node)
		-- 	return next_node
		-- end
		-- -- end
		--
	end, {
			buffer = buf
		})

	return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("Look", function ()
	local test = create_floating_window({
		relative = "editor",
		border = "rounded",
		-- style = "minimal"
	}, nil, 'quicklist.md')
end,
	{}
)
-- M.start_lookup = function ()
--
-- end
