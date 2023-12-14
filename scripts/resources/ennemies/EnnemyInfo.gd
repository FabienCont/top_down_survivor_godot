extends Resource

class_name EnnemyInfo

@export var name :String = "undefined"
@export var sprite: PackedScene
@export var upgrades_controller :UpgradesController = UpgradesController.new()
@export var stats_controller :StatsControllerEntity = StatsControllerEntity.new()
@export var effects :EffectsController = EffectsController.new()
@export var weapon_info :WeaponInfo = WeaponInfo.new()
