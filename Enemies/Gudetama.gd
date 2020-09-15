extends KinematicBody2D


const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var stats = $Stats


func destroy_me():
	var deathEffect = DeathEffect.instance()
	deathEffect.position = position
	get_parent().add_child(deathEffect)
	queue_free()


func _on_Stats_no_health():
	destroy_me()

func _on_HurtBox_hurt(area):
	print("Health" + str(stats.health))
	stats.health -= 1
