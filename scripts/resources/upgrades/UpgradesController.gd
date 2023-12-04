extends Resource

class_name UpgradesController

signal upgrade_added(upgrade :Upgrade)
signal upgrade_removed(upgrade :Upgrade)
@export var upgrades: Array[Upgrade] = []

func add_upgrade(upgrade :Upgrade):
	upgrades.push_back(upgrade)
	upgrade_added.emit(upgrade)
	

func remove_upgrade(upgrade :Upgrade):
	upgrades.erase(upgrade)
	upgrade_removed.emit(upgrade)
