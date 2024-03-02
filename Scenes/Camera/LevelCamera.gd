extends Camera3D

@export var player : Player
@export var const_speed = 5

var smooth_speed = 5
var offset = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = player.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass#global_position.x = player.global_position.x
	#global_position.x = lerp(Vector2(global_position.x, global_position.y), Vector2(player.global_position.x, player.global_position.y), smooth_speed * delta)
