extends Control

@onready var desktop = get_node("Background")
@onready var interview = get_node("Background/Interview")
@onready var messager = get_node("Background/Messager")
@onready var folder = get_node("Background/Folder")
var day = 1
var popup_panel: Panel
var log_off_button: Button
var c_button: Button
var message_label: Label
var worker = false
var white_hair = false
var girl = false
var bandage = false

# Called when the node enters the scene tree for the first time.
func _ready():	
	# Create the popup panel for the "Log Off" confirmation button
	popup_panel = Panel.new()
	popup_panel.visible = false  # Initially hidden
	add_child(popup_panel)

	# Create the label to display "Are you sure?"
	message_label = Label.new()
	message_label.text = "Are you sure you want to log off for the day?"
	#message_label.rect_position = Vector2(25, 20)  # Position of the label
	popup_panel.add_child(message_label)
	
	# Position the popup panel (adjust as needed relative to your start button)
	popup_panel.position = Vector2(700, 500)  # Example position

	# Add the "Log Off" button inside the popup panel
	c_button = Button.new()
	c_button.text = "Cancel"
	c_button.position += Vector2(100, 20)
	popup_panel.add_child(c_button)
	log_off_button = Button.new()
	log_off_button.text = "Yes"
	log_off_button.position += Vector2(0, 20)
	popup_panel.add_child(log_off_button)

	# Connect the "Log Off" button to an action
	c_button.pressed.connect(_on_start_pressed)
	log_off_button.pressed.connect(_on_log_off_button_pressed)

func _on_start_pressed():
	popup_panel.visible = !popup_panel.visible

# Function to handle the log off action
func _on_log_off_button_pressed():
	print("Logging off...")
	popup_panel.visible = false  # Optionally hide the popup again after logging off
	day += 1
	if day == 2:
		messager.get_node("Control").get_child(0).queue_free()
		var new_scene = load("res://Doctor/DoctorFirstSymptoms.tscn").instantiate()
		messager.get_node("Control").add_child(new_scene)
		interview.get_node("Control").get_child(0).queue_free()
		new_scene = load("res://WhiteHair/WhiteHair.tscn").instantiate()
		interview.get_node("Control").add_child(new_scene)
	if day == 3:
		messager.get_node("Control").get_child(0).queue_free()
		var new_scene = load("res://Doctor/DoctorSecondSymptomsAndFolder.tscn").instantiate()
		messager.get_node("Control").add_child(new_scene)
		interview.get_node("Control").get_child(0).queue_free()
		new_scene = load("res://Bandaged/Bandaged.tscn").instantiate()
		interview.get_node("Control").add_child(new_scene)
	if day == 4:
		if worker and not white_hair and not girl and not bandage:
			var new_scene = load("res://Doctor/DoctorEndingGood.tscn").instantiate()
			get_tree().root.add_child(new_scene)
			queue_free()  # Optionally, remove the current scene if needed
		else:
			var new_scene = load("res://Doctor/DoctorEndingBad.tscn").instantiate()
			get_tree().root.add_child(new_scene)
			queue_free()  # Optionally, remove the current scene if needed

func _on_interview_launch_pressed():
	interview.show()


func _on_messager_launch_pressed():
	messager.show()


func _on_folder_launch_pressed():
	folder.show()
