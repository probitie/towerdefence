extends Node2D

signal game_finished(result)

var map_node
var build_mode
var build_location
var build_type
var build_valid
var build_tile

var current_wave = 0
var enemies_in_wave = 0
var starting_wave = false  # like mutex
var enemies_left = 0

var base_health = 100
var start_money = 80

func _ready():
	map_node = $Map1
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])
	$UI.set_money(start_money)

func _process(delta):
	if build_mode:
		update_tower_preview()
	

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave functions
##
func start_next_wave():
	starting_wave = true
	current_wave += 1
	yield(get_tree().create_timer(3), "timeout")
	$UI.set_wave(current_wave)
	var wave_data = retrieve_wave_data()
	enemies_left = len(wave_data)
	spawn_enemies()
	starting_wave = false

func retrieve_wave_data():
	var raw_wave_data = []
	
	
	if current_wave - 1 == len(GameData.wave_data):
		print("you win uwu")
		emit_signal("game_finished", "victory")
		return [] # todo maybe yield timer to wait until it process the signal
		
	for tanks_part in GameData.wave_data[current_wave - 1]["tanks"]:
		for i in range(tanks_part["repeat"]):
			raw_wave_data.append([tanks_part["type"], tanks_part["delay"]])
		
	enemies_in_wave = len(raw_wave_data)
	return raw_wave_data

func spawn_enemies():
	var wave_data = retrieve_wave_data()
	for i in wave_data:
		var new_enemy = load("res://scenes/enemies/" + i[0] + ".tscn").instance()
		new_enemy.connect("base_damage", self, "on_base_damage")
		new_enemy.connect("kill", self, "on_killing_enemy")
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]), "timeout")

func on_base_damage(damage):
	base_health -= damage
	if base_health <= 0:
		emit_signal("game_finished", false)
	else:
		$UI.update_health_bar(base_health)

##
## BUILD FUNCTIONS
##
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	if not $UI.can_buy(GameData.tower_data[build_type]["price"]):
		print("can not affort this turret")
		return
	build_mode = true
	$UI.set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
		$UI.update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		$UI.update_tower_preview(tile_position, "adff4545")
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	$UI/TowerPreview.free()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://scenes/turrets/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		new_tower.type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		new_tower.built = true
		$UI.buy(GameData.tower_data[build_type]["price"])
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 6)

func on_killing_enemy(money):
	$UI.earn(money)
	enemies_left -= 1
	if enemies_left <= 0 and not starting_wave:
		start_next_wave()
