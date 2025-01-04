extends Resource

class_name StatDataAbstract

func _get_stat_key(_property_name:String) -> int:
	return 0
	
func _get_target() -> String:
	return "default"
	
func export_to_stat_controller() -> StatsController:
	var statController = StatsController.new()
	statController.target=_get_target()
	var properties = PropertiesHelper.get_filtered_resource_property_list_name(get_property_list())
	
	# Iterate over the properties
	for prop in properties:
		var key =_get_stat_key(prop.name)
		var stat = StatModel.new()
		stat.init_stat(key,get(prop.name))
		statController.stats_dico[key]= stat
		
	return statController
