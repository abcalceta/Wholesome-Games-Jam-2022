extends "res://Scripts/TypingBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Array, int) var dialoguePos = [
0,
2,
2,
2,
0,
0,
0,
2,
0,
-1,
1,
0,
0,
1,
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
		TypingHandler.get_node("AudioStreamPlayer").pitch_scale = rand_range(1.5, 1.6)
		$Chara1.play("talking")
		$Chara2.play("default")
		$Chara3.play("default")
	elif dialoguePos[currentWord] == 1:
		$ToType.rect_position = $Pos1.position
		TypingHandler.get_node("AudioStreamPlayer").pitch_scale = rand_range(0.9, 1.0)		
		$Chara1.play("default")
		$Chara2.play("talking")
		$Chara3.play("default")
	elif dialoguePos[currentWord] == 2:
		$ToType.rect_position = $Pos2.position
		TypingHandler.get_node("AudioStreamPlayer").pitch_scale = rand_range(0.7, 0.8)		
		$Chara1.play("default")
		$Chara2.play("default")
		$Chara3.play("talking")
	#specials
	elif dialoguePos[currentWord] == -1:
		$Chara2.show()
		$ToType.rect_position = $Pos1.position
		TypingHandler.get_node("AudioStreamPlayer").pitch_scale = rand_range(0.9, 1.0)		
		$Chara1.play("default")
		$Chara2.play("talking")
		$Chara3.play("default")
