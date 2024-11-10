extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var playeranimation:AnimationPlayer

func interact():
	if interactable ==true:
		interactable = false
		toggle = !toggle
		if toggle ==false:
			playeranimation.play("closedouble")
		if toggle ==true:
			playeranimation.play("opendouble")
		await get_tree().create_timer(1.0,false).timeout
		interactable=true
