extends RigidBody3D
class_name FireBall

@export var force = 10
@onready var timer = $Timer

func _ready():	
	top_level = true
	max_contacts_reported = 1	
	timer.start()	

func _process(_delta):
	pass


func cast(direction: Vector3) -> void:		
	apply_impulse(Vector3(0, 10, -force), direction)	

func _on_timer_timeout():		
	queue_free()



func _on_body_entered(_body: Node3D) -> void:
	queue_free()
