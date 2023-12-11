extends Ammo

@onready var emitter = get_parent()
@onready var follow_target_component:= FollowTargetComponent.new()
@onready var catchableTimer:Timer
@onready var is_catchable:=false

func _ready():
	super()
	follow_target_component.set_node_to_follow(emitter)
	follow_target_component.set_velocity_component(velocity_component)
	add_child(follow_target_component)
	velocity_component.update_velocity(direction * 7)
	catchableTimer =Timer.new()
	catchableTimer.one_shot=true
	catchableTimer.timeout.connect(active_catchable)
	add_child(catchableTimer)
	catchableTimer.start(0.4)
	
func active_catchable() -> void:
	is_catchable = true
	
func _process(delta: float) -> void:
	if (init_position.distance_to(global_position) > get_range_value()) || (is_catchable==true && global_position.distance_to(emitter.global_position) < 15):
		destroy()
	follow_target_component.follow_target(self, delta)
	rotate(20*delta)
	velocity_component.move_node(self)
