extends StaticBody3D

var toggle = false
var interactable = true

signal pickedpaper

func interact():
	if interactable:
		interactable = false
		toggle = !toggle

		# Find the player node in the "player" group
		var player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player

		if player:
			player.pick_up_key()  # Let the character know it picked up the key
			  # Remove the key from the scene
			_pickeduppaper()
		
		
		await get_tree().create_timer(1.0, false).timeout
		interactable = true


func _pickeduppaper():
	emit_signal("pickedpaper")
