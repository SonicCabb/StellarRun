extends Node2D
class_name Asteroids

const ASTEROID_SCENE: PackedScene = preload("res://Scenes/Debris/asteroid.tscn")
var distanceForAsteroid: int = 100
var asteroidSpawn: DistanceSpawner = DistanceSpawner.new()

const X_VEL_RANGE: int = 25
const Y_VEL_MOD: float = .3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	asteroidSpawn.setUp(ASTEROID_SCENE, $".", distanceForAsteroid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	asteroidSpawn.processAndSpawn()
	

func injectVelAll(spd):
	#inject value for all chilren
	for asteroid in get_children():
		asteroid.injectVel(spd)
