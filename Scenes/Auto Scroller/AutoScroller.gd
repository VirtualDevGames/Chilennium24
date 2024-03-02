extends Node3D
class_name AutoScroller

var game_manager : GameManager
var level_speed = 0
@export var player : Player
# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		position.x = player.position.x
	if get_parent() is GameManager:
		game_manager = get_parent() as GameManager
		level_speed = game_manager.level_speed
		print(level_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x += level_speed * delta
