extends Node2D

@onready var player:Player = $Player
@onready var enemy:Enemy = $Enemy
@export var enemy_info:EnemyInfo 

# Called when the node enters the scene tree for the first time.
func _ready():
	player.init_player(player.player_info)
	enemy.init_enemy(enemy_info)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
