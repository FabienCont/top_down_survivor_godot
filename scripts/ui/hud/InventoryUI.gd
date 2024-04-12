extends HBoxContainer

var items = []
var item_ui_scene = preload("res://scenes/ui/ItemUI.tscn")

func _ready():
	Signals.inventory_update.connect(update_all_inventory)
	
func clean_items_node()-> void:
	for node in get_children():
			remove_child(node)
			node.queue_free()
			
func update_all_inventory(player_info: PlayerInfo):
	var new_items = player_info.inventory_controller.items
	clean_items_node()
	for item in new_items:
		add_item(item)
			
func add_item(item: Item):
	var item_ui = item_ui_scene.instantiate()
	item_ui.item= item
	add_child(item_ui)
