--[[
	itemSorter.lua
		Inventory sorting support for Bagnon
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon')

local ItemSorter = {}
Bagnon.ItemSorter = ItemSorter

local ITEM_TYPE_ORDER = {
	Quest = 10,
	Weapon = 20,
	Armor = 21,
	Consumable = 30,
	Glyph = 40,
	Gem = 41,
	Recipe = 60,
	Container = 70,
	Miscellaneous = 90,
}

local TRADE_SUBTYPE_ORDER = {
	Cloth = 10,
	Leather = 20,
	['Metal & Stone'] = 30,
	Herb = 40,
	Elemental = 50,
	Enchanting = 60,
	Jewelcrafting = 70,
	Parts = 80,
	Devices = 81,
	Explosives = 82,
	Materials = 90,
	Meat = 100,
	Other = 999,
}

local CONSUMABLE_SUBTYPE_ORDER = {
	['Food & Drink'] = 10,
	Potion = 20,
	Elixir = 30,
	Flask = 31,
	Bandage = 40,
	Scroll = 50,
	['Item Enhancement'] = 60,
	Other = 999,
}

local RECIPE_SUBTYPE_ORDER = {
	Alchemy = 10,
	Blacksmithing = 20,
	Cooking = 30,
	Enchanting = 40,
	Engineering = 50,
	['First Aid'] = 60,
	Fishing = 70,
	Inscription = 80,
	Jewelcrafting = 90,
	Leatherworking = 100,
	Tailoring = 110,
}

local RULE_SECTION_ORDER = {
	quest = 10,
	equipment = 20,
	consumable = 30,
	glyph = 40,
	recipe = 60,
	container = 70,
	misc = 90,
	material = 50,
}

local RULE_FAMILY_ORDER = {
	cloth = 10,
	leather = 20,
	metal = 30,
	stone = 31,
	herb = 40,
	gem = 50,
	pearl = 51,
	elemental = 60,
	reagent = 70,
	engineering = 80,
	meat = 90,
	fish = 91,
	['healing-potion'] = 10,
	['mana-potion'] = 20,
	['hybrid-potion'] = 30,
	['utility-potion'] = 40,
	bandage = 50,
	scroll = 60,
	food = 70,
	drink = 71,
	charm = 80,
}

local GEM_SUBTYPE_ORDER = {
	Red = 10,
	Orange = 20,
	Yellow = 30,
	Green = 40,
	Blue = 50,
	Purple = 60,
	Meta = 70,
	Prismatic = 80,
	Simple = 90,
}

local EQUIP_LOC_ORDER = {
	INVTYPE_HEAD = 10,
	INVTYPE_NECK = 11,
	INVTYPE_SHOULDER = 12,
	INVTYPE_CLOAK = 13,
	INVTYPE_CHEST = 14,
	INVTYPE_ROBE = 15,
	INVTYPE_WRIST = 16,
	INVTYPE_HAND = 17,
	INVTYPE_WAIST = 18,
	INVTYPE_LEGS = 19,
	INVTYPE_FEET = 20,
	INVTYPE_FINGER = 21,
	INVTYPE_TRINKET = 22,
	INVTYPE_WEAPON = 30,
	INVTYPE_2HWEAPON = 31,
	INVTYPE_WEAPONMAINHAND = 32,
	INVTYPE_WEAPONOFFHAND = 33,
	INVTYPE_HOLDABLE = 34,
	INVTYPE_SHIELD = 35,
	INVTYPE_RANGED = 36,
	INVTYPE_THROWN = 37,
	INVTYPE_RELIC = 38,
	INVTYPE_TABARD = 50,
}

local MATERIAL_TIER_HINTS = {
	{'fel iron', 70},
	{'heavy borean', 75},
	{'light leather', 10},
	{'medium leather', 20},
	{'heavy leather', 30},
	{'thick leather', 40},
	{'rugged leather', 50},
	{'knothide', 60},
	{'borean', 70},
	{'arctic fur', 80},
	{'light hide', 10},
	{'medium hide', 20},
	{'heavy hide', 30},
	{'thick hide', 40},
	{'rugged hide', 50},
	{'linen', 10},
	{'wool', 20},
	{'silk', 30},
	{'mageweave', 40},
	{'runecloth', 50},
	{'netherweave', 60},
	{'frostweave', 70},
	{'copper', 10},
	{'tin', 20},
	{'bronze', 25},
	{'iron', 30},
	{'truesilver', 55},
	{'silver', 35},
	{'gold', 40},
	{'steel', 45},
	{'mithril', 50},
	{'thorium', 60},
	{'adamantite', 80},
	{'khorium', 85},
	{'cobalt', 90},
	{'saronite', 100},
	{'titanium', 110},
	{'rough stone', 10},
	{'coarse stone', 20},
	{'heavy stone', 30},
	{'solid stone', 40},
	{'dense stone', 50},
}

local MATERIAL_FAMILY_HINTS = {
	{'linen', 10},
	{'wool', 10},
	{'silk', 10},
	{'mageweave', 10},
	{'runecloth', 10},
	{'netherweave', 10},
	{'frostweave', 10},
	{'leather', 20},
	{'hide', 20},
	{'fur', 20},
	{'fel iron', 30},
	{'truesilver', 30},
	{'copper', 30},
	{'tin', 30},
	{'bronze', 30},
	{'iron', 30},
	{'silver', 30},
	{'gold', 30},
	{'steel', 30},
	{'mithril', 30},
	{'thorium', 30},
	{'adamantite', 30},
	{'khorium', 30},
	{'cobalt', 30},
	{'saronite', 30},
	{'titanium', 30},
	{'stone', 30},
	{'peacebloom', 40},
	{'silverleaf', 40},
	{'earthroot', 40},
	{'mageroyal', 40},
	{'briarthorn', 40},
	{'stranglekelp', 40},
	{'bruiseweed', 40},
	{'steelbloom', 40},
	{'grave moss', 40},
	{'kingsblood', 40},
	{'liferoot', 40},
	{'fadeleaf', 40},
	{'goldthorn', 40},
	{'khadgar', 40},
	{'wintersbite', 40},
	{'firebloom', 40},
	{'lotus', 40},
	{'tears', 40},
	{'sungrass', 40},
	{'blindweed', 40},
	{'ghost mushroom', 40},
	{'gromsblood', 40},
	{'sansam', 40},
	{'dreamfoil', 40},
	{'silversage', 40},
	{'plaguebloom', 40},
	{'icecap', 40},
	{'felweed', 40},
	{'dreaming glory', 40},
	{'ragveil', 40},
	{'flame cap', 40},
	{'terocone', 40},
	{'ancient lichen', 40},
	{'netherbloom', 40},
	{'nightmare vine', 40},
	{'mana thistle', 40},
	{'goldclover', 40},
	{'tiger lily', 40},
	{'talandra', 40},
	{'adder', 40},
	{'lichbloom', 40},
	{'icethorn', 40},
	{'dust', 60},
	{'essence', 60},
	{'shard', 60},
	{'crystal', 60},
}

local MATERIAL_PROGRESSIONS = {}

local function AddMaterialSequence(names, offset)
	for index, name in ipairs(names) do
		MATERIAL_PROGRESSIONS[string.lower(name)] = (offset or 0) + index * 10
	end
end

AddMaterialSequence({
	'Peacebloom', 'Silverleaf', 'Earthroot', 'Mageroyal', 'Briarthorn',
	'Stranglekelp', 'Bruiseweed', 'Wild Steelbloom', 'Grave Moss',
	'Kingsblood', 'Liferoot', 'Fadeleaf', 'Goldthorn', 'Khadgar\'s Whisker',
	'Wintersbite', 'Firebloom', 'Purple Lotus', 'Arthas\' Tears', 'Sungrass',
	'Blindweed', 'Ghost Mushroom', 'Gromsblood', 'Golden Sansam', 'Dreamfoil',
	'Mountain Silversage', 'Plaguebloom', 'Icecap', 'Black Lotus', 'Felweed',
	'Dreaming Glory', 'Ragveil', 'Flame Cap', 'Terocone', 'Ancient Lichen',
	'Netherbloom', 'Nightmare Vine', 'Mana Thistle', 'Goldclover', 'Tiger Lily',
	'Talandra\'s Rose', 'Adder\'s Tongue', 'Lichbloom', 'Icethorn', 'Frost Lotus',
})

AddMaterialSequence({
	'Strange Dust', 'Soul Dust', 'Vision Dust', 'Dream Dust', 'Illusion Dust',
	'Arcane Dust', 'Infinite Dust',
})

AddMaterialSequence({
	'Lesser Magic Essence', 'Greater Magic Essence', 'Lesser Astral Essence',
	'Greater Astral Essence', 'Lesser Mystic Essence', 'Greater Mystic Essence',
	'Lesser Nether Essence', 'Greater Nether Essence', 'Lesser Eternal Essence',
	'Greater Eternal Essence', 'Lesser Planar Essence', 'Greater Planar Essence',
	'Lesser Cosmic Essence', 'Greater Cosmic Essence',
}, 100)

AddMaterialSequence({
	'Small Glimmering Shard', 'Large Glimmering Shard', 'Small Glowing Shard',
	'Large Glowing Shard', 'Small Radiant Shard', 'Large Radiant Shard',
	'Small Brilliant Shard', 'Large Brilliant Shard', 'Small Prismatic Shard',
	'Large Prismatic Shard', 'Small Dream Shard', 'Dream Shard',
}, 250)

AddMaterialSequence({'Nexus Crystal', 'Void Crystal', 'Abyss Crystal'}, 400)

local function GetItemID(itemLink)
	return tonumber(itemLink and itemLink:match('item:(%d+)')) or 0
end

local function GetSortRule(itemID)
	return Bagnon.SortRules and Bagnon.SortRules[itemID]
end

local function GetItemTypeOrder(itemType)
	return ITEM_TYPE_ORDER[itemType or ''] or 100
end

local function GetRuleSectionOrder(rule)
	return rule and RULE_SECTION_ORDER[rule.section or ''] or nil
end

local function GetRuleFamilyOrder(rule)
	return rule and RULE_FAMILY_ORDER[rule.family or ''] or nil
end

local function GetSubtypeOrder(itemType, itemSubType)
	if itemType == 'Trade Goods' then
		return TRADE_SUBTYPE_ORDER[itemSubType or ''] or 500
	end

	if itemType == 'Gem' then
		return GEM_SUBTYPE_ORDER[itemSubType or ''] or 500
	end

	if itemType == 'Consumable' then
		return CONSUMABLE_SUBTYPE_ORDER[itemSubType or ''] or 500
	end

	if itemType == 'Recipe' then
		return RECIPE_SUBTYPE_ORDER[itemSubType or ''] or 500
	end

	return 0
end

local function GetEquipLocOrder(equipLoc)
	return EQUIP_LOC_ORDER[equipLoc or ''] or 999
end

local function IsProfessionMaterial(itemType)
	return itemType == 'Trade Goods' or itemType == 'Gem'
end

local function GetMaterialFamilyOrder(itemType, itemSubType, name)
	if itemType == 'Gem' then
		return 700 + GetSubtypeOrder(itemType, itemSubType)
	end

	local normalized = string.lower(name or '')
	for _, hint in ipairs(MATERIAL_FAMILY_HINTS) do
		if string.find(normalized, hint[1], 1, true) then
			return hint[2]
		end
	end

	return GetSubtypeOrder(itemType, itemSubType)
end

local function GetMaterialProgression(name, itemID, reqLevel, iLevel)
	local normalized = string.lower(name or '')
	local progression = MATERIAL_PROGRESSIONS[normalized]
	if progression then
		return progression
	end

	for _, hint in ipairs(MATERIAL_TIER_HINTS) do
		if string.find(normalized, hint[1], 1, true) then
			return hint[2]
		end
	end

	if reqLevel and reqLevel > 0 then
		return reqLevel
	end

	if iLevel and iLevel > 0 then
		return iLevel
	end

	return itemID or 0
end

local function GetConsumableFamilyOrder(itemSubType, name)
	local normalized = string.lower(name or '')
	if itemSubType == 'Potion' then
		if string.find(normalized, 'healing', 1, true) or string.find(normalized, 'health', 1, true) then
			return 10
		end
		if string.find(normalized, 'mana', 1, true) then
			return 20
		end
		if string.find(normalized, 'rejuvenation', 1, true) or string.find(normalized, 'restoration', 1, true) then
			return 30
		end
		if string.find(normalized, 'rage', 1, true) or string.find(normalized, 'energy', 1, true) then
			return 40
		end
		if string.find(normalized, 'protection', 1, true) or string.find(normalized, 'resistance', 1, true) then
			return 50
		end
		if string.find(normalized, 'swiftness', 1, true)
			or string.find(normalized, 'speed', 1, true)
			or string.find(normalized, 'invisibility', 1, true)
			or string.find(normalized, 'free action', 1, true) then
			return 60
		end
		return 70
	end

	return GetSubtypeOrder('Consumable', itemSubType)
end

local function GetFamilyOrder(itemType, itemSubType, equipLoc, name)
	if IsProfessionMaterial(itemType) then
		return GetMaterialFamilyOrder(itemType, itemSubType, name)
	end

	if itemType == 'Armor' then
		return GetEquipLocOrder(equipLoc)
	end

	if itemType == 'Consumable' then
		return GetConsumableFamilyOrder(itemSubType, name)
	end

	return GetSubtypeOrder(itemType, itemSubType)
end

local function GetProgressionOrder(itemType, itemSubType, name, itemID, reqLevel, iLevel)
	if IsProfessionMaterial(itemType) then
		return GetMaterialProgression(name, itemID, reqLevel, iLevel)
	end

	if reqLevel and reqLevel > 0 then
		return reqLevel
	end

	if iLevel and iLevel > 0 then
		return iLevel
	end

	return itemID or 0
end

local function IsRuleMaterial(rule)
	return rule and rule.section == 'material'
end

local function GetBagSortKey(bag)
	if bag == BACKPACK_CONTAINER then
		return 'normal'
	end

	local player = UnitName('player')
	local bagType = Bagnon.BagSlotInfo:GetBagType(player, bag)
	if bagType == 0 then
		return 'normal'
	end
	return 'special:' .. bag
end

local function IsSlotLocked(slot)
	local _, _, locked = GetContainerItemInfo(slot.bag, slot.slot)
	return locked
end

local function CompareItems(a, b)
	if a.typeOrder ~= b.typeOrder then
		return a.typeOrder < b.typeOrder
	end

	if a.familyOrder ~= b.familyOrder then
		return a.familyOrder < b.familyOrder
	end

	if a.progressionOrder ~= b.progressionOrder then
		return a.progressionOrder < b.progressionOrder
	end

	if a.equipOrder ~= b.equipOrder then
		return a.equipOrder < b.equipOrder
	end

	if a.subType ~= b.subType then
		return a.subType < b.subType
	end

	if a.quality ~= b.quality then
		return a.quality > b.quality
	end

	if a.iLevel ~= b.iLevel then
		return a.iLevel > b.iLevel
	end

	if a.name ~= b.name then
		return a.name < b.name
	end

	if a.count ~= b.count then
		return a.count > b.count
	end

	return a.itemID < b.itemID
end

local function CompareMaterials(a, b)
	if a.familyOrder ~= b.familyOrder then
		return a.familyOrder < b.familyOrder
	end

	if a.progressionOrder ~= b.progressionOrder then
		return a.progressionOrder < b.progressionOrder
	end

	if a.subtypeOrder ~= b.subtypeOrder then
		return a.subtypeOrder < b.subtypeOrder
	end

	if a.quality ~= b.quality then
		return a.quality < b.quality
	end

	if a.subType ~= b.subType then
		return a.subType < b.subType
	end

	if a.itemID ~= b.itemID then
		return a.itemID < b.itemID
	end

	if a.name ~= b.name then
		return a.name < b.name
	end

	return a.count > b.count
end

function ItemSorter:BuildInventoryRegions()
	local regions = {}
	local regionOrder = {}

	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local key = GetBagSortKey(bag)
		local region = regions[key]
		if not region then
			region = {}
			regions[key] = region
			table.insert(regionOrder, region)
		end

		for slot = 1, GetContainerNumSlots(bag) do
			table.insert(region, {bag = bag, slot = slot})
		end
	end

	return regionOrder
end

function ItemSorter:BuildItem(slot, index)
	local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(slot.bag, slot.slot)
	if not link then
		return nil, locked
	end

	local name, _, itemQuality, iLevel, reqLevel, itemType, itemSubType, _, equipLoc = GetItemInfo(link)
	local itemID = GetItemID(link)
	local rule = GetSortRule(itemID)
	local ruleSectionOrder = GetRuleSectionOrder(rule)
	local ruleFamilyOrder = GetRuleFamilyOrder(rule)
	return {
		id = index,
		bag = slot.bag,
		slot = slot.slot,
		count = count or 0,
		quality = itemQuality or quality or 0,
		iLevel = iLevel or 0,
		reqLevel = reqLevel or 0,
		name = name or link,
		subType = itemSubType or '',
		equipLoc = equipLoc or '',
		itemID = itemID,
		isMaterial = IsRuleMaterial(rule) or IsProfessionMaterial(itemType),
		typeOrder = ruleSectionOrder or GetItemTypeOrder(itemType),
		subtypeOrder = GetSubtypeOrder(itemType, itemSubType),
		familyOrder = ruleFamilyOrder or GetFamilyOrder(itemType, itemSubType, equipLoc, name),
		progressionOrder = (rule and rule.tier) or GetProgressionOrder(itemType, itemSubType, name, itemID, reqLevel, iLevel),
		equipOrder = GetEquipLocOrder(equipLoc),
	}, locked
end

function ItemSorter:BuildRegionPlan(slots, moves)
	local topItems = {}
	local bottomItems = {}
	local current = {}

	for index, slot in ipairs(slots) do
		local item, locked = self:BuildItem(slot, index)
		if locked then
			return nil, L.SortErrorLocked or 'Cannot sort bags while an item is locked.'
		end

		current[index] = item
		if item then
			if item.isMaterial then
				table.insert(bottomItems, item)
			else
				table.insert(topItems, item)
			end
		end
	end

	table.sort(topItems, CompareItems)
	table.sort(bottomItems, CompareMaterials)

	local desired = {}
	for index, item in ipairs(topItems) do
		desired[index] = item
	end

	local bottomStart = #slots - #bottomItems + 1
	for index, item in ipairs(bottomItems) do
		desired[bottomStart + index - 1] = item
	end

	for targetIndex = 1, #slots do
		local item = desired[targetIndex]
		if current[targetIndex] ~= item then
			local sourceIndex
			if item then
				for index = 1, #slots do
					if current[index] == item then
						local fixedItem = desired[index]
						if index == targetIndex or not(fixedItem and current[index] == fixedItem) then
							sourceIndex = index
							break
						end
					end
				end

				if sourceIndex and sourceIndex ~= targetIndex then
					table.insert(moves, {
						from = slots[sourceIndex],
						to = slots[targetIndex],
					})

					current[sourceIndex], current[targetIndex] = current[targetIndex], current[sourceIndex]
				end
			end
		end
	end

	return true
end

function ItemSorter:BuildPlan()
	if InCombatLockdown and InCombatLockdown() then
		return nil, L.SortErrorCombat or 'Cannot sort bags while in combat.'
	end

	if CursorHasItem and CursorHasItem() then
		return nil, L.SortErrorCursor or 'Cannot sort bags while holding an item.'
	end

	local moves = {}
	for _, slots in ipairs(self:BuildInventoryRegions()) do
		local ok, err = self:BuildRegionPlan(slots, moves)
		if not ok then
			return nil, err
		end
	end

	return moves
end

function ItemSorter:StartInventorySort()
	if self.running then
		Bagnon:Print(L.SortAlreadyRunning or 'Bag sorting is already running.')
		return
	end

	local moves, err = self:BuildPlan()
	if not moves then
		Bagnon:Print(err)
		return
	end

	if #moves == 0 then
		Bagnon:Print(L.SortComplete or 'Bags are already sorted.')
		return
	end

	self.queue = moves
	self.currentMove = nil
	self.running = true
	self.frame = self.frame or CreateFrame('Frame')
	self.frame:SetScript('OnUpdate', function() ItemSorter:OnUpdate() end)
	Bagnon:Print(format(L.SortStarted or 'Sorting %d bag moves.', #moves))
end

function ItemSorter:Stop(message)
	self.running = nil
	self.queue = nil
	self.currentMove = nil

	if self.frame then
		self.frame:SetScript('OnUpdate', nil)
	end

	if message then
		Bagnon:Print(message)
	end
end

function ItemSorter:OnUpdate()
	if not self.running then
		return
	end

	local move = self.currentMove
	if move then
		if IsSlotLocked(move.from) or IsSlotLocked(move.to) then
			return
		end
		self.currentMove = nil
	end

	move = table.remove(self.queue, 1)
	if not move then
		self:Stop(L.SortComplete or 'Bag sorting complete.')
		return
	end

	if IsSlotLocked(move.from) or IsSlotLocked(move.to) then
		table.insert(self.queue, 1, move)
		return
	end

	local targetHadItem = GetContainerItemInfo(move.to.bag, move.to.slot) and true or false

	PickupContainerItem(move.from.bag, move.from.slot)
	PickupContainerItem(move.to.bag, move.to.slot)

	if CursorHasItem and CursorHasItem() then
		if targetHadItem then
			PickupContainerItem(move.from.bag, move.from.slot)
		end
	end

	if CursorHasItem and CursorHasItem() then
		PickupContainerItem(move.from.bag, move.from.slot)
		self:Stop(L.SortErrorMove or 'Bag sorting stopped because an item could not be moved.')
		return
	end

	self.currentMove = move
end
