extends CharacterBody3D


var player = null

const SPEED = 2.0
const ATTACK_RANGE = 5
var health = 200

@export var player_path : NodePath
@onready var nav_agent=  $NavigationAgent3D

@onready var anim_tree =$AnimationTree
@onready var sfx_hit: AudioStreamPlayer3D = $sfx_hit


func _ready(): 
	player =  get_node(player_path)
	add_to_group("Vikto")  # Add to the enemy group

	
	
	

func _process(delta):
	velocity =Vector3.ZERO
	
	#navigation
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized()*SPEED
	
	look_at(Vector3(player.global_position.x,  global_position.y, player.global_position.z), Vector3.UP)
	
	#condition
	anim_tree.set("parameters/conditions/attack",_target_in_range())
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
	#lifepoints 
	if health <= 0:
		die()
	
	
	
	move_and_slide()
	
func _target_in_range():
	return global_position.distance_to(player.global_position) <ATTACK_RANGE
	
	
	
func _hit_finished():
	player.hit()
	sfx_hit.play()
	player.take_damage(30)
	
func die():
	print(name, "has died.")
	anim_tree.set("parameters/conditions/Death", true)
	velocity =Vector3.ZERO
	
	look_at(Vector3(-player.global_position.x,  -global_position.y, -player.global_position.z), Vector3.UP)
	await get_tree().create_timer(4.0).timeout
	queue_free()
