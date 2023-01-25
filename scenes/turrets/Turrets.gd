extends Node2D

var built = false
var ready_to_shoot = true

var type
var towerdata = null # create dataclass mb
var enemies = []
var target

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
	

func turn():
	$Turret.look_at(target.position)
	
func fire():
	pass

func _on_Range_body_entered(body):
	enemies.append(body.get_parent())

func _on_Range_body_exited(body):
	enemies.erase(body.get_parent())

func get_tower_damage():
	return towerdata['damage']
