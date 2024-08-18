extends Button


func _on_StartButton_pressed() -> void:
	#Start button redirects to the main scene on press
	get_tree().change_scene_to_file("res://scenes/Main/main.tscn")



func _on_Quit_pressed() -> void:
	#Quit button exits game on press
	get_tree().quit()
