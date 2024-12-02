extends Node3D


@onready  var hit_rect = $"UI_ColorRect#TextureRect"

var mynode= preload("res://LongsFolder/zombie.tscn")
@onready var spawn_point_1 = $Spawns/SpawnPoint
@onready var spawn_point_2 = $Spawns/SpawnPoint2


func _ready():
	pass
	#var instance = mynode.instantiate();
	#instance.player_path = get_node("Firstperson").get_path() 
	#add_child(instance)


	
func _process(delta):
	pass
	


	
func _on_firstperson_player_hit() -> void:
	hit_rect.visible= true
	await get_tree().create_timer(0.5).timeout

	hit_rect.visible=false
	




func _on_door_no_key_door_opened() -> void:
	var instance = mynode.instantiate();
	instance.player_path = get_node("Firstperson").get_path() 
	add_child(instance) # Replace with function body.
	


var spawn_toggle = true  # Start mit Spawnpunkt 1

func _on_static_body_3d_door_opened() -> void:
	for n in range(2):  # Erstelle 2 Zombies
		var instance = mynode.instantiate()
		instance.player_path = get_node("Firstperson").get_path()

		# Wähle zufällig einen der beiden Spawnpunkte
		var selected_spawn_point = spawn_point_1 if randf() < 0.5 else spawn_point_2

		# Berechne eine zufällige Position um den ausgewählten Spawnpunkt
		var random_offset = Vector3(
			randf() * 4 - 2,  # Zufällige X-Verschiebung zwischen -2 und 2
			0,                # Keine Höhenänderung (bleibt auf derselben Ebene)
			randf() * 4 - 2   # Zufällige Z-Verschiebung zwischen -2 und 2
		)

		# Setze die globale Position des Zombies
		instance.global_transform.origin = selected_spawn_point.global_transform.origin + random_offset
		
		# Setze die Skalierung des Zombies (z.B. 50% größer)
		instance.scale = Vector3(2.5, 2.5, 2.5)  # Skaliere den Zombie auf 150% seiner normalen Größe

		# Füge den Zombie zur Szene hinzu
		add_child(instance)
		print("Zombie erstellt.")
