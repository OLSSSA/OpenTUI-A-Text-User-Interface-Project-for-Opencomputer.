local os = require('os')
local term = require('term')
local shell = require('shell')
local component = require('component')
local filesystem = require('filesystem')

local Res_x,Res_y = component.gpu.getResolution() --get screen Resolution
local current_Path = '/' --Path

while true
do
	term.clear()
	term.setCursor((Res_x / 2 - 6),1)
	term.write('OpenTUIv0.01') --Basic Text User Interface
	term.setCursor((1,3))
	term.write('Your current postion is:' .. current_Path)
	term.setCursor(1,4)
	term.write('Files in this folder')
	term.setCursor(1,5)
	shell.execute('ls ' .. curren_Path)
	term.setCursor(1,Res_y - 3)
	term.write('----Terminal-------------------------------------------------------------------')
	term.setCursor(1,Res_y - 2)
	term.clearLine()
	term.setCursor(1,Res_y - 1)
	term.clearLine()
	term.setCursor(1,Res_y)
	term.clearLine()
	term.write('>')
	local Command = term.read() --Command System
	if string.lower(Command) == 'help\n' then
		term.clear()
		term.setCursor(1,1)
		term.write('This Program is using OpenOS`s CLI command.')
		term.setCursor(1,2)
		term.write('Try man [topic] for Help of CLI command.Use Exit to Exit this program')
		term.setCursor(1,3)
		term.write('Press Entre to Continue')
		term.read()
	elseif string.lower(Command) == 'exit\n' then
		term.clear()
		return
	elseif string.sub(Command,1,2) == 'cd' then
		local Length = string.len(Command) - 1
		local Move_Path = string.sub(Command,4,Length)
		if string.sub(Command,4,5) == '..' then
			current_Path = filesystem.path(current_Path)
		elseif string.sub(Command,4,4) == '.' then
			os.sleep(1)
		else:
			current_Path = current_Path .. Move_Path .. '/'
		end
	else
		term.clear()
		if filesystem.exists('/bin/' .. Command) then
			shell.execute(Command)	
		else
			shell.execute(current_Path .. Command)
		end
	end
end
