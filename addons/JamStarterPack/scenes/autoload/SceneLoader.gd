extends CanvasLayer

@onready var animation_player = $LoadingScreen/AnimationPlayer
@onready var transition_type: TransitionTypeEnum = TransitionTypeEnum.INSTANT

enum TransitionTypeEnum {
	LOADING_SCREEN,
	INSTANT
}

func _ready() -> void:
	Signals.level_loaded.connect(_on_finish_load)

func change_scene_to_file(target: String,transitionTypeSelected:TransitionTypeEnum = TransitionTypeEnum.INSTANT) -> void:
	transition_type = transitionTypeSelected
	if transition_type == TransitionTypeEnum.LOADING_SCREEN:
		await _show_loading_screen
		_transition_dissolve_to_file(target)
	else:
		_tree_change_scene_to_file(target)

func change_scene_to_packed(packedScene: PackedScene,transitionTypeSelected:TransitionTypeEnum = TransitionTypeEnum.LOADING_SCREEN) -> void:
	transition_type = transitionTypeSelected
	if transition_type == TransitionTypeEnum.LOADING_SCREEN:
		await _show_loading_screen
		_transition_dissolve_to_packed(packedScene)
	else:
		_tree_change_scene_to_packed(packedScene)

func _show_loading_screen():
	animation_player.play("loading_screen")
	return animation_player.animation_finished

func _tree_change_scene_to_file(target: String)-> void:
	get_tree().change_scene_to_file(target)

func _tree_change_scene_to_packed(packedScene: PackedScene) -> void:
	get_tree().change_scene_to_packed(packedScene)

func _transition_dissolve_to_file(target: String) -> void:
	await _show_loading_screen()
	_tree_change_scene_to_file(target)

func _transition_dissolve_to_packed(packedScene: PackedScene) -> void:
	await _show_loading_screen()
	_tree_change_scene_to_packed(packedScene)

func _on_finish_load() -> void:
	if transition_type != TransitionTypeEnum.INSTANT:
		_hide_loading_screen()

func _hide_loading_screen():
	animation_player.play_backwards("loading_screen")
