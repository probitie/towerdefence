extends Node2D

class_name FireBehaviour

func gun_shot(single_target, damage, delay):
	single_target.on_hit(damage)
	yield(get_tree().create_timer(delay), 'timeout')
	
func launch_missile(single_target, missile, delay):
	missile.launch(single_target)
	yield(get_tree().create_timer(delay), 'timeout')	

func throw_liquid(target, damage, delay): # or flame
	# suffering_enemies = get_spash_damage_victims(all_enemies, target)
	yield(get_tree().create_timer(delay), 'timeout')	
	
