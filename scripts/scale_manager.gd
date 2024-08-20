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
		$WeightLabel.text = str("Weight: ", packageWeight)
		#print(packageName,': ',packageWeight)
	else:
		$WeightLabel.text = "Weight: 0"
