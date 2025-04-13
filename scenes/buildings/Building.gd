extends Node2D



var building_name: String = "Default Building"
var hit_points: int = 100

func take_damage(amount: int):
	hit_points -= amount
	if hit_points <= 0:
		queue_free()

func play_animation(anim_name: String):
	var sprite_node = get_node_or_null("Sprite")
	if sprite_node and sprite_node is AnimatedSprite2D:
		if sprite_node:
			sprite_node.play(anim_name)
	else:
		print("❌ Sprite not found or is not AnimatedSprite2D")
