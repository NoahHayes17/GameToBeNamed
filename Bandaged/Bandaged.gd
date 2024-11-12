extends Node2D

@export var display_time: float = 4.0
@export var pop_up_scene_bandaged_eye = load("res://Bandaged/BandagedPopUpEye.tscn")
@export var pop_up_scene_bandaged_vein = load("res://Bandaged/BandagedPopUpVein.tscn")

# NPC and player dialogue arrays
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

# NPC responses to acceptance and rejection
var npc_accept_response: String = "I'm glad you accepted! Let's work together!"
var npc_reject_response: String = "Oh, I see... Well, good luck then!"

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
	$Accept.show()  # Show the accept button
	$Reject.show()  # Show the reject button

# Advances to the next dialogue line when the player response is pressed
func _on_advance_pressed():
	print("Button pressed! Current line:", current_line)  # Debugging line
	current_line += 1  # Increment to the next dialogue line
	update_dialogue()

# Shows the popup when inspect button is pressed
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

# Accept button interaction response
func _on_accept_pressed():
	print("Player accepted")
	$NPCText/RichTextLabel.text = npc_accept_response  # NPC's response to acceptance
	$Advance/RichTextLabel.hide()  # Hide players text after responding
	get_node("/root/Desktop/Background/Folder/Folder/Bandage").show()
	get_node("/root/Desktop").bandage = true
	end_scene()

# Reject button interaction response
func _on_reject_pressed():
	print("Player rejected")
	$NPCText/RichTextLabel.text = npc_reject_response  # NPC's response to rejection
	$Advance/RichTextLabel.hide()  # Hide players text after responding
	end_scene()

# Function to end the scene
func end_scene():
	var new_scene = load("res://Desktop/Reminder.tscn").instantiate()
	get_parent().add_child(new_scene)
	queue_free()  # Optionally, remove the current scene if needed

