extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var muymuy = preload("res://audio/muymuy.ogg")
var banana_count = 0
onready var restart_button = get_node("restart_button")

# Called when the node enters the scene tree for the first time.
func _ready():
	$banana_counter.text = str("Bananas: ", banana_count)
	restart_button.connect("pressed", self, "_restart_button_pressed")
#	pass # Replace with function body.

func update_banana_counter():
	banana_count += 1
	$banana_counter.text = str("Bananas: ", banana_count)
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = muymuy
		$AudioStreamPlayer.play()
		
func show_restart():
	restart_button.show()
	
func _restart_button_pressed():
	get_tree().change_scene("res://Map.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
