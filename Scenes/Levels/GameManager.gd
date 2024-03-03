extends Node3D
class_name GameManager

@export var level_speed = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	TransitionSignals.LevelCleared.connect(ToMainMenuLevelCleared)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ToMainMenuLevelCleared():
	TransitionSignals.FadeToBlack.emit()
	await TransitionSignals.FadeToBlackFinished
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenuManager.tscn")
