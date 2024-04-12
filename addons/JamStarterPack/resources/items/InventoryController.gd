extends Resource

class_name InventoryController

signal item_added(item :Item)
signal item_removed(item :Item)

@export var items: Array[Item] = []
	
func add_item(item :Item):
	items.push_back(item)
	item_added.emit(item)
	
func remove_upgrade(item :Item):
	items.erase(item)
	item_removed.emit(item)
