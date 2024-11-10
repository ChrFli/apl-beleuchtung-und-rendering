extends CharacterBody3D

const SPEED = 15.0
const JUMP_VELOCITY = 20.0
const GRAVITY = 50.0  # Erhöhe diesen Wert, um das Objekt schneller fallen zu lassen
const SENSITIVITY = 0.005

@onready var head = $Head
@onready var camera = $Head/Camera3D




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		# Clamp camera pitch to avoid flipping
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))



func _physics_process(delta: float) -> void:
	# Add gravity to the velocity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta  # Hier wird die Schwerkraft auf das Objekt angewendet

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction: Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
