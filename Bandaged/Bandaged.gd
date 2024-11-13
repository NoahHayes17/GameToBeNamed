extends Node2D

@export var display_time: float = 4.0
@export var pop_up_scene_bandaged_eye = load("res://Bandaged/BandagedPopUpEye.tscn")
@export var pop_up_scene_bandaged_vein = load("res://Bandaged/BandagedPopUpVein.tscn")

var npc_dialogue_lines: Array = [
	"So, you’re another one of the doctors, huh? Here to stare at my face?",
	"Feeling as ‘alright’ as you can feel when you’re locked in here for days. No one’s told me anything.",
	"Almost done? That’s what they all say.",
]

var player_responses: Array = [
	"[wave]I just need to check for anything unusual. You’ve been feeling alright?[/wave]",
	"[wave]We’re almost done here.[/wave]",
	"[wave]Thank you for your time.[/wave]"
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

func _on_inspect_bandaged_eye_pressed():
	print("Inspect button pressed")
	var new_pop_up_eye = pop_up_scene_bandaged_eye.instantiate()
	new_pop_up_eye.display_time = display_time
	add_child(new_pop_up_eye)
	new_pop_up_eye.show()

func _on_inspect_bandaged_vein_pressed():
	print("Inspect button pressed")
	var new_pop_up_vein = pop_up_scene_bandaged_vein.instantiate()
	new_pop_up_vein.display_time = display_time
	add_child(new_pop_up_vein)
	new_pop_up_vein.show()

func _on_accept_pressed():
	print("Player accepted")
	$Advance/RichTextLabel.hide()  
	get_node("/root/Desktop/Background/Folder/Folder/Bandage").show()
	get_node("/root/Desktop").bandage = true
	end_scene()

func _on_reject_pressed():
	print("Player rejected")
	$Advance/RichTextLabel.hide() 
	end_scene()

func end_scene():
	var new_scene = load("res://Desktop/Reminder.tscn").instantiate()
	get_parent().add_child(new_scene)
	queue_free()  
