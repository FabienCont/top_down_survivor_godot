extends BoxContainer

@onready var sprite_container= $Button/VBoxContainer/HBoxContainer/HBoxContainer
@onready var label: Label = $Button/VBoxContainer/Label
@onready var button: Button = $Button

@export var character = Character
@export var disable:bool = false

var character_sprite :AnimatedSprite2D
signal select_character(character :Character)

func _ready() -> void:
	label.text = character.name
	character_sprite= character.sprite.instantiate()
	sprite_container.add_child(character_sprite)	
	character_sprite.play("Walk")
	character_sprite.scale = Vector2(1,1)
	if disable == true:
		button.disabled = true
	
func _on_button_pressed() -> void:
	select_character.emit(character)

func _process(_delta: float)-> void:
	character_sprite.play("Walk")
