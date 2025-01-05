extends StaticBody3D  # Das Hauptobjekt ist ein StaticBody3D

@export var interact_key = "E"  # Die Taste, die der Spieler drücken muss
@onready var audio_player = $AudioStreamPlayer3D  # Verweis auf die AudioStreamPlayer-Node
@onready var detection_area = $Area3D  # Verweis auf die Area3D-Node

var is_player_near: bool = false  # Flag, ob der Spieler in der Nähe ist


func _ready():
	# Signale der Area3D verbinden
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	# Prüfen, ob der Spieler in der Nähe ist und die Interaktionstaste drückt
	if is_player_near and Input.is_action_just_pressed(interact_key):
		interact()

func interact():
	# Musik abspielen oder neu starten
	if audio_player.is_playing():
		audio_player.stop()  # Stoppe die Wiedergabe, falls sie läuft
	audio_player.play()  # Starte die Wiedergabe neu

func _on_body_entered(body):
	# Überprüfen, ob das eintretende Objekt zur Gruppe "player" gehört
	if body.is_in_group("player"):
		is_player_near = true

func _on_body_exited(body):
	# Überprüfen, ob das verlassende Objekt zur Gruppe "player" gehört
	if body.is_in_group("player"):
		is_player_near = false
