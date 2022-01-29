extends KinematicBody2D

var speed = 50
var path : = PoolVector2Array()
onready var navigationNode = get_node('../Navigation2D')
onready var player = get_node('../Player')
onready var path_map = get_node("../Navigation2D/TileMap - Path")
var randomPathTimer = 500

func _ready():
	get_random_position_on_path()

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	
	randomPathTimer -= 1
	print(path.size())
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
		print('Vaihoin suuntaa, t. Hämis')
		path = navigationNode.get_simple_path(self.position, path_map.map_to_world(Vector2(x, y)) + Vector2(6, 6))
		self.path = path
		randomPathTimer = 500
	else:
		get_random_position_on_path()
