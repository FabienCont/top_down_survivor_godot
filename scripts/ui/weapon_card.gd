extends BoxContainer

@onready var sprite_container= $Button/VBoxContainer/HBoxContainer/HBoxContainer
@onready var label: Label = $Button/VBoxContainer/Label
@onready var button: Button = $Button

@export var weapon = WeaponInfo

signal select_weapon(weapon :WeaponInfo)

func _ready() -> void:
	label.text = weapon.name
	var weapon_sprite: Sprite2D = weapon.sprite.instantiate()
	var animation_player = weapon_sprite.get_child(0) 
	sprite_container.add_child(weapon_sprite)	
	animation_player.play("Shoot")
	weapon_sprite.scale = Vector2(1,1)
	
func _on_button_pressed() -> void:
	select_weapon.emit(weapon)
