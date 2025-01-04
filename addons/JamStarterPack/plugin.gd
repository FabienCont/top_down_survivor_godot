@tool
extends EditorPlugin

#const PluginClassUtils = "PluginClassUtils"
#
#func _enter_tree():
	#add_autoload_singleton(PluginClassUtils,"./autoload_plugin_class_register.gd" )
#
#func _exit_tree():
	#remove_autoload_singleton(PluginClassUtils)

func _enter_tree() -> void:
	add_custom_type(
		"EffectInfo", # *seems* must be the same as the class_name in the gdscript
		"Resource", # or whatever
		preload("res://addons/JamStarterPack/resources/effects/EffectInfo.gd"),
		preload("res://icon.svg") # this seems to be the magic
	)
