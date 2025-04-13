extends "res://scenes/buildings/Building.gd"

var resources = {
	"Wood": 0,
	"Stones": 0,
	"Meat": 0,
	"Plants": 0,
	"Leather": 0
}

var is_highlighted = false

func _ready():
	play_animation("idle")
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_viewport().get_mouse_position()
		var local_mouse_pos = to_local(mouse_pos)

		var shape = $Background/PlacementArea/CollisionShape2D.shape
		if shape is RectangleShape2D:
			var rect = Rect2(-shape.extents, shape.extents * 2)
			if rect.has_point(local_mouse_pos):
				toggle_highlight()

func toggle_highlight():
	is_highlighted = !is_highlighted
	if is_highlighted:
		modulate = Color(1, 0, 0) 
	else:
		modulate = Color(1, 1, 1)  

func add_resource(resource_name: String, amount: int):
	if resources.has(resource_name):
		resources[resource_name] += amount

func get_resource_amount(resource_name: String) -> int:
	if resources.has(resource_name):
		return resources[resource_name]
	return 0
