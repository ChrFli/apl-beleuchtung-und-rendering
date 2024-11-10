extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var animation_player: AnimationPlayer

func interact():
	if interactable ==true:
		interactable = false
		toggle = !toggle
		if toggle ==false:
			animation_player.play("closedoor")
		if toggle ==true:
			animation_player.play("opendoor")
		await get_tree().create_timer(1.0,false).timeout
		interactable=true
