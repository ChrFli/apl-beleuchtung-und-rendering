extends StaticBody3D

# Variable für die Interaktionssperre
var interactable = true
@export var audio_player: AudioStreamPlayer3D  # Referenz zum AudioStreamPlayer

# Interaktionsmethode
func interact():
	if interactable:
		interactable = false
		
		# MP3 abspielen, wenn sie nicht bereits abgespielt wird
		if not audio_player.playing:
			audio_player.play()
		
		# Timer abwarten, um die Interaktion wieder zu ermöglichen
		await get_tree().create_timer(0.5, false).timeout
		interactable = true

# Prozess-Logik, um auf die E-Taste zu reagieren
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):  # ui_accept ist standardmäßig auf E gemappt
		interact()
