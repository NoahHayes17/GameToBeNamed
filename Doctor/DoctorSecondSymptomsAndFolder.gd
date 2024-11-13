extends Node2D

@export var display_time: float = 4.0

var npc_dialogue_lines: Array = [
	"",
	"Today, we received more info: white hair or eyelashes may indicate risk factors.",
	"All our local systems got a new app installed where you can see photos of patients which other doctors have taken in light of the new information regarding symptoms. It’s crucial to cross-check the last few cases to be thorough.",
]

var player_responses: Array = [
	"[wave]Hello Doctor[/wave]",
	"[wave]Thats very useful, thank you again.[/wave]",
	"[wave]Ah, rather neet. I'll check now[/wave]",
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
	get_node("/root/Desktop/Taskbar/HBoxContainer/FolderLaunch").show()
	$Advance.hide() 

func _on_advance_pressed():
	current_line += 1  
	update_dialogue()

func end_scene():
	var new_scene = load("res://Doctor/DoctorEndingGood.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free()  

	#get_tree().quit()
