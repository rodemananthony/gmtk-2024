extends Node2D

@onready var enemy = preload("res://scenes/Main/package.tscn")

func _on_timer_timeout() -> void:
	var ene = enemy.instantiate()
	ene.position = position
	get_parent().get_node("res://scenes/Main/package.tscn").add_child(ene)
	
