extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var timer = Timer.new()

func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process

onready var light = get_node("Light2D")
onready var canvas = get_node("CanvasModulate")
onready var playerCamera = get_node('PlayerCamera')
onready var mainCamera = get_node('../MainCamera')

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
	elif Input.is_action_pressed("down"):
		velocity.y += 1
	elif Input.is_action_pressed("up"):
		velocity.y -= 1
	# POISTAKAA TÄÄ KU TÄRÄYTETÄÄN!
	elif Input.is_action_just_pressed("camera_swap"):
		swapCamera()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


	#for index in get_slide_count():
	#	var collision = get_slide_collision(index)
	#	if collision.collider.is_in_group("traps"):
	#		slow_down()
	#		print(collision.collider.name)
			
func slow_down():
	timer.start() #to start
	speed = 100

func _on_timer_timeout():
	speed = 200

func swapCamera():
	if playerCamera.is_current():
		mainCamera.make_current()
		light.texture_scale = 2
		canvas.color = Color(1,1,1,1)
		light.color = Color(0,0,0,1)
	else:
		playerCamera.make_current()
		light.texture_scale = 1.0
		canvas.color = Color(0,0,0,1)
		light.color = Color(1,1,1,1)
