extends Ammo

@onready var trailEffectScene :PackedScene = preload("res://scenes/particles/TrailFireballEffect.tscn") 
func _ready():
	super()
	velocity_component.update_velocity(direction*2)
	var trail: GPUParticles2D = trailEffectScene.instantiate()
	add_child(trail)

func _process(delta):
	velocity_component.move_node(self)
	sprite.play("Idle")
