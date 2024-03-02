extends CanvasLayer

@export var hp_icons : Array[TextureRect]
@export var player : Player

func _ready():
	player.connect("TookDamage", UpdateMonkeys)

# Called when the node enters the scene tree for the first time.
func UpdateMonkeys():
	for icon in hp_icons:
		icon.visible = false
	for hp in player.hp:
		hp_icons[hp - 1].visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
