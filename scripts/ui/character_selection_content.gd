extends Control

var player: Player
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var characters_container: Control = $VBoxContainer/HBoxContainer2
@onready var weapon_container: Control = $VBoxContainer/HBoxContainer2

func _ready():
	for button in characters_container.get_children():
		button.connect("select_character",_select_character)
	for button in weapon_container.get_children():
		button.connect("select_weapon",_select_weapon)

func _select_weapon(weapon_selected:WeaponInfo) -> void:
	player.weapon = weapon_selected
	GlobalInfo.player = player
	_update_validate_button_status()

func _select_character(character_selected:Character) -> void:
	player.character = character_selected
	GlobalInfo.player = player
	_update_validate_button_status()

func _update_validate_button_status() -> void:
	if player.character != null && player.weapon != null:	
		buttonValidate.disabled = false
