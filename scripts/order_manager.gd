extends Area2D

signal usable_catalog (current_catalog:Array)

var current_catalog : Array = []

var complete_catalog : Array = []
var order_catalog : Array = []
var package_catalog : Array = []

var correct_orders : int = 0
var order_score : int = 0

signal display_score (score:int)
signal package_info (package_info:Package, ui_position:Vector2, ui_weight:float)
signal catalog_to_choose_from (package_catalog : Array)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_correct_order(package:Package, ui_position:Vector2, ui_weight:float):
	if correct_orders < 8:
		correct_orders += 1
	if correct_orders == 3:
		%"Catalog Manager".add_next_page()
		correct_orders +=1
	elif correct_orders == 7:
		%"Catalog Manager".add_next_page()
		correct_orders +=1
	
	order_score += 1
	#print(ui_position)
	emit_signal("display_score", order_score)
	emit_signal("package_info", package, ui_position, ui_weight)
	#print("Order Score: ", order_score)

func add_wrong_order(package:Package, ui_position:Vector2, ui_weight: float):
	if order_score > 0:
		order_score -= 1
	#print(ui_position)
	emit_signal("display_score", order_score)
	emit_signal("package_info", package, ui_position, ui_weight)
	#print("Order Score: ",order_score)

func _on_catalog_manager_catalog_items(catalog: Array) -> void:
	complete_catalog = catalog.duplicate()
	current_catalog = catalog.duplicate()
	#complete_catalog = catalog.duplicate()
	order_catalog = catalog.duplicate()
	emit_signal("usable_catalog", order_catalog)
	#print(complete_catalog)


func _on_collision_shape_2d_package_catalog(array: Array) -> void:
	package_catalog = array.duplicate()
	emit_signal("catalog_to_choose_from", package_catalog)
