extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		if name == "exit6":
			var _target = get_tree().change_scene_to_file("res://Levels/level7.tscn")
