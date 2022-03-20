extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentKey = null
var pitchUp = rand_range(0.0, 0.2)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed = event as InputEventKey
		var key = PoolByteArray([typed.unicode]).get_string_from_utf8()
		currentKey = key
	if not event.is_pressed():
		currentKey = null
	
	if Input.is_action_pressed("alphabet"):
		# jammy hacky way of randomizing pitch
		$AudioStreamPlayer.pitch_scale -= pitchUp
		#var typed = event as InputEventKey
		#var key = PoolByteArray([typed.unicode]).get_string_from_utf8()
		#currentKey = key
		pitchUp = rand_range(0.0, 0.2)
		$AudioStreamPlayer.pitch_scale += pitchUp
		$AudioStreamPlayer.play()
	#elif Input.is_action_just_released("alphabet"):
	#	currentKey = null

