extends Node2D

onready var GrassEffect = load("res://Effects/GrasssEffect.tscn")
onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func destroy_grass():
	var grassEffect = GrassEffect.instance()
	grassEffect.global_position = global_position
	parent.add_child(grassEffect)
	queue_free()


func _on_HurtBox_area_entered(area):
	destroy_grass()
