extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	print("OLEN BANAANI")
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if (body.get_name() == 'Player'):
		print('banana_picked')
		emit_signal('banana_picked')
		queue_free()
