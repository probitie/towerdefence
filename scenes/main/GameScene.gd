extends Node2D

var map_node
var build_mode
var build_location
var build_type
var build_valid

func _ready():
	map_node = $Map1
	
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])


func _process(delta):
	if build_mode:
		update_tower_preview()
	

func _unhandled_input(event):
	pass

func initiate_build_mode(tower_type):
	build_type = tower_type + "T1"
	build_mode = true
	$UI.set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true
		build_location = tile_position
	else:
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = false

func cancel_build_mode():
	pass

func verify_and_build():
	pass
