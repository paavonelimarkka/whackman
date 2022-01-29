extends Area2D

onready var player = get_node('/root/Map/Player')

func _ready():
	pass

func _on_Area2D_body_entered(body):
	print(body)
	if (body.get_name() == 'Player'):
		player.slow_down()
		queue_free()
