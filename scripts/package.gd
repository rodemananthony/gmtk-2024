class_name Package
extends Control

@export var contents: Item
var selected = false
var rest_point
var current_drop_zone: DropZone
var drop_candidate: DropZone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rest_point = self.global_position

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
			if drop_candidate != null:
				set_dropzone(drop_candidate)

func set_dropzone (dropzone: DropZone):
	var success := dropzone.collect_package(self)
	if success:
		# evacuate old drop zone
		if current_drop_zone != null:
			current_drop_zone.vacate()
		# update to new drop zone
		current_drop_zone = dropzone
		rest_point = dropzone.global_position
		drop_candidate = null
