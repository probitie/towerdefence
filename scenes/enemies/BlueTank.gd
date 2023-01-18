extends PathFollow2D

signal base_damage(damage)

var speed = 150
var hp = 100
var base_damage = 21

onready var health_bar = $HealthBar
onready var impact_area = $Impact
var projectile_impact = preload("res://scenes/support/ProjectileImpact.tscn")


func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_toplevel(true) # disconnect position, rotation of the tank from hp bar

func _physics_process(delta):
	if unit_offset == 1.0:
		emit_signal("base_damage", base_damage)
		queue_free()
	move(delta)

func move(delta):
	set_offset(get_offset() + speed * delta)
	health_bar.set_position(position + Vector2(-22, -29))
	

func on_hit(damage):
	impact()
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()

func impact():
	randomize()
	var x_pos = randi() % 31
	randomize()
	var y_pos = randi() % 31
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = projectile_impact.instance()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_destroy():
	$KinematicBody2D.queue_free()  # delete kinematicbody so turret will not fire it again
	yield(get_tree().create_timer(0.2), "timeout")
	self.queue_free() # delete tank after a delay to allow impact animation finish playing
