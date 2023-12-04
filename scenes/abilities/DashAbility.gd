extends Node2D


@onready var is_dashing := false
@onready var dash_shadow_count:=0
@onready var dash_timer:=Timer.new()
@onready var dash_ready:=true
@onready var dash_cooldown:= 2.0

@onready var possessor = get_parent()

signal finished

func _ready():
	dash_timer.timeout.connect(refresh_dash)
	add_child(dash_timer)
	
func refresh_dash() -> void:
	dash_ready=true
	
func end_dash()->void:
	possessor.velocity_component.update_velocity(Vector2.ZERO )
	is_dashing = false
	dash_timer.start(dash_cooldown)
	finished.emit()
	
func create_ghost(_delta:float) -> void:
	DashGhostHelper.create_ghost(possessor,possessor.sprite)

func can_dash() -> bool:
	return is_dashing == false && dash_ready == true

func update_dash(delta: float) -> void:
	if(dash_shadow_count%2==0):
		create_ghost(delta)
	dash_shadow_count+=1
	possessor.velocity_component.move(self)
	
func execute(_delta:float,parent)->void:
	dash_shadow_count=0
	is_dashing = true
	dash_ready=false
	var direction = possessor.get_current_direction()
	possessor.velocity_component.update_velocity(direction * 165 )
	possessor.velocity_component.move(parent)
	var timer = Timer.new()
	timer.one_shot=true
	timer.timeout.connect(end_dash)
	add_child(timer)
	timer.start(0.165)
