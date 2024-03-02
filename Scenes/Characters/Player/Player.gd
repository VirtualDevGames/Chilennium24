extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const const_speed = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var banana_projectile = preload("res://Scenes/Projectiles/BananaProjectile.tscn")
var current_projectile = banana_projectile

@onready var shoot_location = $"Shoot Location"

var can_shoot = true
var normal_shooting_timer_legth = 0.5

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = -direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = -move_toward(velocity.z, 0, SPEED)
	
	if (direction.x >= 0):
		velocity.x += const_speed
	else:
		velocity.x += const_speed / 2
	
	if Input.is_action_just_pressed("Shoot"):# && can_shoot:
		can_shoot = false
		var new_projectile = (banana_projectile.instantiate()) as BaseProjectile
		new_projectile.global_position = shoot_location.global_position
		get_parent().add_child(new_projectile)

	move_and_slide()



func _on_shooting_timer_timeout():
	can_shoot = true
