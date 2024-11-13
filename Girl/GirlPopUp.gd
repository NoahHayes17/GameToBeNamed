extends Control

@export var display_time: float = 4.0

func _ready():
	await get_tree().create_timer(display_time).timeout
	queue_free()

func _on_timer_timeout():
	queue_free()
