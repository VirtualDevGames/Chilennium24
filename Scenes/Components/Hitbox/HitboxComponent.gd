extends Node3D
class_name HitboxComponent

@export var attack_damage = 1
@export var health_component : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_parent().get_children():
		if node is HealthComponent:
			health_component = node
		

func Damage(damage : int):
	print("am being damaged")
	health_component.Damage(damage)

func _on_body_entered(body):
	if body.has_method("Damage"):
		body.Damage(attack_damage)
