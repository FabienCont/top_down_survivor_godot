extends Node

@onready var level1: PackedScene  = preload("res://scenes/levels/garden_level.tscn")
@onready var menu: PackedScene  = preload("res://menu/acceuil.tscn")
@onready var character_selection: PackedScene  = preload("res://menu/character_selection.tscn")
@onready var weapon_selection: PackedScene  = preload("res://menu/weapon_selection.tscn")

@onready var player_info:= PlayerInfo.new()

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
	SoundManager.stopBackgroundGameSound()
	SoundManager.playBackgroundMenuSound()

func goToSelectCharacterMenu():
	SceneLoader.change_scene_to_packed(character_selection,SceneLoader.TransitionTypeEnum.INSTANT)

func goToSelectWeaponMenu():
	SceneLoader.change_scene_to_packed(weapon_selection,SceneLoader.TransitionTypeEnum.INSTANT)

func goToNextLevel():
	SceneLoader.change_scene_to_packed(level1,SceneLoader.TransitionTypeEnum.LOADING_SCREEN)
	SoundManager.playBackgroundGameSound()
	SoundManager.stopBackgroundMenuSound()

func restartLevel():
	stats = savedStats.duplicate(true)
	SceneLoader.change_scene_to_packed(level1,SceneLoader.TransitionTypeEnum.LOADING_SCREEN)
