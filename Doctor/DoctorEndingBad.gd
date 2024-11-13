extends Node2D

@export var display_time: float = 4.0

var npc_dialogue_lines: Array = [
	"It’s worse than we imagined… We’ve had reports from multiple facilities… the disease has broken out.",
	"It seems a few of the patients you passed through were… infected. They’re saying this could have been contained if we’d just caught it in time.",
	"I’m sorry. I know this wasn’t easy for you, and maybe this was more than any of us could handle. But people are going to look at us… they’re going to ask what went wrong. And we’ll have to answer, that answer is what we need to focus on now.",
]

var player_responses: Array = [
	"[wave]Wait, what? I thought I checked everything…[/wave]",
	"[wave]I can’t believe this. I was so careful…[/wave]",
	"[wave]...[/wave]",
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

func end_scene():
	var new_scene = load("res://Doctor/DoctorEndingEvil.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free() 

	#get_tree().quit()
