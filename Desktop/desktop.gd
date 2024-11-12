extends Control

@onready var desktop = get_node("Background")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_interview_launch_pressed():
	var scene = load("res://Desktop/interview.tscn")  # Path to your scene
	var instance = scene.instantiate()  # Create an instance of the scene

    # Add the instance to the current scene (parent it to the root or another node)
	desktop.add_child(instance)
