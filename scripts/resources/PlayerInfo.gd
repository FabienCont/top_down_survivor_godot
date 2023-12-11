extends Resource

class_name PlayerInfo

signal update_character
signal update_weapon_info
signal update_stats

@export var inventory_controller :InventoryController = InventoryController.new()
@export var upgrades_controller :UpgradesController = UpgradesController.new()
@export var stats_controller :StatsControllerEntity = StatsControllerEntity.new():
	set(updated_value):
		stats_controller = updated_value
		emit_update_xp_stats(updated_value)
@export var effects :EffectsController = EffectsController.new():
	set(updated_value):
		effects = updated_value
@export var weapon_info :WeaponInfo = WeaponInfo.new():
	set(updated_value):
		weapon_info = updated_value
		emit_update_weapon_info(updated_value)
@export var character :Character = Character.new():
	set(updated_value):
		character = updated_value
		emit_update_character(updated_value)

func emit_update_xp_stats(value_update: StatsControllerModel):
	update_stats.emit(value_update)

func emit_update_weapon_info(value_update: WeaponInfo):
	update_weapon_info.emit(value_update)

func emit_update_character(value_update: Character):
	update_character.emit(value_update)
