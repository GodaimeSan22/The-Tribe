extends "res://addons/gut/test.gd"

func create_scene_instance() -> Node2D:
	var scene = load("res://scenes/map/map_scene.tscn").instantiate()
	add_child_autoqfree(scene)
	return scene

# If grass changes water
func test_removes_water_with_grass_above():
	var scene = create_scene_instance()
	scene._ready()

	var cell := Vector2i(1, 1)
	scene.water.set_cell(cell, scene.WATER_COLLISION_TILE_ID, Vector2i(0, 0))
	scene.grass.set_cell(cell, 1, Vector2i(0, 0))  # трава
	scene.dirt.set_cell(cell, -1, Vector2i(0, 0))

	scene.remove_hidden_water_collisions()

	var new_tile_id: int = scene.water.get_cell_source_id(cell)
	assert_eq(new_tile_id, scene.WATER_VISUAL_TILE_ID)

# 2. If dirt changes water
func test_removes_water_with_dirt_above():
	var scene = create_scene_instance()
	scene._ready()

	var cell := Vector2i(2, 2)
	scene.water.set_cell(cell, scene.WATER_COLLISION_TILE_ID, Vector2i(0, 0))
	scene.grass.set_cell(cell, -1, Vector2i(0, 0))
	scene.dirt.set_cell(cell, 1, Vector2i(0, 0))  # ґрунт

	scene.remove_hidden_water_collisions()

	var new_tile_id: int = scene.water.get_cell_source_id(cell)
	assert_eq(new_tile_id, scene.WATER_VISUAL_TILE_ID)

# 3. If we have nothing to change
func test_does_not_replace_if_nothing_above():
	var scene = create_scene_instance()
	scene._ready()

	var cell := Vector2i(3, 3)
	scene.water.set_cell(cell, scene.WATER_COLLISION_TILE_ID, Vector2i(0, 0))
	scene.grass.set_cell(cell, -1, Vector2i(0, 0))
	scene.dirt.set_cell(cell, -1, Vector2i(0, 0))

	scene.remove_hidden_water_collisions()

	var new_tile_id: int = scene.water.get_cell_source_id(cell)
	assert_eq(new_tile_id, scene.WATER_COLLISION_TILE_ID)

# 4. If water ceil doesn`t have collision rectangle
func test_ignores_non_collision_water():
	var scene = create_scene_instance()
	scene._ready()

	var cell := Vector2i(4, 4)
	scene.water.set_cell(cell, scene.WATER_VISUAL_TILE_ID, Vector2i(0, 0))  # уже "без колізії"
	scene.grass.set_cell(cell, 1, Vector2i(0, 0))  # хоч трава і є — ігнорується

	scene.remove_hidden_water_collisions()

	var new_tile_id: int = scene.water.get_cell_source_id(cell)
	assert_eq(new_tile_id, scene.WATER_VISUAL_TILE_ID)

# 5.Test for combination of terains
func test_mixed_cells_multiple_replacements():
	var scene = create_scene_instance()
	scene._ready()

	var change_cell_1 := Vector2i(5, 5)
	var change_cell_2 := Vector2i(6, 6)
	var untouched_cell := Vector2i(7, 7)

	# Changebles
	scene.water.set_cell(change_cell_1, scene.WATER_COLLISION_TILE_ID, Vector2i(0, 0))
	scene.grass.set_cell(change_cell_1, 1, Vector2i(0, 0))
	scene.dirt.set_cell(change_cell_1, -1, Vector2i(0, 0))

	scene.water.set_cell(change_cell_2, scene.WATER_COLLISION_TILE_ID, Vector2i(0, 0))
	scene.grass.set_cell(change_cell_2, -1, Vector2i(0, 0))
	scene.dirt.set_cell(change_cell_2, 1, Vector2i(0, 0))

	# None test
	scene.water.set_cell(untouched_cell, scene.WATER_COLLISION_TILE_ID, Vector2i(0, 0))
	scene.grass.set_cell(untouched_cell, -1, Vector2i(0, 0))
	scene.dirt.set_cell(untouched_cell, -1, Vector2i(0, 0))

	scene.remove_hidden_water_collisions()

	assert_eq(scene.water.get_cell_source_id(change_cell_1), scene.WATER_VISUAL_TILE_ID)
	assert_eq(scene.water.get_cell_source_id(change_cell_2), scene.WATER_VISUAL_TILE_ID)
	assert_eq(scene.water.get_cell_source_id(untouched_cell), scene.WATER_COLLISION_TILE_ID)
