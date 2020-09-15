extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export(bool) var show_hit_effect = true
export var effect_offset_y = 0
export var effect_offset_x = 0


func _on_HurtBox_area_entered(area):
	if show_hit_effect:
		var effect = HitEffect.instance()
		var parent = get_parent()
		parent.add_child(effect)
		effect.position = position + Vector2(effect_offset_x, effect_offset_y)
