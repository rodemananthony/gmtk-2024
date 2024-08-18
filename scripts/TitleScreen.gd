extends Button


func _on_StartButton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main/main.tscn")
	pass # Replace with function body.


func _on_Quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
