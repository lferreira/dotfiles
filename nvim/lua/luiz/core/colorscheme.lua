local status, nord = pcall(vim.cmd, "colorscheme nord")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
