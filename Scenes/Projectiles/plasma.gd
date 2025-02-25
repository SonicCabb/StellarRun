extends Area2D
class_name PlasmaBolt

var direction: Vector2

func _process(delta: float) -> void:
	position -= direction * delta * 1000
	

func _on_body_entered(body: Node2D) -> void:
	
	queue_free()
	body.takeDamage(15)
	
func init(pos: Vector2, dir: Vector2, rot: float):
	global_position = pos
	direction = dir
	rotation = rot
