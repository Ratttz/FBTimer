endgamenow = false
length = 18000

function addfive()
	length = length + 18000
end
	
function subfive()
	length = length - 18000
end

function endgame()
	endgamenow = true
end

input.registerhotkey(1, addfive)
input.registerhotkey(2, subfive)
input.registerhotkey(3, endgame)


while joypad.read()["P1 Start"] == false do
	if length < 18000 then
		length = 18000
	end
    gui.text(50, 0, "Waiting for start...\nTimer set for "..5*(length/18000).." minutes.\nPress Hotkey 1 to add five minutes\nPress Hotkey 2 to deduct five minutes\nPress Hotkey 3 to end your run early.")
	emu.frameadvance()
end

start = emu.framecount()


while (emu.framecount() - start) <= length and (endgamenow == false) do
	local timekeeper = ((emu.framecount() - start) .. " / " .. length)
	print("time elapsed: "..(emu.framecount() - start).."length: "..length)
	gui.text(50, 0, timekeeper)
	emu.frameadvance()
end

do
	gui.text(50, 0, "Congratulations on finishing your run!")
	gui.savescreenshot() --I do not know why this doesn't work, but if someone knows how to make it work, lemme know.
	fba.pause()
end