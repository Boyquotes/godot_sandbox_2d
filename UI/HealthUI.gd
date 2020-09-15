extends Control

onready var label = $Label
onready var empty = $HeartUIEmpty
onready var full = $HeartUIFull

const heart_tile_width = 15

func _ready():
	PlayerStats.connect("health_changed", self, "update_health")
	update_health(PlayerStats.health)
	empty.rect_size.x = PlayerStats.max_health * heart_tile_width

func update_health(value):
	full.rect_size.x = value * heart_tile_width
	label.text = "HP: " + str(value)
	if value == 0:
		full.visible = false
	else:
		full.visible = true
