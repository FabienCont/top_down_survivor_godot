class_name PropertiesHelper

static var default_resource_props = Resource.new().get_property_list().map(func(prop): return prop.name)

static func get_filtered_resource_property_list_name(caller_property_list: Array[Dictionary])-> Array[Dictionary]:
	var list = caller_property_list.filter(func(prop): return not default_resource_props.has(prop.name) && prop.usage != 128)
	return list
