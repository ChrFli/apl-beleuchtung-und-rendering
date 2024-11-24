extends CharacterBody3D


var health = 100

func _ready():
	add_to_group("Vikto")
	
func _process(delta):
	if health <=0:
		queue_free()
