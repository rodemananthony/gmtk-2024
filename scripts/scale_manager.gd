extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WeightLabel.text = "Weight: 0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_drop_zone_5_package_captured(package: Package) -> void:
	if package != null:
		var packageWeight = package.contents.weight
		var packageName = package.contents.name
		$WeightLabel.text = str("Weight: ", humanize_weight(packageWeight))
		#print(packageName,': ',packageWeight)
	else:
		$WeightLabel.text = "Weight: 0g"

func humanize_weight(weight: float) -> String:
	var significand: float = weight
	var new_label: String = str(significand) + "g"
	if significand >= 1000: # only do something special for anything 1000 grams or more
		var power_of_ten := floorf(log(significand)/log(10))
		significand /= 10.0 ** power_of_ten
		new_label = "%.2fe%dg" % [significand, int(power_of_ten)]
	
	return new_label
