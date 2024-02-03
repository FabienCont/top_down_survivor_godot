extends Control

@onready var player_info: PlayerInfo
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var weapons_container: Control = $VBoxContainer/WeaponContainer
@onready var weapons_button_group = ButtonGroup.new()

func _ready():
	player_info = GlobalInfo.player_info
	var weapons_cards = weapons_container.get_children()
	weapons_cards[0].get_child(0).grab_focus()
	for container in weapons_container.get_children() as Array[Button]:
		container.button.button_group = weapons_button_group
		container.connect("select_weapon",_select_weapon)

func _select_weapon(weapon_selected:WeaponInfo2D) -> void:
	player_info.weapon_info = weapon_selected
	GlobalInfo.player_info = player_info
	_update_validate_button_status()

func _update_validate_button_status() -> void:
	if player_info.character != null && player_info.weapon_info != null:	
		buttonValidate.disabled = false
