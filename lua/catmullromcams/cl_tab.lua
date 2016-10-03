
function CatmullRomCams.CL.Tab()
	return spawnmenu.AddToolTab("Catmull-Rom Cinematic Cameras", "Catmull-Rom Cinematic Cameras", "gui/silkicons/camera")
end
hook.Add("AddToolMenuTabs", "CatmullRomCams.CL.Tab", CatmullRomCams.CL.Tab)
