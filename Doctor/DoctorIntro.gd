extends Node2D

@export var display_time: float = 4.0

var npc_dialogue_lines: Array = [
	"Alright, Doctor. We have a peculiar job on our hands today. You’re here because the government needs fresh eyes, and frankly, they don’t want questions. These patients… they might carry symptoms of a newly detected disease.",
	"Your job is to inspect each one, note any signs, and—if they show symptoms—recommend them for transport to a… specialized facility. But don’t concern yourself with what happens after. Just send anyone with symptoms their way.",
	"Symptoms to watch for? We aren't sure yet, but I'll be back to let you know.",
	"Patients will start coming to see you soon"
]

var player_responses: Array = [
	"[wave]Morning Doctor[/wave]",
	"[wave]mmmmph, yes, something has seemed off lately[/wave]",
	"[wave]Ah, I see[/wave]",
	"[wave]Alright, I'll make sure this outbreak is maintained[/wave]"
]

var current_line: int = 0

func _ready():
	$Advance/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
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
	var new_scene = load("res://Doctor/DoctorFirstSymptoms.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free() 

	#get_tree().quit()
