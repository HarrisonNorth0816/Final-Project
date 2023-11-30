extends Node2D

var EFFECT = preload("res://Enviroment/poof.tscn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("Collect"):
		hide_tileset()
		hide_sprite()

func hide_tileset():
#	var effect = EFFECT.instantiate()
#	add_child(effect)
#	effect.global_position = Vector2(500,500)
	%Layer1.queue_free()
	%Item.queue_free()
	%Area2D.queue_free()

func hide_sprite():
	print('1')
	var sprite = get_node("Player/TopLayer")
	print('2')
	sprite.queue_free()
	print('3')
