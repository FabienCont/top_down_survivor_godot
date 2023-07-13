extends Weapon

@onready var sprite: Sprite2D = $sprite
@onready var animation_player:AnimationPlayer= $sprite/AnimationPlayer
@onready var ammo:PackedScene= preload("res://scenes/ammos/arrow.tscn")

func start_attack():
	animation_player.speed_scale = player.stats.ATTACK_SPEED
	animation_player.connect("animation_finished",shoot,CONNECT_ONE_SHOT)
	animation_player.play("prepareShot")

func shoot(_caller):
	animation_player.connect("animation_finished",idle,CONNECT_ONE_SHOT)
	animation_player.play("Shoot")
	var new_ammo = ammo.instantiate()
	new_ammo.player = player
	new_ammo.global_position = global_position
	new_ammo.global_rotation = global_rotation
	add_child(new_ammo)
	
func idle(_caller):
	animation_player.play("Idle")
	var time_factor = 1 / player.stats.ATTACK_SPEED
	await get_tree().create_timer(0.3 * time_factor).timeout
	start_attack()
