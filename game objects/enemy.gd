extends KinematicBody2D

var speed = 50
var path : = PoolVector2Array()
var chase = false
onready var navigationNode = get_node('../Navigation2D')
onready var player = get_node('../Player')
onready var path_map = get_node("../Navigation2D/TileMap - Path")
onready var map = get_node("/root/Map")
var randomPathTimer = 500
var rng = RandomNumberGenerator.new()
var jahti_timer = 0
var trapDispenserTime

func _ready():
	rng.randomize()
	get_random_position_on_path()
	trapDispenserTime = rng.randf_range(250.0, 500.0)

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	
	if trapDispenserTime <= 0:
		map.dispenseTrap(self.position)
		trapDispenserTime = rng.randf_range(250.0, 500.0)
	
	trapDispenserTime -= 1
	
	if chase:
		jahti_timer -= 1
	
	if position.distance_to(player.position) < 200 && jahti_timer <= 0:
		jahti_timer = 25
		chase = true
		path = navigationNode.get_simple_path(self.position, player.position)
		self.path = path
	
	if position.distance_to(player.position) > 300 && chase:
		chase = false
		get_random_position_on_path()
	
	randomPathTimer -= 1
	if randomPathTimer < 0 || path.size() <= 0:
		get_random_position_on_path()
	
	# Move the player along the path until he has run out of movement or the path ends.
	if distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point

func get_random_position_on_path():
	var x = randi() % 30
	var y = randi() % 17
	if (path_map.get_cell(x,y) >= 0):
		path = navigationNode.get_simple_path(self.position, path_map.map_to_world(Vector2(x, y)) + Vector2(6, 6))
		self.path = path
		randomPathTimer = 500
	else:
		get_random_position_on_path()
