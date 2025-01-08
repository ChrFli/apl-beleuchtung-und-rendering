extends StaticBody3D

@onready var sfx_musicbox: AudioStreamPlayer3D = $sfx_musicbox

var toggle = false
var interactable = true

func interact():
	if interactable:
		interactable = false
		toggle = !toggle

		# Find the player node in the "player" group
		var player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player

		if player:
			sfx_musicbox.play()  # Play the interaction sound

		# Optional: Add a delay before re-enabling interaction
		await get_tree().create_timer(1.0, false).timeout
		interactable = true
