extends Node2D

@export var display_time: float = 4.0

# NPC and player dialogue arrays
var npc_dialogue_lines: Array = [
	"All clear, huh? You flagged every single one of them.",
	"Interesting call. Guess you thought it was better to play it safe, right? To send everyone off to that… facility. Well, I suppose that’s one way to avoid an outbreak.",
	"Between you and me… I’d be careful about who you trust around here. That ‘special facility’—it isn’t exactly a hospital. I can’t say where they’re taking those people, but I doubt they’re getting much treatment.",
	"Sometimes, the government decides that people are problems to be… solved, not healed. So… I hope you’re comfortable with your choice, Doctor. Those people are gone now. And maybe… maybe we’ll never know if they were truly sick."
]

var player_responses: Array = [
	"[wave]I thought it was the safest option. Better than risking an outbreak, right?[/wave]",
	"[wave]What do you mean?[/wave]",
	"[wave]You’re saying… they’re not coming back, are they?[/wave]",
	"[wave]...[/wave]"
]

# Track the current dialogue line
var current_line: int = 0

func _ready():
	$Advance/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectEye/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectVein/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Accept/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Reject/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
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
	var new_scene = load("res://Doctor/Doctor1.tscn").instantiate()
	get_tree().root.add_child(new_scene)
	queue_free()  # Optionally, remove the current scene if needed

	#get_tree().quit()
