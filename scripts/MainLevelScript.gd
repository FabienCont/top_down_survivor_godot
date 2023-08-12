extends Control

@onready var game_world = $SubViewportContainerGame/SubViewport/GardenLevel
@onready var clock = $SubViewportContainerUI/SubViewport2/VBoxContainerUI/Timer
@onready var ui_container = $SubViewportContainerUI/SubViewport2/VBoxContainerUI
@onready var timer_display =$SubViewportContainerUI/SubViewport2/VBoxContainerUI/Timer
@onready var pause_menu = $pause
@onready var loose_menu = $loose_menu
@onready var level_up_menu = $level_up

@onready var is_paused: bool = false
@onready var level_up_in_queue: int = 0
@onready var gameClock = GameClock.new()

func _ready() -> void:
	gameClock.wave = 1
	timer_display.gameClock = gameClock
	Signals.start_level_up.connect(start_level_up)
	Signals.end_level_up.connect(end_level_up)
	Signals.start_pause_menu.connect(show_pause_menu)
	Signals.end_pause_menu.connect(hide_pause_menu)
	Signals.player_died.connect(_level_failed)
	game_world.init(gameClock,GlobalInfo.player)

func _process(delta: float) -> void:
	if is_paused == false:
		gameClock.time = gameClock.time+ delta
		if gameClock.time > gameClock.wave * 60 :
			gameClock.wave = gameClock.wave + 1
		
	if Input.is_action_just_pressed("escape") && level_up_in_queue == 0:
		if is_paused==true:
			hide_pause_menu()
		else:
			show_pause_menu()
		
func pause_game() -> void:
	is_paused=true
	game_world.process_mode = PROCESS_MODE_DISABLED
	clock.process_mode = PROCESS_MODE_DISABLED
	
func play_game() -> void:
	is_paused=false
	game_world.process_mode = PROCESS_MODE_INHERIT
	clock.process_mode = PROCESS_MODE_INHERIT
	
func start_level_up(player: Player) -> void:
	level_up_in_queue=level_up_in_queue+1
	if level_up_in_queue == 1:
		level_up_menu.player = player
		level_up_menu.show()
		pause_game()

func _level_failed() -> void:
	loose_menu.show()
	
func end_level_up() -> void:
	level_up_menu.hide()
	level_up_in_queue=level_up_in_queue-1
	if level_up_in_queue > 0:
		level_up_menu.show()
	else: 
		play_game()
	
func show_pause_menu() -> void:
	pause_menu.show()
	pause_game()
	
func hide_pause_menu() -> void:
	pause_menu.hide()
	play_game()
