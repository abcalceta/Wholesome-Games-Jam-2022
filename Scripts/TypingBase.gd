extends Node2D

export(Array, String) var typeList = [
	"Hello there",
	"World",
	"test"
]
var currentWord = 0
var lastTypedIndex = 0
var nextScene = ""

signal finishedWord

func _ready():
	pass 

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
		if (TypingHandler.currentKey != null) and not (TypingHandler.currentKey in [".", ",", "!"]):
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
		if TypingHandler.currentKey in [".", ",", "!"]:
			# skip punctuation
			lastTypedIndex += 1
			
			
	elif $NextWordTimer.is_stopped():
		$NextWordTimer.start()
		emit_signal("finishedWord")
		# when the timer times out, reset the indexes

func decorateType() -> void:
	var colorStart = "[color=#FFAAAA]"
	var colorEnd =  "[/color]"
	$ToType.bbcode_text = "[center]"+typeList[currentWord].substr(0, lastTypedIndex)+colorStart+typeList[currentWord].substr(lastTypedIndex, -1)+colorEnd+"[/center]"


func _on_NextWordTimer_timeout():
	lastTypedIndex = 0
	currentWord += 1
	pass # Replace with function body.


func _on_TypingBase_finishedWord():
	pass # Replace with function body.
