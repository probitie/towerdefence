extends Node

class_name TargetSelector

func get_index_nearest(enemies) -> int:
	var enemy_progress_array = []
	for i in enemies:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	return enemy_index
	
func get_index_low_hp(enemies) -> int:
	print("get low hp index is not implemented")
	return -1
	
func get_index_max_hp(enemies) -> int:
	print("get maxhp index is not implemented")
	return -1

func get_index_fastest(enemies) -> int:
	print("get low hp index is not implemented")
	return -1

func get_index_max_enemies_around(enemies) -> int: # to provide more spash damage
	print("get low hp index is not implemented")
	return -1
