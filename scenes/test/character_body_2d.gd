extends CharacterBody2D

@export var speed = 70  # Швидкість руху
@onready var anim_sprite = $AnimatedSprite2D  # Отримуємо доступ до анімаційного спрайта

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		anim_sprite.play("run_right")
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		anim_sprite.play("run_left")
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		anim_sprite.play("run_down")
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		anim_sprite.play("run_up")
	else:
		anim_sprite.play("idle_down")  # Якщо персонаж стоїть, вмикаємо анімацію "idle"
	
	direction = direction.normalized()  # Уникаємо збільшення швидкості по діагоналі
	velocity = direction * speed
	move_and_slide()
