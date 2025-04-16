extends Node2D  # або Node, якщо не використовуєш позиціювання

var preview_instance: Node2D
var placing := false

func start_placing(scene: PackedScene):
	if preview_instance:
		preview_instance.queue_free()
	preview_instance = scene.instantiate()
	get_tree().get_root().add_child(preview_instance)  # або add_child() — якщо хочеш в UI
	placing = true

func _process(delta):
	if placing and preview_instance:
		preview_instance.global_position = get_viewport().get_mouse_position()

func _input(event):
	if placing and event is InputEventMouseButton and event.pressed:
		print("✅ Поставлено будівлю:", preview_instance.name)
		placing = false
		preview_instance = null
