extends Control

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var player_info: PlayerInfo

@export var items_boxes: Array[ItemBoxDescription]
@export var validate_button: Button 
var possible_items: Array[Item]
var possible_upgrades: Array[Upgrade]
var selected_item:Item

var upgradesResourceGroup:ResourceGroup = preload("res://data/all_permanent_upgrades.tres")
var itemsResourceGroup:ResourceGroup = preload("res://data/all_permanent_items.tres")

func _ready() -> void :
	upgradesResourceGroup.load_all_into(possible_upgrades)
	itemsResourceGroup.load_all_into(possible_items)

	for button in items_boxes:
		button.select_item.connect(select_item)
	validate_button.pressed.connect(finish_level_up)
	
func _on_visibility_changed() -> void:
	if animationPlayer != null:
		if visible == true :
			validate_button.disabled=true
			selected_item=null
			randomize_all_items()
			items_boxes[0].get_child(0).grab_focus()
			animationPlayer.play("show_menu")
			if not Engine.is_editor_hint():
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else :
			animationPlayer.play("hide_menu") 
			if not Engine.is_editor_hint():
				Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func get_one_random_item():
	var index = randi() % possible_items.size()
	return possible_items[index]

func get_one_random_upgrade():
	var index = randi() % possible_upgrades.size()
	return possible_upgrades[index]

func randomize_all_items():
	var new_item_array = []
	for new_item_index in range(0,items_boxes.size()):
		var new_item = get_one_random_item()
		while new_item_array.has(new_item):
			new_item = get_one_random_item()
		new_item_array.append(new_item)
		items_boxes[new_item_index].item = new_item
	pass

func select_item(item:Item):
	validate_button.disabled=false
	selected_item = item
	
func finish_level_up():
	if selected_item != null :
		Signals.item_selected.emit(player_info,selected_item)
	
