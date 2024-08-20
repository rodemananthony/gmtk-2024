extends Control
var weight_label
var weight_needed : float = 0



func _ready() -> void:
	if self.get_tree() != null:
		weight_label = self.get_child(3)
		weight_needed = float(weight_label.text)
		humanize_weight()
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

func humanize_weight():
	# Only do this if expected weight has been set
	if weight_label == null or is_zero_approx(weight_needed):
		return
	
	var significand: float = weight_needed
	var new_label: String = str(significand) + "g"
	if significand >= 1000: # only do something special for anything 1000 grams or more
		var power_of_ten := floorf(log(significand)/log(10))
		significand /= 10.0 ** power_of_ten
		new_label = "%.2fe%dg" % [significand, int(power_of_ten)]
	
	weight_label.text = new_label
	
