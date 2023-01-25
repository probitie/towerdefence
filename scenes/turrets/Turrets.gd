extends Node2D


var built = false
var ready_to_shoot = true
var type


var towerdata = null # todo create dataclass mb
var enemies = []
var target
var fire_type: int  # enum fire_behaviours
var target_type: int  # enum target_selectors

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
			pass
		target_selectors.LOW_HP:
			pass
		target_selectors.HIGH_HP:
			pass
		target_selectors.FASTEST:
			pass

func turn():
	$Turret.look_at(target.position)
	
func fire():
	match fire_type:
		fire_behaviours.GUN_SHOT:
			pass
		fire_behaviours.LAUNCH_MISSILE:
			pass
		fire_behaviours.THROW_LIQUID:
			pass

func _on_Range_body_entered(body):
	enemies.append(body.get_parent())

func _on_Range_body_exited(body):
	enemies.erase(body.get_parent())

func get_tower_damage():
	return towerdata['damage']
