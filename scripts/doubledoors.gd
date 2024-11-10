extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var playeranimation:AnimationPlayer

func interact():
	var player = get_tree().get_nodes_in_group("player")[0] 
	if player and player._haskey():  # Check if player has the key
		if interactable ==true:
			interactable = false
			toggle = !toggle
			if toggle ==false:
				playeranimation.play("closedouble")
			if toggle ==true:
				playeranimation.play("opendouble")
			await get_tree().create_timer(1.0,false).timeout
			interactable=true
	else:
		# Door can't be opened message
		print("The door can't be opened because you don't have the key.")
