extends Area2D

signal usable_catalog (current_catalog:Array)

var current_catalog : Array = []
var complete_catalog : Array = []
var order_catalog : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_catalog_manager_catalog_items(catalog: Array) -> void:
	complete_catalog = catalog.duplicate()
	current_catalog = catalog.duplicate()
	order_catalog = catalog.duplicate()
	emit_signal("usable_catalog", order_catalog)
	#print(current_catalog)
