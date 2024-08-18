extends Node2D

@onready var package_scene: PackedScene = preload("res://scenes/Main/package.tscn")

func _on_timer_timeout() -> void:
	var new_package = package_scene.instantiate()
	get_parent().add_child(new_package)
	
