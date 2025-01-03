extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var animation_player: AnimationPlayer
@onready var sfx_door: AudioStreamPlayer3D = $"../../sfx_door"
@onready var sfx_closedoor: AudioStreamPlayer3D = $"../../sfx_closedoor"


func interact():
	# Find the player node in the "player" group (assuming you've added the player to this group in Chardummy.gd)
	var player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player

	if player and player._haskey():  # Check if player has the key
		if interactable:
			interactable = false
			toggle = !toggle
			if toggle == false:
				animation_player.play("closedoor")
				sfx_closedoor.play()
			if toggle == true:
				animation_player.play("opendoor")
				sfx_door.play()
				await get_tree().create_timer(1.0, false).timeout
			interactable = true
	else:
		# Door can't be opened message
		print("The door can't be opened because you don't have the key.")
