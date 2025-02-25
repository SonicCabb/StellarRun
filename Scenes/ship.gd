extends CharacterBody2D
class_name Ship

var lateralSpeed: int = 300

static var boostAdd: int = 200
static var brakeSub: int = 50

var ramDamage = 5

var health: Tracker = Tracker.new()
var shield: Tracker = Tracker.new()

var defaultLifetime #partical lifetime

var direction: Vector2 = Inpt.getDirInpt()

signal updateHealth(hlth: int)
signal updateShield(val: int)

func _ready() -> void:
	defaultLifetime = $GPUParticles2D.lifetime
	health.init(100, 100, 0)
	shield.init(100, 100, 0)
	updateHealth.emit(health.getPercentage() * 100)
	updateShield.emit(shield.getPercentage() * 100)

func _process(_delta: float) -> void:
	#get direction vector
	direction = Inpt.getDirInpt()
	
	#fire primary weapon if button is pressed, and the timer can go
	if Input.is_action_pressed("Primary Fire") && $PrimaryFireTimer.is_stopped():
		firePrimary()

	#update x velocity based on direction and martical lifetime based on direction
	#updateXVel(direction)
	updateParticleLifetime(direction)
	
	velocity = direction * lateralSpeed
	move_and_slide()
	

func firePrimary():
	#Call the fire funtion in the projectiles node
	$"../Projectiles".fire($"Primary Gun".global_position)
	#reset the primary fire timer
	$PrimaryFireTimer.start()


func updateParticleLifetime(dir: Vector2):
	$GPUParticles2D.lifetime = defaultLifetime * ((2.1 - direction.y)) * .4
	
func getColDamage():
	return ramDamage
	
func takeShipDamage(value: int):
	var shieldOverflow = shield.reduce(value)
	if shieldOverflow >= 0:
		health.reduce(shieldOverflow)
	updateHealth.emit(health.getPercentage() * 100)
	updateShield.emit(shield.getPercentage() * 100)
	

func _on_shield_recharge_timeout() -> void:
	shield.regain(1)
	$"Shield Recharge".start()
	updateShield.emit(shield.getPercentage() * 100)
