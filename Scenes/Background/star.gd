extends Sprite2D
class_name Star

var speed: int = 0				#velocity of the star. Depends on nearness
const MAX_NEAR: float= .25		#max closeness of stars
var nearness: float = MAX_NEAR	#0 is furthest away. Will be set anyway
var farness: float = 0			#Inverse of neaness
var yBounds: int = 0				#Y value where stars are destroyed. WIll be set

func _ready() -> void:
	#Calculate Nearness, scale, and color on initialization
	calcNearness()
	initScale()
	initColor()
	init()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Update speed based on current scroll speed
	calcSpeed(Base.scrollSpeed)
	
	#Update Position
	updatePosition(delta)
	
	#if out our frame, delete
	if position.y > yBounds:
		queue_free()

#Initialize some information for the star
func init():
	initYBounds(Background.getPlayArea().y)
	initPosition()

func initPosition():
	setPosition(Vector2(randi_range(-1 * Background.getStarBuffer(), Background.getPlayArea().x + Background.getStarBuffer()), 0))
	

#initialize asteroid scale
func initScale():
	scale.x = (nearness * 4) + .2
	scale.y = scale.x

#initialize the nearness and farness of the aseroid
func calcNearness():
	nearness = randf_range(0, MAX_NEAR)
	farness = 1 - nearness

#initialize the y bounds value
func initYBounds(yVal):
	yBounds = yVal

#calculate current speed based of of nearness
func calcSpeed(scSpd):
	speed = scSpd * (nearness + .2)

#initialize a radomish color
func initColor():
	modulate = Color(randf_range(.7, 1), randf_range(.7, 1), randf_range(.7, 1), .5)
	
#set the position of the star
func setPosition(pos: Vector2):
	position = pos

#called every frame to update positon based on speed and camera valocity
func updatePosition(dlt):
	#new position depends on paralax effect
	#position += Vector2(-1 * ShipCam.getCamVelocity().x * farness, (speed * dlt) + (-1 * ShipCam.getCamVelocity().y * farness))
	position.y += speed * dlt
