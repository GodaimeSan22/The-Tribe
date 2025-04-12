extends Panel

@export var building_scene: PackedScene

func _ready():
	print("🪵 Панель готова:", name)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var building_ui = get_parent().get_parent().get_parent()  # CanvasLayer → VBoxContainer → BuildingUI
		if building_scene:
			building_ui.start_placing(building_scene)
		else:
			print("❌ building_scene не задано для:", name)
