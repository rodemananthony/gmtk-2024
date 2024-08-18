class_name Package
extends Control

@export var contents: Item
var selected = false
var rest_point
var rest_nodes = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 75
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
