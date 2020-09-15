extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export(bool) var show_hit_effect = true
export var effect_offset_y = 0
export var effect_offset_x = 0
export var invincibility_duration = 3

onready var timer = $Timer

var invincible = false
var damager_count = 0
var hurt_area = null

signal invincibility_started
signal invincibility_ended
signal hurt(area)

func start_invincibility(duration):
	invincible = true
	emit_signal("invincibility_started")
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var parent = get_parent()
	parent.add_child(effect)
	effect.position = position + Vector2(effect_offset_x, effect_offset_y)
	
func hurt_me():
	emit_signal("hurt", hurt_area)
	start_invincibility(invincibility_duration)
	if show_hit_effect:
		create_hit_effect()

func _on_Timer_timeout():
	if damager_count > 0:
		hurt_me()
	else:
		invincible = false
		emit_signal("invincibility_ended")
	
func _on_HurtBox_area_entered(area):
	damager_count += 1
	hurt_area = area
	if damager_count == 1:
		hurt_me()

func _on_HurtBox_area_exited(area):
	damager_count -= 1
	if damager_count == 0:
		hurt_area = null
