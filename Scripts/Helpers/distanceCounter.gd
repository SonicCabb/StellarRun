extends Node
class_name DistanceSpawner

#holds global distance info
static var distanceTraveled: float = 0 #Distance travled
static var prevDistance: float = 0	#keeps track of the previous distance. USed for calculating distance traveled per frame

var sceneToSpawn: PackedScene
var parentNode: Node

#holds buffer info, for when instanciating values
var distBuffer: float = 0
var distToTrack: float = 0


#call to set up an instance of the spawner
func setUp(scene: PackedScene, pNode: Node, distance):
	setTrackDistance(distance)
	sceneToSpawn = scene
	parentNode = pNode

#updates buffer, and spawns based on what's remaining in the buffer
func processAndSpawn():
	distBuffer += getFrameDistance()
	while needToSpawn():
		#add item
		var obj = sceneToSpawn.instantiate()
		parentNode.add_child(obj)

#this needs to be called evry frame from a process functino somewhere
static func processDistance(delta: float):
	prevDistance = distanceTraveled 
	distanceTraveled += delta * Base.getScrollSpeed()

func getDistanceTraveled():
	return distanceTraveled

func getFrameDistance():
	return distanceTraveled - prevDistance

func setTrackDistance(dist):
	distToTrack = dist

#checks to see if the the buffer is full, and objects should be spawned
func needToSpawn():
	if distBuffer > distToTrack:
		removeFromBuffer()
		return true
	return false
	
func removeFromBuffer():
	distBuffer -= distToTrack
