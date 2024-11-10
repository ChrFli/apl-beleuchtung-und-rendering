extends StaticBody3D
# script für die Animation der Tür beim Öffnen und Schließen
var toggle = false
var interactable= true
@export var animation_player: AnimationPlayer



func interact():
	# Find the player node in the "player" group (assuming you've added the player to this group in Chardummy.gd)
	var player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player

	if player and player._haskey():  # Check if player has the key
		if interactable:
			interactable = false
			toggle = !toggle
			if toggle == false:
				animation_player.play("closedoor")
			if toggle == true:
				animation_player.play("opendoor")
			await get_tree().create_timer(1.0, false).timeout
			interactable = true
	else:
		# Door can't be opened message
		print("The door can't be opened because you don't have the key.")
