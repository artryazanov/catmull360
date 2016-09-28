
function CatmullRomCams.CL.Tab()
	return spawnmenu.AddToolTab("Catmull-Rom CC 360°", "Catmull-Rom CC 360°", "gui/silkicons/camera")
end
hook.Add("AddToolMenuTabs", "CatmullRomCams.CL.Tab", CatmullRomCams.CL.Tab)
