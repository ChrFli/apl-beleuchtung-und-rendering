extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 10
const GRAVITY = 20

var melee_damage= 50

#signal
signal player_hit

@onready var camera= $Node3D/Camera3D

@onready var melee_anim= $AnimationPlayer
@onready var melee_hitbox=$Node3D/Camera3D/Hitbox

@onready var textafa =$Node3D/Camera3D/Label3D

var has_key = false
var has_masterkey = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("player")

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera.rotate_x(-event.relative.y * 0.005)
		# Clamp camera pitch to avoid flipping
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-85), deg_to_rad(60))
		
		
func mele3e():
	if Input.is_action_just_pressed("Fire"):
		if not melee_anim.is_playing():
			melee_anim.play("MeleeAttack")
			melee_anim.play("MeleeReturn")
			debug_hitbox()  # Check overlaps during melee
		if melee_anim.current_animation == "MeleeAttack":
			for body in melee_hitbox.get_overlapping_bodies():
				print("you IN")
				if body is CharacterBody3D and body.is_in_group("Vikto"):
					body.health -= melee_damage
					print("Hit:", body.name)

func melee():
	if Input.is_action_just_pressed("Fire"):
		show_text_with_timer()
		if not melee_anim.is_playing():
			melee_anim.play("MeleeReturn")
			melee_anim.play("MeleeAttack")
		if melee_anim.current_animation == "MeleeAttack":
			for body in melee_hitbox.get_overlapping_bodies():
				if body is CharacterBody3D and body.is_in_group("Vikto"):
					body.health -= melee_damage
					print("Hit:", body.name, "Remaining health:", body.health)
					if body.health <= 0:
						print(body.name, "is dead.")
						
func show_text_with_timer():
	textafa.visible = true
	get_tree().create_timer(0.5).connect("timeout", Callable(self, "_on_timer_finished"))

func _on_timer_finished():
	textafa.visible = false

# Function to return the current state of has_key
func _haskey():
	return has_key

func pick_up_key():
	has_key = true

func _hasmasterkey():
	return has_masterkey

func pick_up_masterkey():
	has_masterkey = true

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
	
	
func hit():
	emit_signal("player_hit")
	
	
func debug_hitbox():
	if melee_hitbox.get_overlapping_bodies().size() > 0:
		print("Hitbox overlapping bodies:")
		for body in melee_hitbox.get_overlapping_bodies():
			print(" - ", body.name)
	else:
		print("No bodies overlapping with hitbox.")
