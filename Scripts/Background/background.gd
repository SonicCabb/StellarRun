extends Node2D
class_name Background

#star scene to import for the background
const STAR_SCENE: PackedScene = preload("res://Scenes/Background/star.tscn")

#play area width and height
static var playArea: Vector2 = Vector2(2000, 2000)

#buffer from ship to the edge
static var buffer: int = 40

#distance stars should spawn, to left and the right
static var starBuffer: int = 500

#higher number, the less frequent stars are
var distanceForStar: int = 20

#spawner class
var starSpawn: DistanceSpawner = DistanceSpawner.new()

func _ready() -> void:	
	
	init()
	starSpawn.setUp(STAR_SCENE, $Stars, distanceForStar)
	

func _process(delta: float) -> void:
	starSpawn.processAndSpawn()

static func getPlayArea():
	return playArea

static func getStarBuffer():
	return starBuffer

func init():
	playArea = get_viewport().size
	
	#Setup the world boundaries
	$Boundary/LeftBounds.position = Vector2(buffer, 0)
	$Boundary/TopBounds.position = Vector2(0, buffer)
	$Boundary/BottomBounds.position = Vector2(0, getPlayArea().y - buffer)
	$Boundary/RightBounds.position = Vector2(getPlayArea().x - buffer, 0)
	
	#set up the position of the background color
	$ColorRect.position = Vector2(0,0)
	$ColorRect.size = getPlayArea()
