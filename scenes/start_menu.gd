extends Control


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/alpha_game.tscn")




func _on_controls_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/Controls.tscn")



func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/About.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
