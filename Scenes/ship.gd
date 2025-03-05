extends CharacterBody2D
class_name Ship

var lateralSpeed: int = 300

static var boostAdd: int = 200
static var brakeSub: int = 50

var ramDamage = 5

var health: Tracker = Tracker.new()
var shield: Tracker = Tracker.new()

var ore: int = 0

static var tractorAcc: int = 1000
static var lootInTractor: int = 0
static var maxInTractor: int = 3

var defaultLifetime #partical lifetime

var direction: Vector2 = Inpt.getDirInpt()

signal updateHealth(hlth: float)
signal updateShield(val: float)

static var shipPosition
static var globalShipPosition

func _ready() -> void:
	defaultLifetime = $GPUParticles2D.lifetime
	
	health.init(100, 100, 0, 0, shipHealthBarDisplay.setValue)
	shield.init(100, 100, 0, 5, shipShieldBarDisplay.setValue)

	add_child(health)
	add_child(shield)

func _process(_delta: float) -> void:
	#get direction vector
	direction = Inpt.getDirInpt()
	
	#fire primary weapon if button is pressed, and the timer can go
	if Input.is_action_pressed("Primary Fire") && $PrimaryFireTimer.is_stopped():
		firePrimary()

	#update x velocity based on direction and martical lifetime based on direction
	#updateXVel(direction)
	updateParticleLifetime(direction)
	
	shipPosition = position
	globalShipPosition = global_position
	
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
		
func addLoot(num: int, type: String):
	match type:
		"ore":
			ore += num

static func getShipPos():
	return shipPosition
	
static func getGlobalShipPos():
	return globalShipPosition

static func roomInTractor() -> bool:
	return lootInTractor < maxInTractor
	
static func addToTractor() -> void:
	lootInTractor += 1
	print("Added: ", lootInTractor)
		
static func removeFromTractor() -> void:
	if lootInTractor > 0:
		lootInTractor -= 1
		print("Removed: ", lootInTractor)
		
func _on_tractor_beam_area_entered(area: LootObject) -> void:
	area.enteredTractorArea()

func _on_tractor_beam_area_exited(area: LootObject) -> void:
	area.exitedTractorArea()
