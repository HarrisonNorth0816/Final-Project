extends Node2D
@onready var sprite = $AnimatedSprite2D

var velocity = Vector2.ZERO
var max_run = 150
var run_acceleration = 800
var gravity = 1000
var max_fall = 160


func _process(delta):
	var direction = sign(Input.get_action_strength("right") - Input.get_action_strength("left"))
			
	
	
	
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
	
	if direction != 0:
		sprite.play("Run")
	else:
		sprite.play("Idle")
	
	velocity.x = move_toward(velocity.x, max_run * direction, run_acceleration * delta)
	velocity.y = move_toward(velocity.y, max_fall, gravity * delta)
	global_position.x += (velocity.x * delta)
	global_position.y += (velocity.y * delta)
	
	if global_position.y >= 560:
		global_position.y = 560
	
