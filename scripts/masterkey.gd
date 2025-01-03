extends StaticBody3D
@onready var sfx_masterkey: AudioStreamPlayer3D = $"../sfx_masterkey"

var toggle = false
var interactable = true

func interact():
	if interactable:
		interactable = false
		toggle = !toggle

		# Find the player node in the "player" group
		var player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player

		if player:
			player.pick_up_masterkey()  # Let the character know it picked up the key
			sfx_masterkey.play()
			queue_free()  # Remove the key from the scene
			player.has_masterkey = true  # Directly set the has_key status to true when the key is collected
		
		await get_tree().create_timer(1.0, false).timeout
		interactable = true
