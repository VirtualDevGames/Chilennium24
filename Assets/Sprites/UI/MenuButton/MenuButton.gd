extends Node
class_name MainMenuButton

enum Direction {
	Up,
	Down,
	Left,
	Right,
	Quit,
	LevelsToMain,
	CreditsToMain,
	OptionsToMain,
}

var menu_animations : AnimationPlayer
var menu : MainMenuManager
@export var move_direction : Direction
@export var button_text : String
@export var font_size : int

func _ready():
	menu = get_tree().root.get_node("MainMenu") as MainMenuManager
	menu_animations = menu.menu_animations

func _on_button_up():
	#menu.transitioning = true
	#sfx_menu_select.play()
	match move_direction:
		Direction.Up:
			pass
		Direction.Down:
			menu_animations.play("Options")
		Direction.Left:
			menu_animations.play("MainToCredits")
		Direction.Right:
			menu_animations.play("MainToLevels")
		Direction.Quit:
			get_tree().quit()
		Direction.LevelsToMain:
			menu_animations.play("LevelsToMain")
		Direction.CreditsToMain:
			menu_animations.play("CreditsToMain")	
		Direction.OptionsToMain:
			menu_animations.play("OptionsToMain")
