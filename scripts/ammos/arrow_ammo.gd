extends Ammo

@onready var trailEffectScene :PackedScene = preload("res://scenes/particles/TrailArrowEffect.tscn") 

func _ready():
	super()
	velocity_component.update_velocity(direction * 5)
	var trail: GPUParticles2D = trailEffectScene.instantiate()
	add_child(trail)
