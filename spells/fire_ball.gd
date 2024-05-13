extends Node3D
class_name FireBall

@export var force = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	pass

func _process(delta):
	pass


func cast(direction: Vector3):	
	global_position = direction	
	var rigid_body = get_children()[0]
	print("y: ",direction.y)
	print("z: ",direction.z)
	print("x: ",direction.x)	
	rigid_body.apply_force(Vector3(10, 0, -force), Vector3(direction.y, direction.x, -direction.z))
