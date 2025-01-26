local M = {}

function M.manage_figures(command, title)
	local root = vim.b.vimtex.root
	if not root then
		vim.notify("Vimtex root not found")
		return
	end

	local figures_dir = root .. "/figures"

	local stat = vim.loop.fs_stat(figures_dir)
	if not stat or stat.type ~= "directory" then
		vim.notify("No figures directory found in the project root")
		return
	end

	local cmd
	if title then
		cmd = string.format("~/Projects/inkscape-figure-manager/target/debug/inkscape-figure-manager --%s %s %s", command, title, figures_dir)
	else
		cmd = string.format("~/Projects/inkscape-figure-manager/target/debug/inkscape-figure-manager --%s %s", command, figures_dir)
	end

	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()

	if result and #result > 0 then
		vim.api.nvim_put(vim.split(result, "\n"), "c", true, true)
	else
		vim.notify("Executed with no output")
	end
end

vim.keymap.set("n", "<C-f>", function()
	M.manage_figures("insert")
end, { noremap = true, silent = true })

vim.keymap.set("i", "<C-f>", function()
	local current_line = vim.api.nvim_get_current_line()
	if not current_line or #current_line == 0 then
		vim.notify("Current line is empty, cannot create a title")
		return
	end

	local title = current_line:gsub("%s", "-")

	vim.api.nvim_buf_set_lines(0, vim.fn.line(".") - 1, vim.fn.line("."), false, {})
	M.manage_figures("create", title)
end, { noremap = true, silent = true })

return M
