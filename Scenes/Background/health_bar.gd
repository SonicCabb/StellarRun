extends ProgressBar
class_name shipHealthBarDisplay

static var globVal: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = globVal


static func setValue(val: float):
	globVal = val
