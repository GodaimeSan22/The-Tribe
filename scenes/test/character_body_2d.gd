extends CharacterBody2D
class_name Player

@export var speed: int = 100  

# Параметри персонажа
var stone: int = 0
var wood: int = 0
var food: int = 0
var health: int = 100
var bones: int = 0
var magic: int = 50
var mood: int = 100
var age: int = 20

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D  
@onready var hud: Node = $"../HUD"  # Шлях до панелі HUD

# Список ресурсів на карті
var resources: Array = []

func _ready():
	# Перевіряємо чи панель HUD знайдена
	if hud:
		hud.update_hud(self)
	else:
		print("⚠ HUD не знайдено!")



func _process_input() -> Vector2:
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		anim_sprite.play("run_right")
	elif Input.is_action_pressed("ui_accept"):  # Пробіл
		anim_sprite.play("special")
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
		anim_sprite.play("idle_right")  # Додаємо очікування

	return direction.normalized()

func _physics_process(delta: float):
	var direction = _process_input()
	velocity = direction * speed
	move_and_slide()

# Оновлення параметрів персонажа
func update_stat(stat: String, value: int):
	match stat:
		"stone": stone += value
		"wood": wood += value
		"food": food += value
		"health": health = clamp(health + value, 0, 100)
		"bones": bones += value
		"magic": magic = clamp(magic + value, 0, 100)
		"mood": mood = clamp(mood + value, 0, 100)
		"age": age += value

	if hud:
		hud.update_hud(self)

# Функція для збільшення параметрів при натисканні пробілу
func _input(event):
	if event.is_action_pressed("ui_accept"):  # Пробіл
		# Збільшуємо ресурси або інші параметри
		update_stat("stone", 5)  # Додаємо 5 каменя
		update_stat("wood", 3)   # Додаємо 3 дерева
		update_stat("food", 2)   # Додаємо 2 їжі
		update_stat("health", 10)  # Збільшуємо здоров'я на 10
		print("Ресурси оновлені!")
