extends CollisionShape2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Collect"):
		hide_tileset()
		hide_sprite()

func hide_tileset():
	if get_tree().root.get_child(0).has_node("%Layer1"):
		%Layer1.queue_free()
		%Area2D.queue_free()
		print("Hi!")

func hide_sprite():
	print("test 1")
	if get_tree().root.get_child(0).has_node("/root/Player/%TopLayer"):
		%TopLayer.queue_free()
		print('test2')
