extends Control

@onready var player: Player
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var weapons_container: Control = $VBoxContainer/WeaponContainer
@onready var weapons_button_group = ButtonGroup.new()

func _ready():
	player = GlobalInfo.player

	for container in weapons_container.get_children() as Array[Button]:
		container.button.button_group = weapons_button_group
		container.connect("select_weapon",_select_weapon)

func _select_weapon(weapon_selected:WeaponInfo) -> void:
	player.weapon_info = weapon_selected
	GlobalInfo.player = player
	_update_validate_button_status()

func _update_validate_button_status() -> void:
	if player.character != null && player.weapon_info != null:	
		buttonValidate.disabled = false
