extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var playeranimation:AnimationPlayer
@onready var sfx_door: AudioStreamPlayer3D = $"../../sfx_door"
@onready var sfx_closedoor: AudioStreamPlayer3D = $"../../sfx_closedoor"


signal door_opened
signal door_interacted

func _ready():
	add_to_group("door")
	
	


func interact():
	var player = get_tree().get_nodes_in_group("player")[0] 
	if player and player._haskey():  # Check if player has the key
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
			_dooropened()
			interactable=true
	else:
		# Door can't be opened message
		print("The door can't be opened because you don't have the key.")
		_notopenlabel()
		

func _dooropened():
	emit_signal("door_opened")
	

func _notopenlabel():
	print("Emitting door_interacted signal")  # Debugging
	emit_signal("door_interacted")  # Signal senden
