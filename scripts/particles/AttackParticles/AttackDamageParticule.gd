extends Node2D

@onready var attack_number:float
@onready var label: Label = $Node2D/Label
@onready var animation:AnimationPlayer = $Node2D/AnimationPlayer

func _ready() -> void:
	label.text = "- "+str(attack_number)
	top_level=true
