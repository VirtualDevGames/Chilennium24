extends Path3D
class_name HoverPath

@export var enemy_type : EnemyType
@export var path_speed : float = 1.0
@export_range (0, 1) var path_start_position_percentage : float

@onready var pathFollowNode : PathFollow3D = $PathFollow3D

@onready var eagle = preload("res://Scenes/Characters/Enemy/BaseEnemy.tscn")

enum EnemyType {
	Eagle,
	Tiger,
}

func _ready():
	pathFollowNode.progress_ratio = path_start_position_percentage
	var object
	match enemy_type:
		EnemyType.Eagle:
			object = eagle.instantiate()
	if !object:
		return
	pathFollowNode.add_child(object)

func _physics_process(delta) :
	pathFollowNode.progress += path_speed * delta
