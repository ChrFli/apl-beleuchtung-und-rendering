extends MeshInstance3D

@onready var sfx_stairs: AudioStreamPlayer3D = $sfx_stairs

func _ready():
	if sfx_stairs.stream:
		sfx_stairs.stream.loop = true  # Loop aktivieren
	sfx_stairs.play()  # Audio abspielen
