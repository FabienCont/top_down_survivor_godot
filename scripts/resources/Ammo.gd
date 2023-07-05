extends Node2D
class_name Ammo

@onready var velocityComponent :VelocityComponent = $VelocityComponent 
@onready var sprite :AnimatedSprite2D = $sprite 
@onready var hitboxComponent :HitboxComponent = $HitboxComponent 
@export var SPEED :float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level=true
	hitboxComponent.connect("hit",_on_hitbox_component_hit)
	pass # Replace with function body.

func _process(delta: float) -> void:
	var direction = Vector2(1,0)
	direction = direction.rotated(global_rotation)
	velocityComponent.accelerate_in_direction(direction,delta)
	velocityComponent.move_node(self)
	
func _on_hitbox_component_hit(_attack: Attack) -> void:
	queue_free()
	pass # Replace with function body.
