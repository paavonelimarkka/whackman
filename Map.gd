extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var timer = Timer.new()
var Trap = preload ("res://game objects/trap.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var path = $Navigation2D.get_simple_path($Enemy.position, $Player.position)
	$Enemy.path = path
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.wait_time = rng.randf_range(1.0, 2.0)
	add_child(timer) #to process
	print(timer.wait_time)
	timer.start()

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

