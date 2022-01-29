extends Node

var taraytys = preload("res://audio/taraytys.ogg")

export var nearTime = 2
export var farTime = 4

var nearCamTimer = Timer.new()
var farCamTimer = Timer.new()

signal near_cam_on
signal far_cam_on


func _ready():
	add_child(nearCamTimer)
	add_child(farCamTimer)
	nearCamTimer.set_wait_time(nearTime)
	farCamTimer.set_wait_time(farTime)
	
	nearCamTimer.connect("timeout", self, "_on_near_timer_timeout")
	farCamTimer.connect("timeout", self, "_on_far_timer_timeout")
	
	nearCamTimer.start()
	

func _on_near_timer_timeout():
	#audio
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = taraytys
		$AudioStreamPlayer.play()
	
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("whack")
	nearCamTimer.stop()
	farCamTimer.start()
	emit_signal("far_cam_on")

func _on_far_timer_timeout():
	#audio
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = taraytys
		$AudioStreamPlayer.play()
	
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("whack")
	farCamTimer.stop()
	nearCamTimer.start()
	emit_signal("near_cam_on")
