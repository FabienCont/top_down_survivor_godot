extends Weapon

@onready var sprite: Sprite2D = $sprite
@onready var animation_player:AnimationPlayer= $sprite/AnimationPlayer
@onready var ammo:PackedScene= preload("res://scenes/ammos/arrow.tscn")

func start_attack():
	animation_player.connect("animation_finished",shoot,CONNECT_ONE_SHOT)
	animation_player.play("prepareShot")

func shoot(_caller):
	animation_player.connect("animation_finished",idle,CONNECT_ONE_SHOT)
	animation_player.play("Shoot")
	var new_ammo = ammo.instantiate()
	new_ammo.global_position = global_position
	new_ammo.global_rotation = global_rotation
	add_child(new_ammo)
	
func idle(_caller):
	animation_player.play("Idle")
	await get_tree().create_timer(0.3).timeout
	start_attack()
	

func attack_start_to_hurt():
	pass

func start_recovery_attack():
	pass
	
func end_attack():
	pass
	
func damage(_hurtboxComponent :HurtboxComponent):
	pass	
