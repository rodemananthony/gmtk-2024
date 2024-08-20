extends CollisionShape2D

@onready var order_ui : PackedScene = preload("res://scenes/main/order_ui.tscn")
var order_position_one = Vector2(-89.5 + 77,-298.5 + 32)
var order_position_two = Vector2(-89.5 + 77,-298.5 + 100 + 32)
var order_position_three = Vector2(-89.5 + 77,-298.5 + 200 + 32)
var order_position_four = Vector2(-89.5 + 77,-298.5 + 300 + 32)
var order_position_five = Vector2(-89.5 + 77,-298.5 + 400 + 32)
var order_positions : Array = [order_position_one, order_position_two, order_position_three, order_position_four, order_position_five]

var usable_catalog : Array = []
var complete_catalog : Array = []
var catalog_for_packages : Array = []

var orders_in_scene : int = 0

signal package_catalog (array:Array)

func _ready() -> void:
	if orders_in_scene < 2:
		spawn_order()

func _on_timer_timeout() -> void:
	spawn_order()
	


func spawn_order():
	var catalog_length = len(usable_catalog)
	##print(catalog_length)
	var current_item = null
	var item = randi_range(0,catalog_length-1)
	
	for x in catalog_length:
		if x == item:
			current_item = usable_catalog[x]
			catalog_for_packages.append(usable_catalog[x])
			emit_signal("package_catalog", catalog_for_packages)
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
			
			if order_positions.is_empty() == false :
				new_order.set_position(order_positions[0])
				order_positions.remove_at(0)
				add_child(new_order)


func _on_order_spawner_usable_catalog(current_catalog: Array) -> void:
	if len(current_catalog) == 3:	
		usable_catalog.append(current_catalog[0])
		usable_catalog.append(current_catalog[1])
		usable_catalog.append(current_catalog[2])
	elif len(current_catalog) == 6:
		usable_catalog.append(current_catalog[3])
		usable_catalog.append(current_catalog[4])
		usable_catalog.append(current_catalog[5])
	elif len(current_catalog) == 10:
		usable_catalog.append(current_catalog[6])
		usable_catalog.append(current_catalog[7])
		usable_catalog.append(current_catalog[8])
		usable_catalog.append(current_catalog[9])

	complete_catalog = current_catalog.duplicate()
	for x in len(usable_catalog):
		print(usable_catalog[x].get("item").get("name"))



func _on_order_spawner_package_info(package_info: Package, ui_position: Vector2, ui_weight: float) -> void:
	var package_name = package_info.contents.name
	var ui_position_y = ui_position.y
	
	var catalog_length = len(complete_catalog)
	for x in catalog_length:
		if complete_catalog[x].get("item").get("weight") == ui_weight:
			usable_catalog.append(complete_catalog[x])
			
	if ui_position_y == order_position_one.y:
		order_positions.insert(0, order_position_one)
	elif ui_position_y == order_position_two.y:
		order_positions.insert(0, order_position_two)
	elif ui_position_y == order_position_three.y:
		order_positions.insert(0, order_position_three)
	elif ui_position_y == order_position_four.y:
		order_positions.insert(0, order_position_four)
	elif ui_position_y == order_position_five.y:
		order_positions.insert(0, order_position_five)
	
			#print(complete_catalog[x].get("item").get("name"))
	#print(test_one)
	#print(test_two)
