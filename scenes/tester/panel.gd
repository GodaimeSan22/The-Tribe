extends Panel

@onready var stone_label: Label = $VBoxContainer/Label_Stone
@onready var wood_label: Label = $VBoxContainer/Label_Wood
@onready var food_label: Label = $VBoxContainer/Label_Food
@onready var health_label: Label = $VBoxContainer/Label_Health
@onready var bones_label: Label = $VBoxContainer/Label_Bones
@onready var magic_label: Label = $VBoxContainer/Label_Magic
@onready var mood_label: Label = $VBoxContainer/Label_Mood
@onready var age_label: Label = $VBoxContainer/Label_Age

# Оновлення значень на панелі
func update_hud(player: Player):
	stone_label.text = "Камінь: " + str(player.stone)
	wood_label.text = "Дерево: " + str(player.wood)
	food_label.text = "Їжа: " + str(player.food)
	health_label.text = "Здоров'я: " + str(player.health)
	bones_label.text = "Кістки: " + str(player.bones)
	magic_label.text = "Магія: " + str(player.magic)
	mood_label.text = "Настрій: " + str(player.mood)
	age_label.text = "Вік: " + str(player.age)
