extends Control

# Display time in seconds before the popup disappears
@export var display_time: float = 4.0

func _ready():
	# Start a timer to automatically close the popup after display_time
	await get_tree().create_timer(display_time).timeout
	# Remove the popup from the scene after the display time
	queue_free()

func _on_timer_timeout():
	queue_free()
