extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var banana_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$banana_counter.text = str("Bananas: ", banana_count)
#	pass # Replace with function body.

func update_banana_counter():
	banana_count += 1
	$banana_counter.text = str("Bananas: ", banana_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
