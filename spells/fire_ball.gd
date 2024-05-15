extends Node3D
class_name FireBall

@export var force = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	pass

func _process(delta):
	pass


func cast(direction: Vector3):
	var rigid_body = find_child('RigidBody3D')	
	rigid_body.apply_impulse(Vector3(0, 1, -force), direction)

