local STool = {}

CatmullRomCams.SToolMethods.Recording360  = STool

function STool.BuildCPanel(panel)
    panel:AddControl("CheckBox", {Label = "Enable 360° Recording: ", Command = "catmullrom_camera_recording360_enable"})
    panel:AddControl("Numpad",   {Label = "Start/Stop Recording Key: ", Command = "catmullrom_camera_recording360_key", ButtonSize = 22})
end