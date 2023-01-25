extends "res://scenes/turrets/Turrets.gd"

func fire_process():
	#$AnimationPlayer.play("Fire")
	target.on_hit(get_tower_damage())
	yield(get_tree().create_timer(GameData.tower_data[type]['rof']), 'timeout')


func turn_and_fire():
	turn()
	fire()
