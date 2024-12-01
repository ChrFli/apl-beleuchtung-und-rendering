extends Node3D

@onready  var hit_rect = $UI/ColorRect

var mynode= preload("res://LongsFolder/zombie.tscn")

func _ready():
	pass
	var instance = mynode.instantiate();
	instance.player_path = get_node("Firstperson").get_path() 
	add_child(instance)

	
	
func _process(delta):
	pass
	

func _on_firstperson_player_hit() -> void:
	hit_rect.visible= true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible=false
	

func _when_enter_zone():
	var esa = 100

