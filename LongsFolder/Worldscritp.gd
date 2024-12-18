extends Node3D

@onready  var hit_rect = $"UI_ColorRect#TextureRect"

var mynode= preload("res://LongsFolder/zombie.tscn")

@onready  var worldlabel = $Label

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
	


func _on_static_body_3d_door_opened() -> void:
	for n in range(2):  # Erstelle 2 Zombies
		var instance = mynode.instantiate()
		instance.player_path = get_node("Firstperson").get_path()

		# Berechne eine zufällige Position um den Spawnpunkt
		var random_offset = Vector3(
			randf() * 4 - 2,  # Zufällige X-Verschiebung zwischen -2 und 2
			0,                # Keine Höhenänderung (bleibt auf derselben Ebene)
			randf() * 4 - 2   # Zufällige Z-Verschiebung zwischen -2 und 2
		)

		# Setze die Position des Zombies basierend auf dem Spawnpunkt
		instance.global_transform.origin = global_transform.origin + random_offset

		add_child(instance)
		
		



func _on_static_body_3d_door_interacted() -> void:
	worldlabel.visible = true
	get_tree().create_timer(0.9).connect("timeout", Callable(self, "_on_timer_finished2"))
	
func _on_timer_finished2():
	worldlabel.visible = false
