extends Area2D
class_name LootObject

var stacked: int = 1
var type: String = "default"

var ORE_TEXTURE: Texture2D = ResourceLoader.load("res://Graphics/Loot/ore.png")
var toDelete: bool = false

var direction: Vector2 = Vector2.DOWN
var desiredDirection: Vector2

var velocity: Vector2

var tractorStatus: tractStat = tractStat.NONE

enum tractStat {NONE, INRANGE, INBEAM}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stackLabel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if caught in the tractor beam
	if tractorStatus == tractStat.INBEAM:
		queue_redraw()
		velocity = (Ship.getShipPos() - position).normalized() * (Ship.tractorAcc / 3)
		modulate.a = .4
	elif tractorStatus == tractStat.INRANGE:
		if Ship.roomInTractor():
			tractorStatus = tractStat.INBEAM
			Ship.addToTractor()
		
	position += velocity * delta


func _draw() -> void:
	
	var shipVec = Ship.getShipPos() - position
	if tractorStatus == tractStat.INBEAM:
		draw_line(Vector2.ZERO, shipVec, Color.CORNFLOWER_BLUE, .6, true)

func init (pos: Vector2, vel: float, typ: String, amt: int):
	setPostion(pos)
	setSpeed(vel)
	setType(typ)
	stacked = amt

func setPostion(pos: Vector2):
	position = pos

func setSpeed(spd: float):
	velocity.y = spd
	velocity.x = 0

func setType(typ: String):
	type = typ
	setImage()

func setImage():
	if type == "ore":
		$LootSprite.texture = ORE_TEXTURE
	

func enteredTractorArea():
	tractorStatus = tractStat.INRANGE

func exitedTractorArea():
	if tractorStatus == tractStat.INRANGE:
		tractorStatus = tractStat.NONE

func _on_body_entered(body: Node2D) -> void:
	if body is Ship:
		body.addLoot(stacked, type)
		delete()

func delete():
	if tractorStatus == tractStat.INBEAM:
		Ship.removeFromTractor()
	queue_free()

func stackLabel():
	if stacked > 1:
		$Stacked.text = str(stacked)
	else:
		$Stacked.text = ""

func _on_area_entered(area: Area2D) -> void:
	if toDelete == false:
		if area is LootObject:
			area.toDelete = true
			area.delete()
			stacked += area.stacked
			stackLabel()
