extends Control
class_name MainMenuManager

@export var menu_animations : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	print(menu_animations.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
