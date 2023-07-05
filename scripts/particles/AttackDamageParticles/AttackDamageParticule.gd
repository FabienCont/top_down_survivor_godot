extends Node2D

@onready var attack_number:float
@onready var label: Label = $Node2D/Label
@onready var animation = $Node2D/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "- "+str(attack_number)
	top_level=true
	pass # Replace with function body.
