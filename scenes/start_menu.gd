extends Control


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")




func _on_controls_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/Controls.tscn")



func _on_about_pressed() -> void:
	pass # Replace with function body.



func _on_quit_pressed() -> void:
	get_tree().quit()
