extends Node2D
class_name Projectiles

static var PLASMA_SCENE: PackedScene = preload("res://Scenes/Projectiles/plasma.tscn")

static var plasmaSpread: float = .05

func fire(gunPos: Vector2):
	var newPlasma: PlasmaBolt = PLASMA_SCENE.instantiate()
	
	#get it's direction
	var plasmaDirection: Vector2 = gunPos - get_global_mouse_position()
	plasmaDirection = plasmaDirection.rotated(randf_range(-plasmaSpread, plasmaSpread))
	#plasmaDirection = Vector2.DOWN
	#initialize the values
	newPlasma.init(gunPos, plasmaDirection.normalized(), plasmaDirection.angle() + (PI / 2))
	
	#add it to the projectiles node
	add_child(newPlasma)
