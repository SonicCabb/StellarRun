extends Node
class_name Tracker

#class for tracking percentage stats, that can recharge. Health, shields etc


var maxVal: float
var currentVal: float
var minVal: float = 0
var recharge: float			#Holds function to u[pdate display

var displayUpdateFunction: Callable

func _process(delta: float) -> void:
	if recharge != 0:
		regain(recharge * delta)

func init(max, current, min, rech, updateFunc):
	maxVal = max
	currentVal = current
	minVal = min
	recharge = rech
	
	if updateFunc != null:
		displayUpdateFunction = updateFunc
	
	updateDisplay()
	
func reduce(value):
	currentVal -= value
	if currentVal <= minVal:
		var overflow = minVal - currentVal
		currentVal = minVal
		updateDisplay()
		return overflow
	else:
		updateDisplay()
		return -1

	
	
func regain(value):
	currentVal += value
	if currentVal >= maxVal:
		var overflow = currentVal - maxVal
		currentVal = maxVal
		updateDisplay()
		return overflow
	else:
		updateDisplay()
		return -1
	
	
		
func getValue():
	return currentVal

func getPercentage():
	if maxVal != 0:
		return currentVal / maxVal
	else:
		return 0.0
		
func refill():
	currentVal = maxVal
	updateDisplay()
	
func updateDisplay():
	if displayUpdateFunction.is_valid():
		displayUpdateFunction.call((currentVal / maxVal) * 100)
