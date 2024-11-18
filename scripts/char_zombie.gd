extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 10
@onready var pivot = $Head
@onready var camera = $Head/SpringArm3D/Camera3D
@export var sens = 0.5

# Zeitintervall, um zufällige Bewegungsrichtung zu ändern
const RANDOM_MOVEMENT_INTERVAL = 2.0
var movement_timer = 0.0
var random_direction: Vector3 = Vector3.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	set_random_direction()  # Setze initial eine zufällige Richtung
	
func _input(event):
	if event is InputEventMouseMotion:
		pivot.rotate_y(deg_to_rad(-event.relative.x * sens))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
		camera.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-40), deg_to_rad(45))

func set_random_direction():
	# Generiere eine zufällige Richtung im Raum
	random_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()

func _physics_process(delta: float) -> void:
	# Add gravity to the velocity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta  # Hier wird die Schwerkraft auf das Objekt angewendet

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Zufällige Bewegung alle paar Sekunden
	movement_timer -= delta
	if movement_timer <= 0:
		movement_timer = RANDOM_MOVEMENT_INTERVAL  # Resette den Timer
		set_random_direction()  # Setze eine neue zufällige Richtung

	# Setze die Geschwindigkeit in der zufälligen Richtung
	velocity.x = random_direction.x * SPEED
	velocity.z = random_direction.z * SPEED

	# Drehe das Modell in die Bewegungsrichtung
	if random_direction.length() > 0:
		# Berechne den Zielwinkel in Y Richtung direkt anhand des Bewegungsvektors
		var target_rotation = atan2(random_direction.x, random_direction.z)
		# Setze die Rotation in Y zur Bewegungsrichtung
		rotation.y = lerp_angle(rotation.y, target_rotation, 0.1)

	# Kollision und Bewegung durchführen
	move_and_slide()

	# Wenn wir in eine Kollision geraten, bewegen wir uns in eine neue Richtung
	if is_on_floor() and is_on_wall():
		set_random_direction()  # Neue zufällige Richtung bei Kollision
