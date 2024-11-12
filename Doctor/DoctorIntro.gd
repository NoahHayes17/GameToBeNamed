extends Node2D

@export var display_time: float = 4.0

# NPC and player dialogue arrays
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


# Track the current dialogue line
var current_line: int = 0

func _ready():
	$Advance/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectEye/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectVein/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Accept/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Reject/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$BackgroundCoverUp/Panel/Close/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$BackgroundCoverUp/Panel/Time/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	update_dialogue()

# Function to update the dialogue box based on the current line
func update_dialogue():
	if current_line < npc_dialogue_lines.size():
		show_text($NPCText/RichTextLabel, npc_dialogue_lines[current_line])  # Show NPC line gradually
		$Advance/RichTextLabel.text = player_responses[current_line]  # Show player's response as button text
	else:
		end_dialogue()  # End dialogue if no more NPC lines

# Coroutine to reveal the text character by character
func show_text(label: RichTextLabel, text: String) -> void:  # Accept Control as the argument
	label.clear()  # Start with an empty label
	for character in text:  # Renamed char to character
		label.append_text(character)
		await get_tree().create_timer(0.05).timeout  # Wait for 0.05 seconds for speed adjustment

# Advances to the next dialogue line when the player response is pressed

# Ends the dialogue and shows choice buttons
func end_dialogue():
	$Advance.hide()  # Hide the advance button

# Advances to the next dialogue line when the player response is pressed
func _on_advance_pressed():
	print("Button pressed! Current line:", current_line)  # Debugging line
	current_line += 1  # Increment to the next dialogue line
	update_dialogue()

# Function to end the scene
func end_scene():
	var new_scene = load("res://Doctor/DoctorFirstSymptoms.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free()  # Optionally, remove the current scene if needed

	#get_tree().quit()
