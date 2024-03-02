extends Node2D
class_name HealthComponent

var hp = 1
var max_hp = hp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SetHealth(_hp : int):
	hp = _hp
	max_hp = hp

func Damage(damage : int):
	hp -= damage
	if hp <= 0:
		print(name + " is dead")
