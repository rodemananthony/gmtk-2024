extends CollisionShape2D

@onready var order_ui : PackedScene = preload("res://scenes/Main/order_ui.tscn")
var order_position_one = Vector2(-89.5,-298.5)
var order_position_two = Vector2(-89.5,-298.5 + 100)
var order_position_three = Vector2(-89.5,-298.5 + 200)
var order_position_four = Vector2(-89.5,-298.5 + 300)
var order_position_five = Vector2(-89.5,-298.5 + 400)
var order_positions : Array = [order_position_five, order_position_four, order_position_three, order_position_two, order_position_one]


func _on_timer_timeout() -> void:
	var order_position_length = len(order_positions)
	var new_order = order_ui.instantiate()
	for x in order_position_length:
		if x == order_position_length - 1:
			new_order.set_position(order_positions[x])
			order_positions.remove_at(x)
	add_child(new_order)
