extends Control
var weight_label
var weight_needed : float = 0



func _ready() -> void:
	if self.get_tree() != null:
		weight_label = self.get_child(3)
		weight_needed = float(weight_label.text)
		#print(weight_needed)


func _on_drop_zone_package_captured(package: Package) -> void:
	if package != null:
		var package_weight = package.contents.weight
		
		if package_weight == weight_needed:
			var order_manager = get_parent().get_parent()
			order_manager.add_correct_order(package, self.position, weight_needed)
			#print(order_manager)
			#print("right order")
			package.queue_free()
			
		elif package_weight != weight_needed:
			var order_manager = get_parent().get_parent()
			order_manager.add_wrong_order(package, self.position, weight_needed)
			#print("wrong order")
			package.queue_free()
		#print(package_weight)
		
		self.queue_free()
