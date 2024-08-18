extends Marker2D


func _draw() -> void:
	draw_circle(Vector2.ZERO, 75, Color.AQUAMARINE)
	
func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.BROWN

func deselect():
	modulate = Color.WHITE
