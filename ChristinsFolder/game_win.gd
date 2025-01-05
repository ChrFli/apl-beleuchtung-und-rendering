extends Control

@onready var sfx_win: AudioStreamPlayer2D = $sfx_win


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	sfx_win.play()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/StartMenu.tscn")
	



func _on_quit_pressed() -> void:
	get_tree().quit()
