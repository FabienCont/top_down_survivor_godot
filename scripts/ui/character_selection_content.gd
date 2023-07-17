extends Control

var character: Character
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var characters_container: Control = $VBoxContainer/HBoxContainer2

func _ready():
	for button in characters_container.get_children():
		button.connect("select_character",_select_character)
	
func _select_character(character_selected:Character) -> void:
	character = character_selected
	buttonValidate.disabled = false
