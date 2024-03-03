extends RigidBody3D
class_name BaseEnemy

@export var max_hp : int
var hp = 0
@export var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Damage(attack : int):
	print("hello")
	hp -= attack
	if hp <= 0:
		queue_free()

func TestFunc():
	pass

func _physics_process(delta):
	pass
