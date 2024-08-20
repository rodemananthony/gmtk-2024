extends Control
var weight_label
var weight_needed : float = 0



func _ready() -> void:
	if self.get_tree() != null:
		weight_label = self.get_child(3)
		weight_needed = float(weight_label.text)
		#print(weight_needed)


# poor attempt at making a score counter
'''func add_correct_order():
	correct_orders += 1
	print(game_manager.correct_orders)'''

'''func add_wrong_order():
	wrong_orders = 1
	print(game_manager.wrong_orders)'''


func _on_drop_zone_package_captured(package: Package) -> void:
	if package != null:
		var package_weight = package.contents.weight
		
		if package_weight == weight_needed:
			#add_correct_order()
			print("right order")
			package.queue_free()
			
		elif package_weight != weight_needed:
			#add_wrong_order()
			print("wrong order")
			package.queue_free()
		#print(package_weight)
		
		self.queue_free()
