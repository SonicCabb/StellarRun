extends Node2D
class_name Base

static var scrollSpeed: int = 0 #current speed of everything scrolling
const BASE_SCROLL_SPEED = 300	#defualt speed of everything scrolling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#initialize current scroll speed
	scrollSpeed = BASE_SCROLL_SPEED

func _process(delta: float) -> void:
	#needed to allow the distance spawner to count distance
	DistanceSpawner.processDistance(delta)
	

static func getScrollSpeed():
	return scrollSpeed

static func getBaseScrollSpeed():
	return BASE_SCROLL_SPEED
