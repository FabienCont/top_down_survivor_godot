extends Control

@onready var player: Player = Player.new()
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var characters_container: Control = $VBoxContainer/CharacterContainer
@onready var weapons_container: Control = $VBoxContainer/WeaponContainer
@onready var characters_button_group = ButtonGroup.new()
@onready var weapons_button_group = ButtonGroup.new()

func _ready():

	for container in characters_container.get_children() as Array[Button]:
		container.button.button_group = characters_button_group
		container.connect("select_character",_select_character)
	for container in weapons_container.get_children() as Array[Button]:
		container.button.button_group = weapons_button_group
		container.connect("select_weapon",_select_weapon)

func _select_weapon(weapon_selected:WeaponInfo) -> void:
	player.weaponInfo = weapon_selected
	GlobalInfo.player = player
	_update_validate_button_status()

func _select_character(character_selected:Character) -> void:
	player.character = character_selected
	GlobalInfo.player = player
	_update_validate_button_status()

func _update_validate_button_status() -> void:
	if player.character != null && player.weaponInfo != null:	
		buttonValidate.disabled = false
