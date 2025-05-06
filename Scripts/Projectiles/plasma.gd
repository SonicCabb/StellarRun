extends Area2D
class_name PlasmaBolt

var direction: Vector2

func _process(delta: float) -> void:
	position -= direction * delta * 1000
	if position.x > Background.getPlayArea().x || position.x < 0 || position.y > Background.getPlayArea().y || position.y < 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	body.takeDamage(35)
	
func init(pos: Vector2, dir: Vector2, rot: float):
	global_position = pos
	direction = dir
	rotation = rot
