extends BoxContainer

@onready var sprite_container= $Button/VBoxContainer/HBoxContainer
@onready var label: Label = $Button/VBoxContainer/Label

@export var character = Character

signal select_character(character :Character)

func _ready() -> void:
	label.text = character.name
	var character_sprite: AnimatedSprite2D = character.sprite.instantiate()
	sprite_container.add_child(character_sprite)	
	character_sprite.play("Walk")
	character_sprite.scale = Vector2(3,3)
	
func _on_button_pressed() -> void:
	select_character.emit(character)
