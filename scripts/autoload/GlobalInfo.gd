extends Node

@onready var level1: PackedScene  = preload("res://scenes/levels/GardenLevel.tscn")
@onready var menu: PackedScene  = preload("res://menu/acceuil.tscn")

var stats: Dictionary = {
	"level":0,
} 

var savedStats: Dictionary = {
	
}

func reset():
	stats.level=0

func startLevel():
	savedStats = stats.duplicate(true)

func endLevel():
	stats.level+=1

func goToMenu():
	SceneLoader.change_scene_to_packed(menu)

func goToNextLevel():
	SceneLoader.change_scene_to_packed(level1)
	pass # Replace with function body.

func restartLevel():
	stats = savedStats.duplicate(true)
	SceneLoader.change_scene_to_packed(level1)
	pass # Replace with function body.
