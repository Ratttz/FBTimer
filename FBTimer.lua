--Initializing variables

endgamenow = false
length = 18000
timerisrunning = false

--I recommend that you change the name of this script and "FBTimer_" within targetstate to the name of your event.
--By doing it this way, your players/users never have to overwrite or manage their savestates,
--provided that they are always given the current savestate and script.
targetstate = ("FBTimer_"..fba.gamename()..".fs")

--The following is a list of functions intended to be operated by the user via hotkeys

function addfive()
	if timerisrunning == false then
		length = length + 18000
	end
end
	
function subfive()
	if timerisrunning == false then
		length = length - 18000
	end
end

function endgame()
	if timerisrunning == true then
		endgamenow = true
		end
end

function newsavestate()
	newstate = savestate.create(targetstate)
	savestate.save(newstate)
	print("saved!")

end

function loadstate()
	if timerisrunning == false then
		savestate.load(targetstate)
		print("loaded")
		local newpad = joypad.read()
		newpad["P1 Start"] = true
		joypad.set(newpad)
	end
end

--registering those functions as hotkeys

input.registerhotkey(1, addfive)
input.registerhotkey(2, subfive)
input.registerhotkey(3, endgame)
input.registerhotkey(4, newsavestate)
input.registerhotkey(5, loadstate)

--Begin waiting on the player to do stuff

while joypad.read()["P1 Start"] == false do
	if length < 18000 then
		length = 18000
	end
    gui.text(50, 0, "Waiting for start...\nTimer set for "..5*(length/18000).." minutes.\nPress Hotkey 1 to add five minutes\nPress Hotkey 2 to deduct five minutes\nPress Hotkey 3 to end your run early.\nPress Hotkey 4 to save a state with default settings.\nPress Hotkey 5 to start your run from the saved state.")
	emu.frameadvance()
end

--They did stuff, start the timer.

start = emu.framecount()
timerisrunning = true

while (emu.framecount() - start) <= length and (endgamenow == false) do
	local timekeeper = ((emu.framecount() - start) .. " / " .. length)
	print("time elapsed: "..(emu.framecount() - start).."length: "..length)
	gui.text(50, 0, timekeeper)
	emu.frameadvance()
end

--End their run.

do
	gui.text(50, 0, "Congratulations on finishing your run!")
	gui.savescreenshot() --I do not know why this doesn't work, but if someone knows how to make it work, lemme know.
	fba.pause()
end
