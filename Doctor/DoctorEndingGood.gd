extends Node2D

@export var display_time: float = 4.0

var npc_dialogue_lines: Array = [
	"Well… I didn’t think I’d say this, but you did it. You managed to sort them all correctly. We’ve received confirmation that each patient you flagged… well, they were carrying the markers.",
	"Yes. Thanks to you, we’ve dodged a disaster.",
	"I can’t say I’m happy about where they’ve ended up, but I suppose it was necessary. And thanks to you, we’ve contained whatever this… thing is. We might’ve dodged a disaster here. If there’s anyone to thank, it’s you.",
	"Go home. Take a rest. You've done your part, Doctor.",
]

var player_responses: Array = [
	"[wave]So… we contained it, right? No one else is at risk?[/wave]",
	"[wave]I still wonder what really happened to them, though.[/wave]",
	"[wave]...[/wave]",
	"Thanks Doc"
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

func _on_advance_pressed():
	current_line += 1 
	update_dialogue()

# Function to end the scene
func end_scene():
	var new_scene = load("res://Doctor/DoctorEndingBad.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free() 

	#get_tree().quit()
