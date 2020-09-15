extends KinematicBody2D

const FRICTION = 400
const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

export var friction = 400
export var max_speed = 50
export var acceleration = 400

var velocity = Vector2.ZERO
var state = IDLE
var destination = null

onready var stats = $Stats
onready var sprite = $Sprite

func _on_HurtBox_hurt(area):
	stats.health -=1
	velocity = area.knockback_vector * 120
	
func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		WANDER:
			pass
		CHASE: 
			if destination != null:
				var direction = (destination.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
				
	sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)

func _on_Stats_no_health():
	destroy_me()

func destroy_me():
	var deathEffect = DeathEffect.instance()
	deathEffect.position = position
	get_parent().add_child(deathEffect)
	queue_free()

func _on_PlayerDetectionZone_player_found(body):
	destination = body
	state = CHASE

func _on_PlayerDetectionZone_player_lost():
	state = IDLE
