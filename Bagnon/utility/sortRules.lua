--[[
	sortRules.lua
		Item-ID sort rules for Project Epoch items seen in EpochDB exports.
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')

Bagnon.SortRules = {
	-- Cloth
	[2589] = {section = 'material', family = 'cloth', tier = 10}, -- Linen Cloth
	[2592] = {section = 'material', family = 'cloth', tier = 20}, -- Wool Cloth
	[4306] = {section = 'material', family = 'cloth', tier = 30}, -- Silk Cloth
	[14047] = {section = 'material', family = 'cloth', tier = 50}, -- Runecloth

	-- Leather, hides, and scales
	[2319] = {section = 'material', family = 'leather', tier = 20}, -- Medium Leather
	[4234] = {section = 'material', family = 'leather', tier = 30}, -- Heavy Leather
	[6470] = {section = 'material', family = 'leather', tier = 20}, -- Deviate Scale
	[4461] = {section = 'material', family = 'leather', tier = 30}, -- Raptor Hide

	-- Metal, ore, and stone
	[2840] = {section = 'material', family = 'metal', tier = 10}, -- Copper Bar
	[2775] = {section = 'material', family = 'metal', tier = 20}, -- Silver Ore
	[2842] = {section = 'material', family = 'metal', tier = 21}, -- Silver Bar
	[2841] = {section = 'material', family = 'metal', tier = 25}, -- Bronze Bar
	[3340] = {section = 'material', family = 'metal', tier = 30}, -- Incendicite Ore
	[3857] = {section = 'material', family = 'metal', tier = 35}, -- Coal
	[2772] = {section = 'material', family = 'metal', tier = 40}, -- Iron Ore
	[3575] = {section = 'material', family = 'metal', tier = 41}, -- Iron Bar
	[11370] = {section = 'material', family = 'metal', tier = 60}, -- Dark Iron Ore
	[3486] = {section = 'material', family = 'stone', tier = 30}, -- Heavy Grinding Stone

	-- Herbs
	[2447] = {section = 'material', family = 'herb', tier = 10}, -- Peacebloom
	[765] = {section = 'material', family = 'herb', tier = 20}, -- Silverleaf
	[2449] = {section = 'material', family = 'herb', tier = 30}, -- Earthroot
	[2452] = {section = 'material', family = 'herb', tier = 40}, -- Swiftthistle
	[2453] = {section = 'material', family = 'herb', tier = 70}, -- Bruiseweed
	[3357] = {section = 'material', family = 'herb', tier = 110}, -- Liferoot
	[8153] = {section = 'material', family = 'herb', tier = 200}, -- Wildvine

	-- Gems and pearls
	[774] = {section = 'material', family = 'gem', tier = 10}, -- Malachite
	[818] = {section = 'material', family = 'gem', tier = 20}, -- Tigerseye
	[1210] = {section = 'material', family = 'gem', tier = 30}, -- Shadowgem
	[1206] = {section = 'material', family = 'gem', tier = 40}, -- Moss Agate
	[1705] = {section = 'material', family = 'gem', tier = 50}, -- Lesser Moonstone
	[1529] = {section = 'material', family = 'gem', tier = 60}, -- Jade
	[7910] = {section = 'material', family = 'gem', tier = 80}, -- Star Ruby
	[5498] = {section = 'material', family = 'pearl', tier = 20}, -- Small Lustrous Pearl
	[5500] = {section = 'material', family = 'pearl', tier = 40}, -- Iridescent Pearl
	[7971] = {section = 'material', family = 'pearl', tier = 60}, -- Black Pearl
	[9262] = {section = 'material', family = 'gem', tier = 70}, -- Black Vitriol

	-- Meat, fish, and cooking materials
	[5469] = {section = 'material', family = 'meat', tier = 10}, -- Strider Meat
	[3173] = {section = 'material', family = 'meat', tier = 11}, -- Bear Meat
	[2674] = {section = 'material', family = 'meat', tier = 15}, -- Crawler Meat
	[3730] = {section = 'material', family = 'meat', tier = 20}, -- Big Bear Meat
	[3685] = {section = 'material', family = 'meat', tier = 22}, -- Raptor Egg
	[5504] = {section = 'material', family = 'meat', tier = 23}, -- Tangy Clam Meat
	[12202] = {section = 'material', family = 'meat', tier = 30}, -- Tiger Meat
	[6358] = {section = 'material', family = 'fish', tier = 20}, -- Oily Blackmouth

	-- Elemental and crafting reagents
	[7067] = {section = 'material', family = 'elemental', tier = 25}, -- Elemental Earth
	[7068] = {section = 'material', family = 'elemental', tier = 25}, -- Elemental Fire
	[7070] = {section = 'material', family = 'elemental', tier = 25}, -- Elemental Water
	[3182] = {section = 'material', family = 'reagent', tier = 20}, -- Spider's Silk
	[4337] = {section = 'material', family = 'reagent', tier = 35}, -- Thick Spider's Silk
	[8150] = {section = 'material', family = 'reagent', tier = 40}, -- Deeprock Salt
	[9060] = {section = 'material', family = 'engineering', tier = 42}, -- Inlaid Mithril Cylinder

	-- Consumables
	[858] = {section = 'consumable', family = 'healing-potion', tier = 10}, -- Lesser Healing Potion
	[929] = {section = 'consumable', family = 'healing-potion', tier = 20}, -- Healing Potion
	[1710] = {section = 'consumable', family = 'healing-potion', tier = 30}, -- Greater Healing Potion
	[2455] = {section = 'consumable', family = 'mana-potion', tier = 10}, -- Minor Mana Potion
	[2581] = {section = 'consumable', family = 'bandage', tier = 10}, -- Heavy Linen Bandage
	[6451] = {section = 'consumable', family = 'bandage', tier = 30}, -- Heavy Silk Bandage
	[954] = {section = 'consumable', family = 'scroll', tier = 20}, -- Scroll of Strength
	[1712] = {section = 'consumable', family = 'scroll', tier = 25}, -- Scroll of Spirit II
	[1708] = {section = 'consumable', family = 'drink', tier = 35}, -- Sweet Nectar
	[3772] = {section = 'consumable', family = 'drink', tier = 35}, -- Conjured Spring Water
	[6308] = {section = 'consumable', family = 'food', tier = 25}, -- Raw Bristle Whisker Catfish
	[6362] = {section = 'consumable', family = 'food', tier = 35}, -- Raw Rockscale Cod
	[3729] = {section = 'consumable', family = 'food', tier = 35}, -- Soothing Turtle Bisque
	[3771] = {section = 'consumable', family = 'food', tier = 35}, -- Wild Hog Shank
	[5342] = {section = 'consumable', family = 'food', tier = 18}, -- Raptor Punch
	[4479] = {section = 'consumable', family = 'charm', tier = 35}, -- Burning Charm
	[4481] = {section = 'consumable', family = 'charm', tier = 35}, -- Cresting Charm
}
