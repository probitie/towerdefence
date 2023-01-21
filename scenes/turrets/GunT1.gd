extends "res://scenes/turrets/Turrets.gd"

func fire_process():
	$AnimationPlayer.play("Fire")
	enemy.on_hit(get_tower_damage())
	yield(get_tree().create_timer(GameData.tower_data[type]['rof']), 'timeout')

func turn_and_fire():
	if not $AnimationPlayer.is_playing():
		turn()
	if not $AnimationPlayer.is_playing() and ready:
		fire()
