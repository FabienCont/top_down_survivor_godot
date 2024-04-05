extends Control

@onready var game_world = $SubViewportContainerGame/SubViewport/GardenLevel
@onready var clock = $SubViewportContainerUI/SubViewport2/VBoxContainerUI/Timer
@onready var ui_container = $SubViewportContainerUI/SubViewport2/VBoxContainerUI
@onready var timer_display =$SubViewportContainerUI/SubViewport2/VBoxContainerUI/Timer
@onready var pause_menu = $pause
@onready var loose_menu = $loose_menu
@onready var win_menu = $win_menu
@onready var level_up_menu = $level_up
@onready var dash_ready_ui = $DashReadyUI

@onready var is_paused: bool = false
@onready var level_up_in_queue: int = 0
@onready var game_clock = GameClock.new()

func _ready() -> void:
	game_clock.wave = 1
	timer_display.game_clock = game_clock
	Signals.start_level_up.connect(start_level_up)
	Signals.end_level_up.connect(end_level_up)
	Signals.start_pause_menu.connect(show_pause_menu)
	Signals.end_pause_menu.connect(hide_pause_menu)
	Signals.player_ready.connect(_set_ui_ability)
	Signals.player_died.connect(_level_failed)
	Signals.boss_died.connect(_level_succeed)
	game_world.init(game_clock,GlobalInfo.player_info)

func _process(delta: float) -> void:
	if is_paused == false:
		game_clock.time = game_clock.time+ delta
		if game_clock.time > game_clock.wave * 60 :
			game_clock.wave = game_clock.wave + 1
		
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
	
func start_level_up(player_info: PlayerInfo) -> void:
	level_up_in_queue=level_up_in_queue+1
	if level_up_in_queue == 1:
		level_up_menu.player_info = player_info
		level_up_menu.show()
		pause_game()

func _set_ui_ability(player:Player) -> void:
	dash_ready_ui.init_ability(player.abilities_controller.get_ability("dash"))
	
func _level_failed() -> void:
	loose_menu.show()

func _level_succeed() -> void:
	win_menu.show()
	
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
