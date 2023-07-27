extends BoxContainer

@onready var sprite_container= $Button/VBoxContainer/HBoxContainer/HBoxContainer
@onready var label: Label = $Button/VBoxContainer/Label

@export var weapon = WeaponInfo

signal select_weapon(weapon :WeaponInfo)

func _ready() -> void:
	label.text = weapon.name
	var weapon_sprite: AnimatedSprite2D = weapon.sprite.instantiate()
	sprite_container.add_child(weapon_sprite)	
	weapon_sprite.play("Shoot")
	weapon_sprite.scale = Vector2(1,1)
	
func _on_button_pressed() -> void:
	select_weapon.emit(weapon)
