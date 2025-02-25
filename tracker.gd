extends RefCounted
class_name Tracker

var maxVal: int
var currentVal: int
var minVal: int = 0

func init(max, current, min):
	maxVal = max
	currentVal = current
	minVal = min

func reduce(value):
	currentVal -= value
	if currentVal <= minVal:
		var overflow = minVal - currentVal
		currentVal = minVal
		return overflow
	else:
		return -1

func regain(value):
	currentVal += value
	if currentVal >= maxVal:
		var overflow = currentVal - maxVal
		currentVal = maxVal
		return overflow
	else:
		return -1
		
func getValue():
	return currentVal

func getPercentage():
	if maxVal != 0:
		return float(currentVal) / float(maxVal)
	else:
		return 0.0
		
func refill():
	currentVal = maxVal
