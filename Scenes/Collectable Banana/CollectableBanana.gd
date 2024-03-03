extends Node3D
class_name CollectableBanana

@export var type : BananaType
@export var images:Array[Resource]

var value = 0
var small_value = 1
var large_value = 5

enum BananaType {
	Small,
	Large,
}

func _ready():
	match type:
		BananaType.Small:
			value = small_value
		BananaType.Large:
			value = large_value
