extends Node

@onready var _soundQueuesByName :Dictionary  = {}
@onready var _soundPoolsByName :Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_soundQueuesByName["BackgroundSoundQueue"] = get_node("BackgroundSoundQueue")
	_soundQueuesByName["BackgroundGameSoundQueue"] = get_node("BackgroundGameSoundQueue")
	_soundQueuesByName["SoundLootQueue"] = get_node("SoundLootQueue")
	_soundQueuesByName["SoundFireBowQueue"] = get_node("SoundFireBowQueue")
	_soundQueuesByName["SoundImpactQueue"] = get_node("SoundImpactQueue")
	
	_soundPoolsByName["FootstepSoundPool"] = get_node("FootstepSoundPool")
	_soundPoolsByName["EnemiesImpactSoundPool"] = get_node("EnemiesImpactSoundPool")
	SoundManager.playBackgroundMenuSound()

func playBackgroundMenuSound():
	get_sound_queue_by_name("BackgroundSoundQueue").play_sound_with_fade_in(2)

func stopBackgroundMenuSound():
	get_sound_queue_by_name("BackgroundSoundQueue").stop_sound_with_fade_out(4)
	
func playBackgroundGameSound():
	get_sound_queue_by_name("BackgroundGameSoundQueue").play_sound_with_fade_in(2)
	
func stopBackgroundGameSound():
	get_sound_queue_by_name("BackgroundGameSoundQueue").stop_sound_with_fade_out(4)

func playLootSound():
	get_sound_queue_by_name("SoundLootQueue").play_sound()

func playFireArrowSound():
	get_sound_queue_by_name("SoundFireBowQueue").play_sound()

func playImpactSound():
	get_sound_queue_by_name("SoundImpactQueue").play_sound()
	
func playFootstepSound():
	get_sound_pool_by_name("FootstepSoundPool").play_random_sound()
	
func playEnemiesImpactSound():
	get_sound_pool_by_name("EnemiesImpactSoundPool").play_random_sound()

func get_sound_queue_by_name(sound_name: String) -> SoundQueue :
	return _soundQueuesByName[sound_name]

func get_sound_pool_by_name(sound_name: String) -> SoundPool :
	return _soundPoolsByName[sound_name]
