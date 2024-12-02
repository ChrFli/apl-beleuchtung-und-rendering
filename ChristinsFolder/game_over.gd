extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/StartMenu.tscn")
	



func _on_quit_pressed() -> void:
	get_tree().quit()
