extends Node2D

@onready var package_scene: PackedScene = preload("res://scenes/main/package.tscn")

var current_catalog : Array = []
var complete_catalog : Array = []

func _ready() -> void:
	pass

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
		#print(new_package.contents.weight)
	


func _on_catalog_manager_catalog_items(catalog: Array) -> void:
	complete_catalog = catalog.duplicate()
	current_catalog = catalog.duplicate()
	#print(current_catalog)
