TOOL.Category   = "Main"
TOOL.Name       = "360° Recording"
TOOL.Command    = nil
TOOL.ConfigName	= nil
TOOL.Tab        = "Catmull-Rom CC 360°"

TOOL.ClientConVar["recording360_enable"] = "0"
TOOL.ClientConVar["recording360_key"] = "-1"
TOOL.ClientConVar["recording360_fov"] = "110"
TOOL.ClientConVar["recording360_step"] = "0"

function TOOL:LeftClick(trace)
	--return CatmullRomCams.SToolMethods.Layout.LeftClick(self, trace)
end

function TOOL:RightClick(trace)
	--return CatmullRomCams.SToolMethods.Layout.RightClick(self, trace)
end

function TOOL:Reload(trace)
	--return CatmullRomCams.SToolMethods.Layout.Reload(self, trace)
end

function TOOL:Think()
	--return CatmullRomCams.SToolMethods.Layout.Think(self)
end

function TOOL:ValidTrace(trace)
	return CatmullRomCams.SToolMethods.ValidTrace(trace)
end

function TOOL.BuildCPanel(panel)
	return CatmullRomCams.SToolMethods.Recording360.BuildCPanel(panel)
end