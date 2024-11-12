extends "res://Girl/Girl.gd"

@onready var folder = get_parent().get_parent()

func _ready():
	$InspectEye/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$InspectVein/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Reject/RichTextLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Reject button interaction response
func _on_reject_pressed():
	print("Player rejected")
	folder.get_node("Folder").get_node("Girl").hide()
	end_scene()

# Function to end the scene
func end_scene():
	folder.get_node("Folder").show()
	get_parent().hide()

func _on_back_pressed():
	end_scene()
