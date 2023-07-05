extends Node

@export var tile_map: TileMap
@export var nav_region: NavigationRegion2D
@export var id_layer: int = 1

func _init():
	_bake()
func _bake():
	if tile_map ==null || nav_region == null :
		return
	
	var polygon = nav_region.navigation_polygon
	var tiles = tile_map.get_used_cells_by_id(id_layer)
	for tile in tiles:
		var array_polygon = PackedVector2Array()
		var polygon_offset = tile_map.map_to_local(tile) - Vector2(tile_map.get_cell_size()[0]/2, 0)
		var tile_region =tile_map.get_cell_atlas_coords(tile[0],tile[1])
		#var tile_transform =tile_map.get_tileset().get
		var tile_transform = Vector2(0,0)
	#var polygon_bp = tile_map.get_tileset().get_tile_shape().get
	
		var polygon_bp = tile_map.get_tileset().get_collision_polygon_points()
	
		for vertex in polygon_bp:
			vertex += polygon_offset
			array_polygon.append(tile_transform.xform(vertex))
		polygon.add_outline(array_polygon)
	nav_region.navigation_polygon = polygon
