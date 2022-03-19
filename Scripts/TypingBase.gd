extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Array, String) var typeList = [
	"Hello there",
	"World",
	"test"
]
var currentWord = 0
var lastTypedIndex = 0
var nextScene = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if currentWord >= typeList.size():
		#change to next level
		Transition.transition(nextScene)
		pass
	else:
		typeLetter()
		decorateType()
		
func typeLetter():
	
	if lastTypedIndex < typeList[currentWord].length():
		# make sure it's not a shift or another character
		if TypingHandler.currentKey != null:
			var current = str(TypingHandler.currentKey).to_lower()
			
			if current == typeList[currentWord][lastTypedIndex].to_lower():
				lastTypedIndex += 1
			else:
				if lastTypedIndex != 0 and current == typeList[currentWord][lastTypedIndex-1].to_lower():
					# add some forgiveness for accidentally doubled last character
					pass
				else:
					lastTypedIndex = 0
			
			print(str(TypingHandler.currentKey), lastTypedIndex)
	elif $NextWordTimer.is_stopped():
		$NextWordTimer.start()
		# when the timer times out, reset the indexes

func decorateType() -> void:
	var colorStart = "[color=#FFAAAA]"
	var colorEnd =  "[/color]"
	$ToType.bbcode_text = typeList[currentWord].substr(0, lastTypedIndex)+colorStart+typeList[currentWord].substr(lastTypedIndex, -1)+colorEnd


func _on_NextWordTimer_timeout():
	lastTypedIndex = 0
	currentWord += 1
	pass # Replace with function body.
