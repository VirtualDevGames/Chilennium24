extends Control
class_name MainMenuManager

@export var menu_animations : AnimationPlayer
@onready var transition_fade = $FadeToBlack

# Called when the node enters the scene tree for the first time.
func _ready():
	#transition_fade.Transition()
	print("AAAAAA")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
