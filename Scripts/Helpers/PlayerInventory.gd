class_name PlayerInventory

var lootAmounts: Array[int] = []

func init():
	initLootArray()
	
func initLootArray():
	var lootObjectNum = GlobalStuff.gameData.fetch_collection_data("LootDrop").size()
	for index in lootObjectNum:
		lootAmounts.push_back(0)
