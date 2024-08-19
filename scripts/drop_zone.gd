## Area2D extension for collecting Packages
class_name DropZone
extends Area2D

signal package_captured(package: Package)

var captured_package: Package = null

## [code]true[/code] if circle should be draw around target
@export var show_debug := false
		
func _draw() -> void:
	if show_debug:
		var area_radius = get_child(0).shape.radius
		draw_circle(Vector2.ZERO, area_radius, Color.DARK_TURQUOISE)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	var receiver: Package = _get_valid_receiver(area)
	if receiver == null or captured_package != null:
		return
	
	receiver.drop_candidate = self


func _on_area_2d_area_exited(area: Area2D) -> void:
	var receiver: Package = _get_valid_receiver(area)
	if receiver != null and receiver.drop_candidate == self:
		receiver.drop_candidate = null

func _get_valid_receiver(area: Area2D) -> Package:
	var parent = area.get_parent()
	if parent is not Package:
		return null
	return parent
	
## Set DropZone info, returning true if operation is successful
func collect_package(package: Package) -> bool:
	if is_occupied():
		return false
		
	captured_package = package
	package_captured.emit(Package)
	return true

func vacate() -> bool:
	var had_package := is_occupied()
	captured_package = null
	return had_package

func is_occupied() -> bool:
	return captured_package != null
