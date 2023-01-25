extends Node2D


var built = false
var ready = true  # ready to shoot
var type


var towerdata = null # todo create dataclass mb
var enemies = []
var target

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

var fire_type: int = fire_behaviours.GUN_SHOT # enum fire_behaviours
var target_type: int = target_selectors.NEAREST # enum target_selectors



func setup(type_, position_):
	type = type_
	position = position_
	built = true

func _ready():
	if built:
		towerdata = GameData.tower_data[type]
		enable_range()

func enable_range():
	$Range/CollisionShape2D.get_shape().radius = 0.5 * towerdata["range"]
	
func _physics_process(delta):
	if enemies.size() != 0 and built:
		handle_enemies()
	else:
		target = null

func handle_enemies():
	select_target()
	if not $AnimationPlayer.is_playing():
		turn()
	if not $AnimationPlayer.is_playing() and ready:
		fire()
	
func select_target():
	var target_index = null
	match target_type:
		target_selectors.NEAREST:
			target_index = target_selector_get_index_nearest(enemies)
		target_selectors.LOW_HP:
			target_index = target_selector_get_index_low_hp(enemies)
		target_selectors.HIGH_HP:
			target_index = target_selector_get_index_max_hp(enemies)
		target_selectors.FASTEST:
			target_index = target_selector_get_index_fastest(enemies)
	if target_index != null:
		target = enemies[target_index]
	
func turn():
	if target:
		$Turret.look_at(target.position)
	
func fire():
	
	# TODO push nodes to those methods. (or interfaces to interact with nodes like start_animation_fire() etc)
	match fire_type:
		fire_behaviours.GUN_SHOT:
			fire_behaviour_gun_shot()
		fire_behaviours.LAUNCH_MISSILE:
			fire_behaviour_launch_missile()
		fire_behaviours.THROW_LIQUID:
			fire_behaviour_throw_liquid()

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

# turret should have animation player that plays muzzle flash animation with name Fire
func fire_behaviour_gun_shot():
	ready = false
	$AnimationPlayer.play("Fire")
	target.on_hit(towerdata['damage'])
	yield(get_tree().create_timer(towerdata['rof']), 'timeout')
	ready = true
	
func fire_behaviour_launch_missile():
	ready = false	
	# missile.launch(single_target)
	print("launch missile is not implemented")	
	yield(get_tree().create_timer(towerdata['rof']), 'timeout')	
	ready = true

func fire_behaviour_throw_liquid(): # or flame
	ready = false
	# suffering_enemies = get_spash_damage_victims(all_enemies, target)
	print("throwing liquid is not implemented")	
	yield(get_tree().create_timer(towerdata['rof']), 'timeout')	
	ready = true

######


######
######
######

