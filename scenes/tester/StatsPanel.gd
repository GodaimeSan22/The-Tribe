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
	stone_label.text = "Stone: " + str(player.stone)
	wood_label.text = "Wood: " + str(player.wood)
	food_label.text = "Food: " + str(player.food)
	health_label.text = "Health: " + str(player.health)
	bones_label.text = "Bones: " + str(player.bones)
	magic_label.text = "Magic: " + str(player.magic)
	mood_label.text = "Mood: " + str(player.mood)
	age_label.text = ": " + str(player.age)
