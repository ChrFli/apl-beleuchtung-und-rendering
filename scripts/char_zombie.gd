extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 10
@onready  var pivot = $Head
@onready var camera = $Head/SpringArm3D/Camera3D
@export var sens =0.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		pivot.rotate_y(deg_to_rad(-event.relative.x * sens))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
		camera.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-40), deg_to_rad(45))
		
	
func _physics_process(delta: float) -> void:
	# Add gravity to the velocity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta  # Hier wird die Schwerkraft auf das Objekt angewendet

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction: Vector3 = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

<<<<<<< Updated upstream
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
=======
	# Setze die Geschwindigkeit in der zufälligen Richtung
	velocity.x = random_direction.x * SPEED
	velocity.z = random_direction.z * SPEED

	# Drehe das Modell in die Bewegungsrichtung
	if random_direction.length() > 0:
		# Berechne den Zielwinkel in Y Richtung direkt anhand des Bewegungsvektors
		var target_rotation = atan2(random_direction.x, random_direction.z)
		# Setze die Rotation in Y zur Bewegungsrichtung
		rotation.y = lerp_angle(rotation.y, target_rotation, 0.1)
>>>>>>> Stashed changes

	# Kollision und Bewegung durchführen
	move_and_slide()
<<<<<<< Updated upstream
	
=======

	# Wenn wir in eine Kollision geraten, bewegen wir uns in eine neue Richtung
	if is_on_floor() and is_on_wall():
		set_random_direction()  # Neue zufällige Richtung bei Kollision
>>>>>>> Stashed changes
