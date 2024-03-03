extends RigidBody3D
class_name BaseProjectile

const speed = 30
@export var attack = 1

@onready var sfx_player = $"Splat SFX"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass#get_parent().get_collision


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(speed, 0, 0) * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is BaseEnemy:
		var enemy = area.get_parent() as BaseEnemy
		enemy.TestFunc()
		enemy.Damage(attack)
		sfx_player.play()
