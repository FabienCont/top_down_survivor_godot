extends Node2D

@onready var player:Player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	player.init_player(player.player_info)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
