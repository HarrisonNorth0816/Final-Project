extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Collect"):
		hide_tileset()
		hide_sprite()

func hide_tileset():
	print('tiles1')
	%Layer1.queue_free()
	print('tiles2')
	%Area2D.queue_free()
	print("tiles3")

func hide_sprite():
	print('1')
	var sprite = get_node("Player/TopLayer")
	print('2')
	sprite.queue_free()
	print('3')
