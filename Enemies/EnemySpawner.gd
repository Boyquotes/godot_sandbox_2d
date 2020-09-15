extends Node2D

export var max_enemies = 10
export var enemy = "res://Enemies/Bat.tscn"
export(NodePath) var parent_path
export var check_interval = 5
export var max_x = 20
export var max_y = 11

var Enemy = load(enemy)
onready var timer = $Timer
onready var enemy_box = get_node(parent_path)

func _ready():
	timer.wait_time = check_interval
	timer.start()
	
func _on_Timer_timeout():
	if enemy_box.get_child_count() < max_enemies:
		var new_enemy = Enemy.instance()
		new_enemy.position.x = ((randi() % max_x) - (max_x/2))  * 16
		new_enemy.position.y = ((randi() % max_y) - (max_y/2))  * 16
		new_enemy.position = new_enemy.position + position
		enemy_box.add_child(new_enemy)
