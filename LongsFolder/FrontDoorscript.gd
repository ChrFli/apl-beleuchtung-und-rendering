extends StaticBody3D




# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true

signal Frontdoor_interacted
@export var playeranimation:AnimationPlayer
@onready var sfx_door: AudioStreamPlayer3D = $"../../sfx_door"
@onready var sfx_closedoor: AudioStreamPlayer3D = $"../../sfx_closedoor"



func interact():
	
	var player = get_tree().get_nodes_in_group("player")[0] 
	if player and player._haskey() and player._hasmasterkey():  # Check if player has the key
		if interactable ==true:
			interactable = false
			toggle = !toggle
			if toggle ==false:
				playeranimation.play("closedouble")
				sfx_closedoor.play()
			if toggle ==true:
				playeranimation.play("opendouble")
				sfx_door.play()
			await get_tree().create_timer(1.0,false).timeout
			interactable=true
	else:
		# Door can't be opened message
		print("The door can't be opened because you don't have the masterkey.")
		_notFrontopenlabel()



func _notFrontopenlabel():
	print("Emitting door_interacted signal")  # Debugging
	emit_signal("Frontdoor_interacted")  # Signal senden
