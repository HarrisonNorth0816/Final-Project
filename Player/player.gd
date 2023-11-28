extends CharacterBody2D

const acceleration = 20.0
const deceleration = 50.0
const maxWalkSpd = 300.0
const JUMP_VELOCITY = -800.0
var lastDir = 1

# Dash Variables
const maxDashSpd = 1000.0
const minDashSpd = 400.0
var isDashing = false
var hasDashed = false
var isDashCooldown = false
var dashAvailable = true
var freezeVelocityY = false

# Wall Jump Variables
var isOnWall = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if !isDashCooldown && is_on_floor():
		hasDashed = false
		dashAvailable = true

	if Input.is_action_just_pressed("dash") && dashAvailable:
		dash_movement()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	print_debug(velocity.x)
	if direction:
		velocity.x += direction * acceleration
		if direction > 0:
			lastDir = 1
		elif direction < 0:
			lastDir = -1
		if abs(velocity.x) >= minDashSpd:
			if velocity.x < 0:
				velocity.x += deceleration
			elif velocity.x > 0:
				velocity.x -= deceleration
		if abs(velocity.x) >= maxWalkSpd:
			if velocity.x < 0:
				velocity.x += acceleration
			elif velocity.x > 0:
				velocity.x -= acceleration
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
	
	if freezeVelocityY:
		velocity.y = 0

	move_and_slide()

func dash_movement():
	velocity.x = lastDir * maxDashSpd
	hasDashed = true
	isDashCooldown = true
	dashAvailable = false
	freezeVelocityY = true
	$DashCooldown.start()
	$FreezeVelocityY.start()

func _on_dash_cooldown_timeout():
	isDashCooldown = false

func _on_freeze_velocity_y_timeout():
	freezeVelocityY = false
