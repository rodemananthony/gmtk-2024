extends CollisionShape2D

@onready var order_ui : PackedScene = preload("res://scenes/Main/order_ui.tscn")
var order_position_one = Vector2(-89.5,-298.5)
var order_position_two = Vector2(-89.5,-298.5 + 100)
var order_position_three = Vector2(-89.5,-298.5 + 200)
var order_position_four = Vector2(-89.5,-298.5 + 300)
var order_position_five = Vector2(-89.5,-298.5 + 400)
var order_positions : Array = [order_position_five, order_position_four, order_position_three, order_position_two, order_position_one]

var usable_catalog : Array = []
var complete_catalog : Array = []

func _on_timer_timeout() -> void:
	
	var catalog_length = len(usable_catalog)
	##print(catalog_length)
	var current_item = null
	var item = randi_range(0,catalog_length-1)
	
	for x in catalog_length:
		if x == item:
			current_item = usable_catalog[x]
			usable_catalog.remove_at(x)
			
			var item_info = current_item.get("item")
			var item_name = item_info.get("name")
			var item_weight = item_info.get("weight")
			#print(item_name)
			#print(item_weight)
			
			var order_position_length = len(order_positions)
			var new_order = order_ui.instantiate()
			var order_name_label = new_order.get_child(2)
			var order_weight_label = new_order.get_child(3)
			order_name_label.set("text", item_name)
			order_weight_label.set("text", item_weight)
			#print(order_label)
			
			for y in order_position_length:
				if y == order_position_length - 1:
					new_order.set_position(order_positions[y])
					order_positions.remove_at(y)
					add_child(new_order)


func _on_order_spawner_usable_catalog(current_catalog: Array) -> void:
	usable_catalog = current_catalog.duplicate()
	complete_catalog = current_catalog.duplicate()
	#print(usable_catalog)
