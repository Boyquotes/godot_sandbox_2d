extends Area2D

func _on_PlayerDetectionZone_body_entered(body):
	emit_signal("player_found", body)

func _on_PlayerDetectionZone_body_exited(body):
	emit_signal("player_lost")

signal player_found(body)
signal player_lost()
