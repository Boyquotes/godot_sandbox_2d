extends YSort

export var max_enemies = 10
export var enemy = "res://Enemies/Bat.tscn"
export var check_interval = 5
export var max_x = 20
export var max_y = 11

var Enemy = load(enemy)
onready var timer = $Timer
onready var enemy_box = $EnemyContainer

func _ready():
	timer.wait_time = check_interval
	timer.start()
	
func _on_Timer_timeout():
	if enemy_box.get_child_count() < max_enemies:
		var new_enemy = Enemy.instance()
		new_enemy.position.x = (randi() % max_x)  * 16
		new_enemy.position.y = (randi() % max_y)  * 16
		enemy_box.add_child(new_enemy)
