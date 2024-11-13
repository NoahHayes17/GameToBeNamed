extends Node2D

var display_time: float = 4.0
var pop_up_scene_eye = load("res://Worker/WorkerPopUpEye.tscn")
var pop_up_scene_vein = load("res://Worker/WorkerPopUpVein.tscn")

var npc_dialogue_lines: Array = [
	"So, Doc, am I the next test subject or something? This whole ‘mystery disease’ bit sounds like a sci-fi plot, don’t you think?",
	"Nope, as healthy as a horse! No veins, no strange hair colors. I promise.",
]

var player_responses: Array = [
	"[wave]I just need to make sure you’re healthy. Any new symptoms or unusual signs lately?[/wave]",
	"[wave]Alright. That’s it for now. You’re good to go.[/wave]",
]

var current_line: int = 0

func _ready():
	$Advance/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectEye/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectVein/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Accept/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Reject/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	update_dialogue()

func update_dialogue():
	if current_line < npc_dialogue_lines.size():
		show_text($NPCText/RichTextLabel, npc_dialogue_lines[current_line])  
		$Advance/RichTextLabel.text = player_responses[current_line]  
	else:
		end_dialogue()  

func show_text(label: RichTextLabel, text: String) -> void:  
	label.clear()  
	for character in text:  
		label.append_text(character)
		await get_tree().create_timer(0.05).timeout  

func end_dialogue():
	$Advance.hide()  
	$Accept.show()  
	$Reject.show()  

func _on_advance_pressed():
	current_line += 1  
	update_dialogue()

func _on_inspect_worker_eye_pressed():
	print("Inspect button pressed")
	var new_pop_up_eye = pop_up_scene_eye.instantiate()
	new_pop_up_eye.display_time = display_time
	add_child(new_pop_up_eye)
	new_pop_up_eye.show()

func _on_inspect_worker_vein_pressed():
	print("Inspect button pressed")
	var new_pop_up_vein = pop_up_scene_vein.instantiate()
	new_pop_up_vein.display_time = display_time
	add_child(new_pop_up_vein)
	new_pop_up_vein.show()

func _on_accept_pressed():
	print("Player accepted")
	$Advance/RichTextLabel.hide()  
	get_node("/root/Desktop/Background/Folder/Folder/Worker").show()
	get_node("/root/Desktop").worker = true
	end_scene()

func _on_reject_pressed():
	print("Player rejected")
	$Advance/RichTextLabel.hide()  
	end_scene()

func end_scene():
	var new_scene = load("res://Desktop/Reminder.tscn").instantiate()
	get_parent().add_child(new_scene)
	queue_free()  
