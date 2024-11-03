extends "res://Worker/Worker.gd"

func _on_inspect_eye_pressed():
	print("Inspect button pressed")
	var new_pop_up = pop_up_scene.instantiate()  # This will use the overridden pop_up_scene
	new_pop_up.display_time = display_time
	add_child(new_pop_up)
	new_pop_up.show()
