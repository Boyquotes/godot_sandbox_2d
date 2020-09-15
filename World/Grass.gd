extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func destroy_grass():
	var grassEffect = GrassEffect.instance()
	grassEffect.global_position = global_position
	get_parent().add_child(grassEffect)
	queue_free()

func _on_HurtBox_area_entered(area):
	destroy_grass()
