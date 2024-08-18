class_name ProgressItem
extends RefCounted

## Item progression tiers where value is required number of deliveries to reach that tier
enum Tier {
	NONE = 0, 
	TIER_1 = 10, 
	TIER_2 = 20, 
	TIER_3 = 30, 
	COMPLETE = 40
}

## The order tiers move in
const TIER_PROGRESSION_ORDER: Array[Tier] = [
	Tier.TIER_1,
	Tier.TIER_2,
	Tier.TIER_3,
	Tier.COMPLETE,
]


var item: Item
var delivery_count: int
var tier: Tier

signal tier_update(target, new_tier: Tier)

func _init(item: Item): 
	self.item = item
	delivery_count = 0
	tier = Tier.NONE

func increment_deliveries() -> void:
	delivery_count += 1
	
	# Update tier
	# Depends on being in insertion order
	for i in range(TIER_PROGRESSION_ORDER.size(), -1, -1):
		var i_tier: Tier = TIER_PROGRESSION_ORDER[i]
		
		if delivery_count >= i_tier:
			tier = i_tier
			tier_update.emit(tier)
			break
