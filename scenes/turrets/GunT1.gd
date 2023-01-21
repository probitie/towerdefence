extends "res://scenes/turrets/Turrets.gd"

func fire_process():
	$AnimationPlayer.play("Fire")
	enemy.on_hit(GameData.tower_data[type]['damage'])
	yield(get_tree().create_timer(GameData.tower_data[type]['rof']), 'timeout')

