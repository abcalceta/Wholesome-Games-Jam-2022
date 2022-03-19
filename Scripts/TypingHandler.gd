extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentKey = null

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


