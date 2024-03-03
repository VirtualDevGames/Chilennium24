extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var level_speed = 5.0
var acceleration = 1
var deceleration = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var banana_projectile = preload("res://Scenes/Projectiles/BananaProjectile.tscn")
var current_projectile = banana_projectile

@onready var shoot_location = $"Shoot Location"
@onready var invuln_timer = $"Invulnerablility Timer"
@onready var can_move_timer = $"Can Move Timer"
@onready var shooting_timer = $"Shooting Timer"
@onready var animation_player = $AnimationPlayer

@onready var shoot_sfx = $"Shoot SFX"

var can_shoot = true
var can_move = true
var normal_shooting_timer_legth = 0.5

@export var game_manager : GameManager
@export var hp = 5
@onready var max_hp = hp

signal GrabbedBanana
signal TookDamage
var damaged_vector : Vector2
var base_knockback_force = 500
var knockback_force = base_knockback_force
var knockback_decrease = -25

@onready var floaty_timer = $"Floaty Timer"
var floaty_vector : Vector2
var base_floaty_force = 500
var floaty_force = base_floaty_force
var floaty_decrease = -25
var lerp_after_movement = false

func _ready():
	if game_manager:
		level_speed = game_manager.level_speed
	#animation_player.play("Flying")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if !can_move:
		velocity.x = (damaged_vector.x * delta) * knockback_force
		velocity.y = (damaged_vector.y * delta) * knockback_force
		knockback_force += knockback_decrease
		move_and_slide()
		return
	
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if direction.x < 0:
			rotation_degrees.z = 10
		elif direction.x > 0:
			rotation_degrees.z = -10
		
		if direction.x < 0:
			velocity.x = direction.x * SPEED * 1.2
			#velocity.x = min(velocity.x + acceleration, SPEED)
		else:
			velocity.x = direction.x * SPEED
			#velocity.x = max(velocity.x + acceleration, SPEED)
		if(direction.z > .5) || (direction.z < .5):
			velocity.y = -direction.z * SPEED
		
		floaty_vector = Vector2(velocity.x * delta, velocity.y * delta)
		## Move player along auto-scroll
		velocity.x += level_speed
		floaty_force = base_floaty_force
		lerp_after_movement = true
	else:
		rotation_degrees.z = 0
		#velocity.x = (direction.x * level_speed)
		#velocity.y = -move_toward(velocity.z, 0, SPEED)
		## Move player along auto scroll with float
		
		#velocity.x = (-floaty_vector.x * delta) * (floaty_force * delta)
		#velocity.y = (-floaty_vector.y * delta) * (floaty_force * delta)
		
		if floaty_force + floaty_decrease > 1:
			floaty_force += floaty_decrease
		if floaty_force <= 1:
			floaty_force = 1
		
		var lerp_force = .05
		#print(lerp(velocity.x, level_speed, lerp_force))
		if (velocity.x > level_speed + .005) || (velocity.x < level_speed + .005):# && lerp_after_movement:
			#print("lerping")
			velocity.x = lerp(velocity.x, level_speed, lerp_force)# velocity.x += level_speed
		else:
			lerp_after_movement = false
			#velocity.x = (direction.x * level_speed)
			velocity.x = level_speed# * delta
		
		if (velocity.y > 0) || (velocity.y < 0):
			velocity.y = lerp(velocity.y, 0.05, lerp_force)
	
	if Input.is_action_pressed("Shoot"):# && can_shoot:
		if can_shoot:
			can_shoot = false
			shooting_timer.start()
			var new_projectile = (banana_projectile.instantiate()) as BaseProjectile
			get_parent().add_child(new_projectile)
			new_projectile.global_position = shoot_location.global_position
			shoot_sfx.play()
	
	#if Input.is_action_just_pressed("Take Damage"):# && can_shoot:
	#	TakeDamage(1)
		
	move_and_slide()

func TakeDamage(damage : int):
	if invuln_timer.is_stopped():
		invuln_timer.start()
		hp -= damage
		TookDamage.emit()
		# Play animation of monkeys coming down here
		if hp >= 0:
			pass #player is dead

func _on_shooting_timer_timeout():
	print("ba ba")
	can_shoot = true

func _on_invulnerablility_timer_timeout():
	pass # Replace with function body.

func _on_hitbox_area_entered(area):
	if area.get_parent() is CollectableBanana:
		var banana = area.get_parent() as CollectableBanana
		GrabbedBanana.emit(banana.value)
		return
	if area.get_parent() is BaseEnemy:
		var enemy = area.get_parent() as BaseEnemy
		TakeDamage(enemy.damage)
	elif area.get_parent() is BaseIsland:
		TakeDamage(1)
	damaged_vector = Vector2(global_position.x, global_position.y) - Vector2(area.global_position.x, area.global_position.y)
	can_move = false
	can_move_timer.start()

func _on_can_move_timer_timeout():
	knockback_force = base_knockback_force
	can_move = true
