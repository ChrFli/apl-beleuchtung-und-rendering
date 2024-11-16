extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 10
const GRAVITY = 10

var melee_damage= 50

@onready var camera= $Node3D/Camera3D

@onready var melee_anim= $AnimationPlayer
@onready var melee_hitbox=$Node3D/Camera3D/Area3D

var has_key = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("player")

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera.rotate_x(-event.relative.y * 0.005)
		# Clamp camera pitch to avoid flipping
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-85), deg_to_rad(60))
		
		
func melee():
	if Input.is_action_just_pressed("Fire"):
		if not melee_anim.is_playing():
			melee_anim.play("MeleeAttack")
			melee_anim.play("MeleeReturn")
		
# Function to return the current state of has_key
func _haskey():
	return has_key

func pick_up_key():
	has_key = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta  # Hier wird die Schwerkraft auf das Objekt angewendet

	melee()
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
