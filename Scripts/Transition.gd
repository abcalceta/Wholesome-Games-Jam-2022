extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextScene = ""
signal completed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func nextScene():
	get_tree().change_scene(nextScene)
	pass
	
func transition(scene):
	nextScene = scene
	$AnimationPlayer.play("Transition")


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("completed")
	pass # Replace with function body.
