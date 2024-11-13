extends Node2D

@export var display_time: float = 4.0

var npc_dialogue_lines: Array = [
	"",
	"We have just confirmed a couple symptoms. You’re looking for white or red veins, they can be anywhere on the body.",
]

var player_responses: Array = [
	"[wave]Afternoon Doctor[/wave]",
	"[wave]Thank you[/wave]",
]

var current_line: int = 0

func _ready():
	$Accept.hide()
	$Reject.hide()
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

func _on_advance_pressed():
	current_line += 1  
	update_dialogue()

func end_scene():
	var new_scene = load("res://Doctor/DoctorSecondSymptoms.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free()  

	#get_tree().quit()
