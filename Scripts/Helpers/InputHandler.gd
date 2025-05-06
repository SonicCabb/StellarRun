extends Node
class_name Inpt

static var upJustReleased: bool = false


func _process(delta: float) -> void:
	pass

static func getDirInpt():
	return Input.get_vector("Left", "Right", "Up", "Down")

static func getVertInpt(nrm: bool):
	if nrm:
		return Vector2(0,getDirInpt().y).normalized().y
	else:
		return getDirInpt().y

static func getHorzInpt(nrm: bool):
	if nrm:
		return Vector2(getDirInpt().x, 0).normalized().x
	else:
		return getDirInpt().x


static func checkInput(action: StringName):
	if Input.is_action_just_pressed(action):
		return 
