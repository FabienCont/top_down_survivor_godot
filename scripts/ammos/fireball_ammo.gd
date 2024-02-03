extends Ammo

@onready var trailEffectScene :PackedScene = preload("res://scenes/particles/TrailFireballEffect.tscn") 
@onready var follow_target_component: FollowTargetComponent2D = $FollowTargetComponent
func _ready():
	super()
	follow_target_component.target = get_tree().get_nodes_in_group("players")[0]
	velocity_component.update_velocity(direction*2)
	var trail: GPUParticles2D = trailEffectScene.instantiate()
	add_child(trail)

func _process(delta):
	follow_target_component.follow_target(self,delta)
	velocity_component.move_node(self)
	sprite.play("Idle")
