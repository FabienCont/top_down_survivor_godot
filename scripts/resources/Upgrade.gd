extends Resource
class_name Upgrade

@export var type: UpgradeEnum.UPGRADE_TYPE;
@export var value: float;

static func get_upgrade_type_label(type: UpgradeEnum.UPGRADE_TYPE)-> String:
	return UpgradeEnum.UPGRADE_TYPE.keys()[type]
