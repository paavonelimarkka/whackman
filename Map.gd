extends Node2D

export (int) var banana_count = 4

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var timer = Timer.new()
var Trap = preload ("res://game objects/trap.tscn")
var Banana = preload("res://game objects/banana.tscn")

onready var path_map = get_node("Navigation2D/TileMap - Path")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.wait_time = rng.randf_range(1.0, 2.0)
	add_child(timer) #to process
	print(timer.wait_time)
	timer.start()
	var x = 0
	while x < banana_count:
		spawn_banana()
		x += 1

func _on_timer_timeout():
	var t = Trap.instance()
	t.position = $Enemy.position
	t.connect("body_entered", $Player, "_on_body_entered")
	add_child(t)
	timer.wait_time = rng.randf_range(1.0, 2.0)
	print(timer.wait_time)	
	timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_input():
	if Input.is_action_pressed("camera_swap"):
		print("MOI")
		spawn_banana()

func spawn_banana():
	var x = randi() % 30
	var y = randi() % 17
	if (path_map.get_cell(x,y) >= 0):
		var banana = Banana.instance()
		banana.position = path_map.map_to_world(Vector2(x, y))
		add_child(banana)
	else:
		spawn_banana()
