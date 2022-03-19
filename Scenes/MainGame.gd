extends "res://Scripts/TypingBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Array, int) var dialoguePos = [
	1,
	2,
	0,
	2,
	1,
	1,
	2,
	0,
	2,
	1	
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	nextScene = "res://Scenes/MainMenu.tscn"
	setPos()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TypingBase_finishedWord():
	setPos()
	pass # Replace with function body.

func setPos():
	if dialoguePos[currentWord] == 0:
		$ToType.rect_position = $Pos0.position
	elif dialoguePos[currentWord] == 1:
		$ToType.rect_position = $Pos1.position
	elif dialoguePos[currentWord] == 2:
		$ToType.rect_position = $Pos2.position
