extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var animation_player: AnimationPlayer
@onready var sfx_portrait: AudioStreamPlayer3D = $"../../sfx_portrait"



func interact():
		if interactable:
			interactable = false
			toggle = !toggle
			if toggle == false:
				animation_player.play("closeportrait")
				sfx_portrait.play()
			if toggle == true:
				animation_player.play("openportrait")
				sfx_portrait.play()
			await get_tree().create_timer(0.5, false).timeout
			interactable = true
