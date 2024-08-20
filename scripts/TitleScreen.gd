extends Control


func _on_StartButton_pressed() -> void:
	#Start button redirects to the main scene on press
	get_tree().change_scene_to_file("res://scenes/test/catalog_test.tscn")



func _on_Quit_pressed() -> void:
	#Quit button exits game on press
	get_tree().quit()

var master_bus = AudioServer.get_bus_index("Master")

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
