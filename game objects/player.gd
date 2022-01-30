extends KinematicBody2D

export (int) var speed = 200
export (int) var shake_amount = 10

var velocity = Vector2()
var timer = Timer.new()
var shakeTimer = 0
var cameraOffsetReset = false
var game_over = false

func _ready():
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer) #to process
	canvas.color = Color(0, 0, 0, 1)
	light.color = Color(1, 1, 1, 1)

onready var playerCamera = get_node('PlayerCamera')
onready var mainCamera = get_node('../MainCamera')
onready var animationPlayer = get_node('AnimationPlayer')
onready var canvas = get_node("CanvasModulate")
onready var light = get_node("Light2D")
onready var apina = get_node('../Apina')
onready var apina_camera = get_node('../Apina/ApinaCamera')
onready var hud = get_node("../HUD")

func get_input():
	velocity = Vector2()
	if game_over:
		pass
	elif Input.is_action_pressed("right"):
		velocity.x += 1
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
	elif Input.is_action_pressed("down"):
		velocity.y += 1
	elif Input.is_action_pressed("up"):
		velocity.y -= 1
	# POISTAKAA TÄÄ KU TÄRÄYTETÄÄN!
	#elif Input.is_action_just_pressed("camera_swap"):
	#	swapCamera()
	velocity = velocity.normalized() * speed

func _process(delta):
	if shakeTimer > 0:
		playerCamera.set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount))
		mainCamera.set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount))
		shakeTimer = shakeTimer - 1
	if shakeTimer == 0 && cameraOffsetReset:
		playerCamera.set_offset(Vector2(0, 0))
		mainCamera.set_offset(Vector2(0, 0))

func _physics_process(delta):
	get_input()
	#velocity = move_and_slide(velocity)

	var collision = move_and_collide(velocity * delta)
	if collision:
		if (collision.collider.is_in_group('enemy')) && !game_over:
			game_over = true
			apina.stop_and_shake()
			animationPlayer.play("fade_to_red")
			light.queue_free()
			hud.show_restart()

	#for index in get_slide_count():
	#	var collision = get_slide_collision(index)
	#	if collision.collider.is_in_group("traps"):
	#		slow_down()
	#		print(collision.collider.name)
			
func slow_down():
	timer.start() #to start
	speed = 50

func _on_timer_timeout():
	speed = 200

func swapCamera():
	shakeTimer = 50
	cameraOffsetReset = true
	if playerCamera.is_current():
		mainCamera.make_current()
		animationPlayer.play('zoom_out_colors')
		light.texture_scale = 2
	else:
		playerCamera.make_current()
		animationPlayer.play('zoom_in_colors')
		light.texture_scale = 1

func _on_Apina_far_cam_on():
	swapCamera()

func _on_Apina_near_cam_on():
	swapCamera()
	
func get_slide_collision(body):
	print(body)
