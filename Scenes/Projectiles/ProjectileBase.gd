extends RigidBody3D
class_name BaseProjectile

const speed = 30
@export var attack = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass#get_parent().get_collision


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(speed, 0, 0) * delta


func _on_hitbox_component_body_entered(body):
	print(body.name)
	if body.has_method("Damage"):
		body.damage(attack)
