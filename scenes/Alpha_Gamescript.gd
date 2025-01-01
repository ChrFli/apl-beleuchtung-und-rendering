extends WorldEnvironment


@onready  var hit_rect = $"UI_ColorRect#TextureRect"

var mynode= preload("res://LongsFolder/zombie.tscn")
@onready var spawn_point_1 = $Spawns/SpawnPoint
@onready var spawn_point_2 = $Spawns/SpawnPoint2


@onready  var DoorLabel = $ScreenText/CantOpenDoor
@onready  var FrontDoorLabel = $ScreenText/CantOpenFrontDoor


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

@onready var spawn_points = [spawn_point_1, spawn_point_2]

func _on_static_body_3d_door_opened() -> void:
	for n in range(2):  # Erstelle 2 Zombies
		var instance = mynode.instantiate()
		instance.player_path = get_node("Firstperson").get_path()

		# Wähle zyklisch einen Spawnpunkt
		var selected_spawn_point = spawn_points[n % spawn_points.size()]
		instance.global_transform.origin = selected_spawn_point.global_transform.origin

		# Setze die Skalierung des Zombie
		instance.scale = Vector3(2.5, 2.5, 2.5)

		add_child(instance)
		print("Zombie erstellt an Spawnpunkt:", selected_spawn_point.name)



####LABELS#####

func _on_static_body_3d_door_interacted() -> void:
	DoorLabel.visible = true
	get_tree().create_timer(1.2).connect("timeout", Callable(self, "_on_timer_finished2"))
	
func _on_timer_finished2():
	DoorLabel.visible = false
	


func _on_static_body_3d_frontdoor_interacted() -> void:
	FrontDoorLabel.visible = true
	get_tree().create_timer(1.2).connect("timeout", Callable(self, "_on_timer_finished3"))

func _on_timer_finished3():

	FrontDoorLabel.visible = false
