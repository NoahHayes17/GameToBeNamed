extends Node2D

var display_time: float = 4.0
var pop_up_scene_eye = load("res://WhiteHair/WhiteHairPopUpEye.tscn")
var pop_up_scene_vein = load("res://WhiteHair/WhiteHairPopUpVein.tscn")

# NPC and player dialogue arrays
var npc_dialogue_lines: Array = [
	"I’ve been here for a while, doctor. Am I... am I sick?",
	"No, I’ve  ur had it since I was a kid. A... family thing.",
]

var player_responses: Array = [
	"[wave]I’m here to see if there’s anything we need to worry about. This… white hair—is it recent?[/wave]",
	"[wave]Interesting...[/wave]",
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
func _on_inspect_white_hair_eye_pressed():
	print("Inspect button pressed")
	var new_pop_up_eye = pop_up_scene_eye.instantiate()
	new_pop_up_eye.display_time = display_time
	add_child(new_pop_up_eye)
	new_pop_up_eye.show()

func _on_inspect_white_hair_vein_pressed():
	print("Inspect button pressed")
	var new_pop_up_vein = pop_up_scene_vein.instantiate()
	new_pop_up_vein.display_time = display_time
	add_child(new_pop_up_vein)
	new_pop_up_vein.show()

# Accept button interaction response
func _on_accept_pressed():
	print("Player accepted")
	$NPCText/RichTextLabel.text = npc_accept_response  # NPC's response to acceptance
	$Advance/RichTextLabel.hide()  # Hide players text after responding
	end_scene()

# Reject button interaction response
func _on_reject_pressed():
	print("Player rejected")
	$NPCText/RichTextLabel.text = npc_reject_response  # NPC's response to rejection
	$Advance/RichTextLabel.hide()  # Hide players text after responding
	end_scene()

# Function to end the scene
func end_scene():
	get_parent().get_parent().queue_free() # close window
	

	#get_tree().quit()
