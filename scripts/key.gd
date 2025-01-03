extends StaticBody3D

@onready var sfx_key: AudioStreamPlayer3D = $"../sfx_key"


var toggle = false
var interactable = true

func interact():
	if interactable:
		interactable = false
		toggle = !toggle

		# Find the player node in the "player" group
		var player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player

		if player:
			player.pick_up_key()  # Let the character know it picked up the key
			sfx_key.play()
			queue_free()  # Remove the key from the scene
			player.has_key = true  # Directly set the has_key status to true when the key is collected
		
		await get_tree().create_timer(1.0, false).timeout
		interactable = true
