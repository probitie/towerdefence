extends Node2D


var built = false
var ready_to_shoot = true
var type


var towerdata = null # todo create dataclass mb
var enemies = []
var target
var fire_type: int  # enum fire_behaviours
var target_type: int  # enum target_selectors

var target_selector = TargetSelector
var fire_behaviour = FireBehaviour

enum fire_behaviours {
	GUN_SHOT,
	LAUNCH_MISSILE,
	THROW_LIQUID
}
enum target_selectors {
	NEAREST,
	LOW_HP,
	HIGH_HP,
	FASTEST
}

func _init(type_):
	type = type_

func _ready():
	towerdata = GameData.tower_data[type]
	if built:
		enable_range()

func enable_range():
	$Range/CollisionShape2D.get_shape().radius = 0.5 * towerdata["range"]
	
func _physics_process(delta):
	if enemies.size() != 0 and built:
		handle_enemies()
	else:
		target = null

func handle_enemies():
	print(str(type) + ": you should write custom enemy handling function")
	
func select_target():
	match target_type:
		target_selectors.NEAREST:
			target = target_selector_get_index_nearest(enemies)
		target_selectors.LOW_HP:
			target = target_selector_get_index_low_hp(enemies)
		target_selectors.HIGH_HP:
			target = target_selector_get_index_max_hp(enemies)
		target_selectors.FASTEST:
			target = target_selector_get_index_fastest(enemies)

func turn():
	$Turret.look_at(target.position)
	
func fire():
	
	# TODO push nodes to those methods. (or interfaces to interact with nodes like start_animation_fire() etc)
	match fire_type:
		fire_behaviours.GUN_SHOT:
			fire_behaviour_gun_shot(target, towerdata['damage'], towerdata['rof'])
		fire_behaviours.LAUNCH_MISSILE:
			fire_behaviour_launch_missile(target, towerdata['damage'], towerdata['rof'])
		fire_behaviours.THROW_LIQUID:
			fire_behaviour_throw_liquid(target, towerdata['damage'], towerdata['rof'])

func _on_Range_body_entered(body):
	enemies.append(body.get_parent())

func _on_Range_body_exited(body):
	enemies.erase(body.get_parent())


##
## FIRE/TARGET MODE FUNCTIONS
##

## target selection

func target_selector_get_index_nearest(enemies) -> int:
	var enemy_progress_array = []
	for i in enemies:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	return enemy_index
	
func target_selector_get_index_low_hp(enemies) -> int:
	print("get low hp index is not implemented")
	return -1
	
func target_selector_get_index_max_hp(enemies) -> int:
	print("get maxhp index is not implemented")
	return -1

func target_selector_get_index_fastest(enemies) -> int:
	print("get low hp index is not implemented")
	return -1

func target_selector_get_index_max_enemies_around(enemies) -> int: # to provide more spash damage
	print("get max enemies around is not implemented")
	return -1

######

## fire mode

func fire_behaviour_gun_shot(single_target, damage, delay):
	single_target.on_hit(damage)
	yield(get_tree().create_timer(delay), 'timeout')
	
func fire_behaviour_launch_missile(single_target, missile, delay):
	missile.launch(single_target)
	print("launch missile is not implemented")	
	yield(get_tree().create_timer(delay), 'timeout')	

func fire_behaviour_throw_liquid(target, damage, delay): # or flame
	# suffering_enemies = get_spash_damage_victims(all_enemies, target)
	print("throwing liquid is not implemented")	
	yield(get_tree().create_timer(delay), 'timeout')	

######


######
######
######

