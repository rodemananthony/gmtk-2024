extends Control

var weight_label
var weight_needed : float = 0

signal correct_order ()

func _ready() -> void:
	if self.get_tree() != null:
		weight_label = self.get_node("NameLabel")
		weight_needed = float(weight_label.text)
		#print(weight_needed)


func _on_drop_zone_package_captured(package: Package) -> void:
	if package != null:
		var package_weight = package.contents.weight
		
		if package_weight == weight_needed:
			var test_var = %"Catalog Manager"
			test_var.add_correct_order()
			print("right order")
			package.queue_free()
			
		elif package_weight != weight_needed:

			print("wrong order")
			package.queue_free()
		#print(package_weight)
		
		self.queue_free()
