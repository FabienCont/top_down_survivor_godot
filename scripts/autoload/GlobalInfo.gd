extends Node

@onready var level1: PackedScene  = preload("res://scenes/levels/garden_level.tscn")
@onready var menu: PackedScene  = preload("res://menu/acceuil.tscn")
@onready var character_selection: PackedScene  = preload("res://menu/character_selection.tscn")

var character: Character
var weapon: WeaponInfo

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
	SceneLoader.change_scene_to_packed(menu,SceneLoader.TransitionTypeEnum.INSTANT)

func goToSelectCharacterMenu():
	SceneLoader.change_scene_to_packed(character_selection,SceneLoader.TransitionTypeEnum.INSTANT)
	pass # Replace with function body.

func goToNextLevel():
	SceneLoader.change_scene_to_packed(level1,SceneLoader.TransitionTypeEnum.LOADING_SCREEN)
	pass # Replace with function body.

func restartLevel():
	stats = savedStats.duplicate(true)
	SceneLoader.change_scene_to_packed(level1,SceneLoader.TransitionTypeEnum.LOADING_SCREEN)
	pass # Replace with function body.
