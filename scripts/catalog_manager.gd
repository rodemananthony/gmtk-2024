class_name CatalogManager
extends Node

const _8X_10_TIBETAN_CARPET = preload("res://items/8x10 tibetan carpet.tres")
const CELLPHONE = preload("res://items/cellphone.tres")
const MOON = preload("res://items/moon.tres")
const PAPER_CLIP_BOX = preload("res://items/paper_clip_box.tres")
const SHIRT = preload("res://items/shirt.tres")
const SUN = preload("res://items/sun.tres")
const SUNGLASSES = preload("res://items/sunglasses.tres")
const TELEVISION = preload("res://items/television.tres")

signal catalog_items (catalog:Array)

## Dictionary of items added in each "page" of the catalog. 
## Can't nest Arrays in Arrays so this is a workaround 
const CATALOG_PAGES: Dictionary = {
	0: [PAPER_CLIP_BOX, SHIRT, SUN],
	1: [_8X_10_TIBETAN_CARPET, MOON, SUNGLASSES],
	2: [CELLPHONE, TELEVISION]
}

const CATALOG_ITEM_SCENE: PackedScene = preload("res://scenes/Main/catalog_item.tscn")

var current_catalog: Array[ProgressItem] = []

var page := 0

@onready var catalog_view: Control = %Catalog

func _ready() -> void:
	_add_page_inner(page)
	emit_signal("catalog_items", current_catalog)

func add_next_page() -> void:
	# Check if there are any more pages
	if not CATALOG_PAGES.has(page+1):
		push_warning("Tried to add a page when none exists")
		return
	
	page += 1
	_add_page_inner(page)
	emit_signal("catalog_items", current_catalog)

func _add_page_inner(page_number: int) -> void:
	# Should be Array[Item], typing system can't handle that
	var page_to_add: Array = CATALOG_PAGES.get(page_number, [])
	
	for item in page_to_add:
		var converted_item := ProgressItem.new(item)
		
		current_catalog.append(converted_item)
		
		var new_catalog_item_view = CATALOG_ITEM_SCENE.instantiate().with_data(converted_item)
		catalog_view.add_child(new_catalog_item_view)
