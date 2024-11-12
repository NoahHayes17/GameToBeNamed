extends "res://Desktop/App.gd"

@onready var folder = get_node("Folder")
@onready var person = get_node("Person")


func _on_worker_pressed():
	folder.hide()
	person.get_child(0).queue_free()
	var new_scene = load("res://Worker/WorkerFile.tscn").instantiate()
	person.add_child(new_scene)
	person.show()


func _on_white_hair_pressed():
	folder.hide()
	person.get_child(0).queue_free()
	var new_scene = load("res://WhiteHair/WhiteHairFile.tscn").instantiate()
	person.add_child(new_scene)
	person.show()



func _on_bandage_pressed():
	folder.hide()
	person.get_child(0).queue_free()
	var new_scene = load("res://Bandaged/BandagedFile.tscn").instantiate()
	person.add_child(new_scene)
	person.show()

func _on_girl_pressed():
	folder.hide()
	person.get_child(0).queue_free()
	var new_scene = load("res://Girl/GirlFile.tscn").instantiate()
	person.add_child(new_scene)
	person.show()
