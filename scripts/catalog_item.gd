class_name CatalogItem
extends TextureRect

var item: ProgressItem

@onready var name_label: Label = $Name
@onready var weight_label: Label = $Weight

func with_data(item: ProgressItem):
	self.item = item
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = item.item.image
	name_label.text = item.item.name
	weight_label.text = humanize_weight(item.item.weight)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func humanize_weight(weight_grams: float) -> String:
	var significand: float = weight_grams
	var new_label: String = str(significand) + "g"
	if significand >= 1000: # only do something special for anything 1000 grams or more
		var power_of_ten := floorf(log(significand)/log(10))
		significand /= 10.0 ** power_of_ten
		new_label = "%.2fe%dg" % [significand, int(power_of_ten)]
	return new_label
