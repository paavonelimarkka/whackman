extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var timer = Timer.new()

func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process

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
