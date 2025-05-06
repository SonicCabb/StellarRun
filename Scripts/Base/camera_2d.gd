extends Camera2D
class_name ShipCam

#keeps track of camera positioin to determine velocity
static var currentVel: Vector2 = Vector2.ZERO
var previousPos: Vector2


func _ready() -> void:
	#initializes previous position to current position
	position = Vector2(0,0)
	previousPos = get_screen_center_position()
	
	

func _process(_delta: float) -> void:
	pass
	#updateCameraVelocity(get_screen_center_position())

func updateCameraVelocity(screenCenter):
	#determine camera velocity
	currentVel = previousPos - screenCenter
	previousPos = screenCenter

static func getCamVelocity():
	return currentVel
