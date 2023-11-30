extends Control

@onready var main = $"../../"

func _on_home_pressed():
	get_tree().change_scene_to_file("res://Levels/Title.tscn")


func _on_quit_pressed():
	get_tree().quit()
