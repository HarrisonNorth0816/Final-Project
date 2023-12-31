extends Node2D

var EFFECT = preload("res://Enviroment/poof.tscn")
@onready var Player = load("res://Player/Player.tscn")
var starting_position = Vector2(100,500)
var levelInverted = false
var checkLevelState = false

func _physics_process(delta):
	spawn(starting_position)
	if !checkLevelState:
		var invertCheck = get_node("/root/Level").get("levelInverted")
		if invertCheck == true:
			var topLayer = get_node_or_null("TopLayer")
			if topLayer != null:
				topLayer.queue_free()
		checkLevelState = true

var isTopVisible = get_node_or_null("TopLayer")



func _on_area_2d_body_entered(body):
	if body.is_in_group("Collect"):
		levelInverted = true
		hide_tileset()
		hide_sprite()
	elif null:
		%Layer2.set_process(false)
	
func hide_tileset():
#	var effect = EFFECT.instantiate()
#	add_child(effect)
#	effect.global_position = Vector2(500,500)
	$Layer2.visible = true
	%Layer1.queue_free()
	%Item.queue_free()
	$Area2D.queue_free()

func hide_sprite():
	print('1')
	var sprite = get_node("Player/TopLayer")
	print('2')
	sprite.queue_free()
	print('3')
	
func spawn(pos):
	if not has_node("Player"):
		var player = Player.instantiate()
		player.position = starting_position
		add_child(player)
