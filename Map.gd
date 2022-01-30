extends Node2D

export (int) var banana_count = 4

var rng = RandomNumberGenerator.new()
var timer = Timer.new()
var Trap = preload ("res://game objects/trap.tscn")
var Banana = preload("res://game objects/banana.tscn")

onready var path_map = get_node("Navigation2D/TileMap - Path")

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = 0
	while x < banana_count:
		spawn_banana()
		x += 1

func dispenseTrap(position):
	var t = Trap.instance()
	t.position = position
	add_child(t)

func spawn_banana():
	var x = randi() % 30
	var y = randi() % 17
	if (path_map.get_cell(x,y) >= 0):
		var banana = Banana.instance()
		banana.position = path_map.map_to_world(Vector2(x, y))
		add_child(banana)
	else:
		spawn_banana()
