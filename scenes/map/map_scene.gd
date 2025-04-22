extends Node2D

@onready var water: TileMapLayer = $GameTileMap/Water
@onready var grass: TileMapLayer = $GameTileMap/Grass
@onready var dirt: TileMapLayer = $GameTileMap/Dirt

const WATER_COLLISION_TILE_ID: int = 0
const WATER_VISUAL_TILE_ID: int = 5

func _ready() -> void:
	remove_hidden_water_collisions()

# replace water tiles with collision under grass or dirt with water tiles without collision
func remove_hidden_water_collisions() -> void:
	var used_cells: Array[Vector2i] = water.get_used_cells()  
	
	for cell in used_cells:
		var tile_id: int = water.get_cell_source_id(cell) 

		if tile_id == WATER_COLLISION_TILE_ID:
			var tile_at_grass: bool = grass.get_cell_source_id(cell) != -1
			var tile_at_dirt: bool = dirt.get_cell_source_id(cell) != -1
			
			if tile_at_grass or tile_at_dirt:
				water.set_cell(cell, WATER_VISUAL_TILE_ID, Vector2i(0, 0))  # Replace with water tile without collision
