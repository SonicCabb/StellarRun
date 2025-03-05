extends Node2D
class_name LootField

static var toInitArray: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	doDropLoot()

static func dropLoot(loot: PackedScene, lootPos: Vector2, lootVel: float, lootType: String, amount: int):
	if amount > 0:
		var newLoot: LootObject = loot.instantiate()
		newLoot.init(lootPos, lootVel, lootType, amount)
		toInitArray.push_back(newLoot)
	
func doDropLoot():
	for loot in toInitArray:
		add_child(loot)
		toInitArray.pop_front()
