extends "res://scenes/enemies/Tank.gd"

func _ready():
	speed = 75
	hp = 400
	base_damage = 200
	reward = 100
	.set_up_health_bar()
