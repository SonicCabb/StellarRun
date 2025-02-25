extends RigidBody2D

#range of x velocities and the range of y differences
const X_VEL_RANGE: int = 25
const Y_VEL_MOD: float = .3

var health: Tracker = Tracker.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.init(50, 50, 0)
	
	initPosition()
	initVelocity()
	
	
func _process(_delta: float) -> void:
	#delete if it goes too far
	if position.y > Background.getPlayArea().y:
		queue_free()

func takeDamage(damage: int):
	
	#reduce health by damage
	if health.reduce(damage) >= 0: #if overflow is zero or more
		queue_free()
	#change textrues, base on current health p
	var healthPer: float = health.getPercentage()
	if healthPer < 1 && healthPer > .7:
		$AsteroidSprite.texture = ResourceLoader.load("res://Graphics/Asteroids/Asteroid1.png")
	elif healthPer <= .7 && healthPer > .3:
		$AsteroidSprite.texture = ResourceLoader.load("res://Graphics/Asteroids/Asteroid2.png")
	else:
		$AsteroidSprite.texture = ResourceLoader.load("res://Graphics/Asteroids/Asteroid3.png")


func initPosition():
	position.y = -100
	position.x = randf_range(0, Background.getPlayArea().x)

func initVelocity():
	linear_velocity.x = randi_range(-X_VEL_RANGE, X_VEL_RANGE)
	linear_velocity.y = Base.getScrollSpeed() + (Base.getBaseScrollSpeed() * randf_range(-Y_VEL_MOD, Y_VEL_MOD))

func injectVel(spd): 
	linear_velocity.y = linear_velocity.y + spd

func getColDamage():
	return mass

func _on_body_entered(body: Node) -> void:
	if body.has_method("getColDamage"):
		takeDamage(body.getColDamage())
	
	if body.has_method("takeShipDamage"):
		body.takeShipDamage(getColDamage())
