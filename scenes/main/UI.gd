extends CanvasLayer


func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://scenes/turrets/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ad54ff3c")
	
	# create range overlay
	var range_texture = Sprite.new()
	range_texture.position =  Vector2(32, 32)
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://assets/ui/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")
	
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child($TowerPreview, 0) # place gun under hud

func update_tower_preview(new_position, color):
	$TowerPreview.rect_position = new_position
	if($TowerPreview/DragTower.modulate != Color(color)):
		$TowerPreview/DragTower.modulate = Color(color)
		$TowerPreview/Sprite.modulate = Color(color)
		
