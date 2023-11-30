extends CharacterBody2D

const acceleration = 20.0
const deceleration = 50.0
const maxWalkSpd = 300.0
const JUMP_VELOCITY = -800.0
var lastDir = 1
var movementDir
var isJumping = false

# Dash Variables
const maxDashSpd = 1000.0
const minDashSpd = 400.0
var isDashing = false
var hasDashed = false
var isDashCooldown = false
var dashAvailable = true
var freezeVelocityY = false

# Wall Jump Variables
const maxFallSpeed = 100.0
var canWallJump = false
var wallJumpDir = 1
var slidingOnWall = false
var wallCollisionL
var wallCollisionR

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	if $WallDetection/topLeft.is_colliding || $WallDetection/middleLeft.is_colliding || $WallDetection/bottomLeft.is_colliding:
		wallCollisionL = $WallDetection/topLeft.get_collider()
		if wallCollisionL != null:
			wallJumpDir = 1
		wallCollisionL = $WallDetection/middleLeft.get_collider()
		if wallCollisionL != null:
			wallJumpDir = 1
		wallCollisionL = $WallDetection/bottomLeft.get_collider()
		if wallCollisionL != null:
			wallJumpDir = 1
	
	if $WallDetection/topRight.is_colliding || $WallDetection/middleRight.is_colliding || $WallDetection/bottomRight.is_colliding:
		wallCollisionR = $WallDetection/topRight.get_collider()
		if wallCollisionR != null:
			wallJumpDir = -1
		wallCollisionR = $WallDetection/middleRight.get_collider()
		if wallCollisionR != null:
			wallJumpDir = -1
		wallCollisionR = $WallDetection/bottomRight.get_collider()
		if wallCollisionR != null:
			wallJumpDir = -1
	
	if not is_on_floor() && (wallCollisionL != null || wallCollisionR != null):
		canWallJump = true
	else:
		canWallJump = false
	
	if (wallCollisionL != null || wallCollisionR != null) && movementDir != 0:
		slidingOnWall = true
	else:
		slidingOnWall = false
	
	if is_on_floor():
		isJumping = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if slidingOnWall == true && velocity.y >= maxFallSpeed:
			velocity.y = maxFallSpeed

	if wallCollisionL != null || wallCollisionR != null || is_on_floor():
		if !isDashCooldown:
			hasDashed = false
			dashAvailable = true

	if Input.is_action_just_pressed("dash") && dashAvailable:
		dash_movement()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("jump") && canWallJump && !is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = wallJumpDir * maxWalkSpd
	
	if freezeVelocityY:
		velocity.y = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	movementDir = direction
	if direction:
		lastDir = direction
		velocity.x += direction * acceleration
		if abs(velocity.x) > minDashSpd:
			if velocity.x < 0:
				velocity.x += deceleration
			if velocity.x > 0:
				velocity.x -= deceleration
		elif abs(velocity.x) >= maxWalkSpd && abs(velocity.x) <= minDashSpd:
			if velocity.x < 0:
				velocity.x += acceleration
			elif velocity.x > 0:
				velocity.x -= acceleration
	else:
		if abs(velocity.x) > minDashSpd:
			velocity.x = move_toward(velocity.x, 0, deceleration)
		elif abs(velocity.x) <= minDashSpd:
			velocity.x = move_toward(velocity.x, 0, acceleration)
	apply_animation()
	move_and_slide()

func apply_animation():
	
	var animation = get_node_or_null("TopLayer")
	
	if !is_on_floor():
		if !slidingOnWall && !isJumping:
			$Inverted.animation = "JumpI"
			if animation != null:
				$TopLayer.animation = "Jump"
			isJumping = true
	elif is_on_floor() && !isJumping:
		if velocity.x != 0:
			$Inverted.play("RunI")
			if animation != null:
				$TopLayer.play("Run")
		else:
			$Inverted.play("IdleI")
			if animation != null:
				$TopLayer.play("Idle")
	
	if lastDir < 0:
		$Inverted.flip_h = true
		if animation != null:
			$TopLayer.flip_h = true
	else:
		$Inverted.flip_h = false
		if animation != null:
			$TopLayer.flip_h = false

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

