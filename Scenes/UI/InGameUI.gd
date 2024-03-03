extends CanvasLayer

@export var hp_icons : Array[TextureRect]
@export var player : Player
@onready var banana_counter_label = $"Banana Counter Label"
var banana_counter = 0

func _ready():
	player.connect("TookDamage", UpdateMonkeys)
	player.connect("GrabbedBanana", UpdateBananas)

# Called when the node enters the scene tree for the first time.
func UpdateMonkeys():
	for icon in hp_icons:
		icon.visible = false
	for hp in player.hp:
		hp_icons[hp - 1].visible = true

func UpdateBananas(value : int):
	print("WHY ARE YOU AS A MAN 5")
	banana_counter += value 
	banana_counter_label.text = str(banana_counter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
