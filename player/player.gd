extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var spell = preload("res://spells/fire_ball.tscn")

@export var camera: Camera3D
@export var fall_multiplier: float = 2.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_motion := Vector2.ZERO

func _physics_process(delta):
	handle_camera_rotation()
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * delta * fall_multiplier

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event):
	if event.is_action_pressed("cast"):
		cast_spell()


func handle_camera_rotation() -> void:	
	rotate_y(mouse_motion.x)
	camera.rotate_x(mouse_motion.y)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	mouse_motion = Vector2.ZERO

func cast_spell() -> void:
	var cast_direction: Vector3 = global_position
	var casted_spell = spell.instantiate()
	add_child(casted_spell)	
	var direction = Vector3(cast_direction.y + 1, cast_direction.x, cast_direction.z - 1)
	casted_spell.cast(direction)
