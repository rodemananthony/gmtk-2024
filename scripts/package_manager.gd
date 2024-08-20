extends Node2D

@onready var package_scene: PackedScene = preload("res://scenes/main/package.tscn")


var drop_zones : Array = []
var current_catalog : Array = []
var complete_catalog : Array = []

func _ready() -> void:
	for x in len(get_parent().get_children()):
		var node = get_parent().get_child(x)
		if node.has_method("vacate"):
			drop_zones.append(node)
	#print(drop_zones)

func _on_timer_timeout() -> void:
	var catalog_length = len(current_catalog)
	##print(catalog_length)
	var current_item = null
	var item = randi_range(0,catalog_length-1)
	
	for x in catalog_length:
		if x == item:
			current_item = current_catalog[x]
			current_catalog.remove_at(x)
			#print(current_catalog)
			#print(complete_catalog)
	
	if current_item != null:
		var item_info = current_item.get("item")
		var new_package = package_scene.instantiate()
		new_package.set("contents", item_info)
		get_parent().add_child(new_package)
		for x in len(drop_zones):
			#print(drop_zones[x].is_occupied())
			if drop_zones[x].is_occupied() == false:
				var drop_zone : DropZone = drop_zones[x]
				#print(drop_zone)
				new_package.set_dropzone(drop_zone)
				#print(new_package.set_dropzone(drop_zone))
				break
		#print(new_package.contents.weight)
	


func _on_catalog_manager_catalog_items(catalog: Array) -> void:
	complete_catalog = catalog.duplicate()
	current_catalog = catalog.duplicate()
	#print(current_catalog)


func _on_order_spawner_package_info(package_info: Package, ui_position: Vector2, ui_weight: float) -> void:
	var package_name = package_info.contents.name
	
	var catalog_length = len(complete_catalog)
	for x in catalog_length:
		if complete_catalog[x].get("item").get("name") == package_name:
			current_catalog.append(complete_catalog[x])
