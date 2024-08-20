extends Control

const CATALOG_ITEM_SCENE: PackedScene = preload("res://scenes/main/catalog_item.tscn")
@onready var catalog_grid: HFlowContainer = $"Catalog Grid"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_new_item(item: ProgressItem) -> void:
	var item_node = CATALOG_ITEM_SCENE.instantiate().with_data(item)
	catalog_grid.add_child(item_node)
