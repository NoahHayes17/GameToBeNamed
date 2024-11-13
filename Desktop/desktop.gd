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
var loading_screen : Control
var worker = false
var white_hair = false
var girl = false
var bandage = false

func _ready():	
	popup_panel = Panel.new()
	popup_panel.visible = false 
	add_child(popup_panel)
	
	var image_texture = preload("res://Desktop/Sprite-0003.png")
	var image_sprite = TextureRect.new()
	image_sprite.texture = image_texture
	image_sprite.size = Vector2(500, 150)  
	image_sprite.position = Vector2(-75, -50)  
	popup_panel.add_child(image_sprite)

	message_label = Label.new()
	message_label.text = "Are you sure you want to log off for the day?"
	message_label.modulate = Color(0, 0, 0) 
	#message_label.rect_position = Vector2(25, 20)  # Position of the label
	popup_panel.add_child(message_label)
	
	popup_panel.position = Vector2(700, 500) 

	c_button = Button.new()
	c_button.text = "Cancel"
	c_button.position += Vector2(100, 20)
	popup_panel.add_child(c_button)
	log_off_button = Button.new()
	log_off_button.text = "Yes"
	log_off_button.position += Vector2(0, 20)
	popup_panel.add_child(log_off_button)

	c_button.pressed.connect(_on_start_pressed)
	log_off_button.pressed.connect(_on_log_off_button_pressed)
	
	_create_loading_screen()

func _create_loading_screen():
	# Create a full-screen black Control node
	loading_screen = Control.new()
	loading_screen.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	loading_screen.size_flags_vertical = Control.SIZE_EXPAND_FILL
	loading_screen.anchor_left = 0
	loading_screen.anchor_right = 1
	loading_screen.anchor_top = 0
	loading_screen.anchor_bottom = 1
	loading_screen.visible = false  
	add_child(loading_screen)

	# Set up a black background that fills the screen
	var background = ColorRect.new()
	background.color = Color.BLACK
	background.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	background.size_flags_vertical = Control.SIZE_EXPAND_FILL
	background.anchor_left = 0
	background.anchor_right = 1
	background.anchor_top = 0
	background.anchor_bottom = 1
	loading_screen.add_child(background)

	# Add a loading symbol 
	var loading_symbol = TextureRect.new()
	loading_symbol.texture = preload("res://assets/Misc/_ (14).jpeg")  # Replace with your loading texture
	loading_symbol.size = Vector2(100, 100)  # Adjust size for loading symbol
	loading_symbol.position = Vector2(
		(loading_screen.size.x - loading_symbol.size.x) / 2,
		(loading_screen.size.y - loading_symbol.size.y) / 2
		)
	loading_screen.add_child(loading_symbol)

func _on_start_pressed():
	popup_panel.visible = !popup_panel.visible

func _on_log_off_button_pressed():
	print("Logging off...")
	popup_panel.visible = false 
	loading_screen.visible = true
	await get_tree().create_timer(1.5).timeout 

	loading_screen.visible = false 
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
			messager.get_node("Control").get_child(0).queue_free()
			var new_scene = load("res://Doctor/DoctorEndingGood.tscn").instantiate()
			messager.get_node("Control").add_child(new_scene)
		elif not white_hair and not girl and not bandage:
			messager.get_node("Control").get_child(0).queue_free()
			var new_scene = load("res://Doctor/DoctorEndingEvil.tscn").instantiate()
			messager.get_node("Control").add_child(new_scene)
		else:
			messager.get_node("Control").get_child(0).queue_free()
			var new_scene = load("res://Doctor/DoctorEndingBad.tscn").instantiate()
			messager.get_node("Control").add_child(new_scene)

func _on_interview_launch_pressed():
	interview.show()


func _on_messager_launch_pressed():
	messager.show()


func _on_folder_launch_pressed():
	folder.show()
