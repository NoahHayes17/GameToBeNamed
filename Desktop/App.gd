extends Panel

# Variables to store dragging state
var dragging = false
var drag_offset = Vector2()
@onready var title_bar = get_node("Title Bar")

# Called every frame while the mouse is moved
func _process(_delta):
	if dragging:
		# Update the position of the app window to the mouse's position
		var new_position = get_global_mouse_position() - drag_offset
		position = new_position

# Check when the mouse button is pressed on the panel
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Check if the press is within the bounds of the panel (App window)
				if title_bar.get_rect().has_point(event.position-position):
					# Start dragging if the click is inside the panel
					dragging = true
					drag_offset = event.position-position  # Save the mouse offset within the panel
			else:
				# Stop dragging when the mouse button is released
				dragging = false


func _on_close_pressed():
	queue_free()
