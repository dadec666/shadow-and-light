local SLE, T, E, L, V, P, G = unpack(select(2, ...))
local EVB = SLE.EnhancedVehicleBar
local AB = E.ActionBars
local LAB = LibStub('LibActionButton-1.0-ElvUI')
local Masque = LibStub('Masque', true)
local MasqueGroup = Masque and Masque:Group('ElvUI', 'ActionBars')

--GLOBALS: CreateFrame, hooksecurefunc, UIParent
local format = format
local RegisterStateDriver = RegisterStateDriver
local UnregisterStateDriver = UnregisterStateDriver
local GetVehicleBarIndex, GetOverrideBarIndex = GetVehicleBarIndex, GetOverrideBarIndex

-- Regular Button for these bars are 52. 52 * .71 = ~37.. I just rounded it up to 40 and called it good.
function EVB:Animate(bar, x, y, duration)
	bar.anim = bar:CreateAnimationGroup('Move_In')
	bar.anim.in1 = bar.anim:CreateAnimation('Translation')
	bar.anim.in1:SetDuration(0)
	bar.anim.in1:SetOrder(1)
	bar.anim.in2 = bar.anim:CreateAnimation('Translation')
	bar.anim.in2:SetDuration(duration)
	bar.anim.in2:SetOrder(2)
	bar.anim.in2:SetSmoothing('OUT')
	bar.anim.out1 = bar:CreateAnimationGroup('Move_Out')
	bar.anim.out2 = bar.anim.out1:CreateAnimation('Translation')
	bar.anim.out2:SetDuration(duration)
	bar.anim.out2:SetOrder(1)
	bar.anim.out2:SetSmoothing('IN')
	bar.anim.in1:SetOffset(x, y)
	bar.anim.in2:SetOffset(-x, -y)
	bar.anim.out2:SetOffset(x, y)
	bar.anim.out1:SetScript('OnFinished', function() bar:Hide() end)
end

function EVB:AnimSlideIn(bar)
	if not bar.anim then
		EVB:Animate(bar)
	end

	bar.anim.out1:Stop()
	bar.anim:Play()
end

function EVB:AnimSlideOut(bar)
	if bar.anim then
		bar.anim:Finish()
	end

	bar.anim:Stop()
	bar.anim.out1:Play()
end

function EVB:CreateExtraButtonSet()
	local bar = self.bar
	bar.buttons = {}
	local size = E.db.sle.actionbars.vehicle.buttonsize
	local spacing = E.db.sle.actionbars.vehicle.buttonspacing

	for i = 1, 7 do
		bar.buttons[i] = LAB:CreateButton(i, format(bar:GetName()..'Button%d', i), bar, nil)
		bar.buttons[i]:SetState(0, 'action', i)

		for k = 1, 14 do
			bar.buttons[i]:SetState(k, 'action', (k - 1) * 12 + i)
		end

		if i == 7 then
			bar.buttons[i]:SetState(12, 'custom', AB.customExitButton)
		end

		--Masuqe Support
		if MasqueGroup and E.private.actionbar.masque.actionbars then
			bar.buttons[i]:AddToMasque(MasqueGroup)
		end

		bar.buttons[i]:Size(size)

		if (i == 1) then
			bar.buttons[i]:SetPoint('BOTTOMLEFT', spacing, spacing)
		else
			bar.buttons[i]:SetPoint('LEFT', bar.buttons[i-1], 'RIGHT', spacing, 0)
		end

		AB:StyleButton(bar.buttons[i], nil, MasqueGroup and E.private.actionbar.masque.actionbars and true or nil)

		-- if E.db.actionbar.transparent then
		-- 	-- Disable this call if Masque is loaded
		-- 	if IsAddOnLoaded('Masque') then return end

		-- 	bar.buttons[i].backdrop:SetTemplate('Transparent')
		-- end

		bar.buttons[i]:SetCheckedTexture('')
		RegisterStateDriver(bar.buttons[i], 'visibility', '[vehicleui][overridebar][shapeshift][possessbar] show; hide')
	end
end

function EVB:PositionAndSizeBar()
	if not EVB.bar then return end
	local bar = EVB.bar

	local size = E.db.sle.actionbars.vehicle.buttonsize
	local spacing = E.db.sle.actionbars.vehicle.buttonspacing
	bar:SetWidth((size * 7) + (spacing * 6) + 4)
	bar:SetHeight(size + 4)

	for i, button in ipairs(bar.buttons) do
		button:Size(size)
		if (i == 1) then
			button:SetPoint('BOTTOMLEFT', 2, 2)
		else
			button:SetPoint('LEFT', bar.buttons[i-1], 'RIGHT', spacing, 0)
		end
	end
end

function EVB:CreateBar()
	local page = format('[overridebar] %d; [vehicleui] %d; [possessbar] %d; [shapeshift] 13;', GetOverrideBarIndex(), GetVehicleBarIndex(), GetVehicleBarIndex())
	local bindButtons = 'ACTIONBUTTON'

	local bar = CreateFrame('Frame', 'ElvUISL_EnhancedVehicleBar', E.UIParent, 'SecureHandlerStateTemplate')
	bar.id = 1
	EVB.bar = bar

	EVB:CreateExtraButtonSet()
	EVB:PositionAndSizeBar()
	-- EVB:BarBackdrop()
	-- bar:CreateBackdrop(AB.db.transparent and 'Transparent')
	bar:CreateBackdrop(AB.db.transparent and 'Transparent', nil, nil, nil, nil, nil, nil, nil, 0)

	bar:SetPoint('BOTTOM', 0, 34)
	bar:HookScript('OnShow', function(frame) self:AnimSlideIn(frame) end)
	RegisterStateDriver(bar, 'visibility', '[petbattle] hide; [vehicleui][overridebar][shapeshift][possessbar] show; hide')
	RegisterStateDriver(bar, 'page', page)

	bar:SetAttribute('_onstate-page', [[
		newstate = ((HasTempShapeshiftActionBar() and self:GetAttribute('hasTempBar')) and GetTempShapeshiftBarIndex()) or (UnitHasVehicleUI('player') and GetVehicleBarIndex()) or (HasOverrideActionBar() and GetOverrideBarIndex()) or newstate

		if newstate ~= 0 then
			self:SetAttribute('state', newstate)
			control:ChildUpdate('state', newstate)
		else
			local newCondition = self:GetAttribute('newCondition')
			if newCondition then
				newstate = SecureCmdOptionParse(newCondition)
				self:SetAttribute('state', newstate)
				control:ChildUpdate('state', newstate)
			end
		end
	]])

	EVB:Animate(bar, 0, -(bar:GetHeight()), 1)

	E:CreateMover(bar, 'EnhancedVehicleBar_Mover', L["Enhanced Vehicle Bar"], nil, nil, nil, 'ALL,S&L,S&L MISC', nil, 'sle, modules, actionbars, vehicle')

	AB:PositionAndSizeBar('bar1')
end

function EVB:Initialize()
	if not SLE.initialized then return end
	if not E.private.sle.vehicle.enable or not E.private.actionbar.enable then return end

	local visibility = '[petbattle] hide; [vehicleui][overridebar][shapeshift][possessbar] hide;'
	hooksecurefunc(AB, 'PositionAndSizeBar', function(_, barName)
		local bar = AB['handledBars'][barName]
		if (E.db.actionbar[barName].enabled) and (barName == 'bar1') then
			UnregisterStateDriver(bar, 'visibility')
			RegisterStateDriver(bar, 'visibility', visibility..E.db.actionbar[barName].visibility)
		end
	end)

	EVB:CreateBar()

	EVB.bar:Execute(EVB.bar:GetAttribute('_onstate-page'))

	function EVB:ForUpdateAll()
		EVB:PositionAndSizeBar()
		-- EVB:BarBackdrop()
	end
end

SLE:RegisterModule(EVB:GetName())
