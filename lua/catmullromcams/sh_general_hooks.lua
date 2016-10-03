
if CLIENT then
	CatmullRomCams.CL.TunnelingTracer = {}
	--CatmullRomCams.CL.TunnelingTracer.mask = MASK_NPCWORLDSTATIC
	
	function CatmullRomCams.CL.CalcViewOverride(ply, origin, angles, fov)
		local weap = ply:GetActiveWeapon()
		
		local toolmode_active = (CatmullRomCams.SToolMethods.ToolObj and (GetConVar( "gmod_toolmode"):GetString() == "catmullrom_camera") and weap and weap:IsValid() and (weap:GetClass() == "gmod_tool"))
		local playing_track   = ply:GetNWEntity("UnderControlCatmullRomCamera") and ply:GetNWEntity("UnderControlCatmullRomCamera"):IsValid()
		
		if not (toolmode_active or playing_track) then return end
		
		local overrides = {}
		overrides.origin = origin
		overrides.angles = angles
		overrides.fov    = fov
		
		if playing_track then

			if (CatmullRomCams.SToolMethods.ToolObj:GetClientNumber("recording_360") == 1) then

				overrides.fov = CatmullRomCams.SToolMethods.ToolObj:GetClientNumber("recording_360_fov");
				overrides.angles.roll = 0;

				local step = CatmullRomCams.SToolMethods.ToolObj:GetClientNumber("recording_360_step");
				if (step == 1) then
					overrides.angles.yaw = 0;
					overrides.angles.pitch = 0;
				elseif (step == 2) then
					overrides.angles.yaw = -90;
					overrides.angles.pitch = 0;
				elseif (step == 3) then
					overrides.angles.yaw = -180;
					overrides.angles.pitch = 0;
				elseif (step == 4) then
					overrides.angles.yaw = -270;
					overrides.angles.pitch = 0;
				elseif (step == 5) then
					overrides.angles.yaw = 0;
					overrides.angles.pitch = 90;
				elseif (step == 6) then
					overrides.angles.yaw = 0;
					overrides.angles.pitch = -90;
				end

			else
				overrides.fov = ply.CatmullRomCamsTrackZoom or fov
			end

		else
			overrides.fov      =  CatmullRomCams.SToolMethods.ToolObj:GetClientNumber("zoom") or 75
			overrides.angles.r = (CatmullRomCams.SToolMethods.ToolObj:GetClientNumber("enable_roll") == 1) and CatmullRomCams.SToolMethods.ToolObj:GetClientNumber("roll") or angles.r
		end
		
		CatmullRomCams.CL.TunnelingTracer.start  = origin
		CatmullRomCams.CL.TunnelingTracer.endpos = origin-- + angles:Forward()
		
		return overrides
	end
	hook.Add("CalcView", "CatmullRomCams.CL.CalcViewOverride", CatmullRomCams.CL.CalcViewOverride)
	
	function CatmullRomCams.CL.HUDHide(element)
		local ply = LocalPlayer()
		
		if ply:GetNWEntity("UnderControlCatmullRomCamera") and ply:GetNWEntity("UnderControlCatmullRomCamera"):IsValid() then	
			return false
		end
	end
	hook.Add("HUDShouldDraw", "CatmullRomCams.CL.HUDHide", CatmullRomCams.CL.HUDHide)
	
	function CatmullRomCams.CL.BlackenScreenDuringTunneling()
		local ply = LocalPlayer()
		
		if ply:GetNWEntity("UnderControlCatmullRomCamera") and ply:GetNWEntity("UnderControlCatmullRomCamera"):IsValid() then
			local tr = util.TraceLine(CatmullRomCams.CL.TunnelingTracer)
			
			if (tr.FractionLeftSolid == 1) then--and (tr.Entity == ents.GetByIndex(0)) then
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(0, 0, ScrW(), ScrH())
			end
			
			--return true
		end
	end
	hook.Add("RenderScreenspaceEffects", "CatmullRomCams.CL.BlackenScreenDuringTunneling", CatmullRomCams.CL.BlackenScreenDuringTunneling)
else
	function CatmullRomCams.SH.Toggle(ply, ent, idx, buttoned)
		if ent and ply and ply.IsPlayer and ent.IsValid and ply:IsPlayer() and ent:IsValid() and (ent:GetClass() == "sent_catmullrom_camera") then
			return ent:Toggle(ply)
		end
	end
	numpad.Register("CatmullRomCamera_Toggle", CatmullRomCams.SH.Toggle)

	function CatmullRomCams.SH.GravGunPuntStopper(ply, ent)
		if ent and ent.IsValid and ent:IsValid() and (ent:GetClass() == "sent_catmullrom_camera") then
			return false
		end
	end
	hook.Add("GravGunPunt", "CatmullRomCams.SH.GravGunPuntStopper", CatmullRomCams.SH.GravGunPuntStopper)
end
