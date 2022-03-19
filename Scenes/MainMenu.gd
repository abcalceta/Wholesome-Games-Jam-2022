extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var typeList = [
	"Hello",
	"World"
]
var currentWord = 0
var lastTypedIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if currentWord >= typeList.size():
		#temporary, should be change to next level
		get_tree().reload_current_scene()
		pass
	else:
		typeLetter()
		decorateType()
		
func typeLetter():
	
	if lastTypedIndex < typeList[currentWord].length():
		# make sure it's not a shift or another character
		if str(TypingHandler.currentKey).to_lower() in ["a", "b", "c", "d", "e", "f", "g", 
		"h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", 
		"w", "x", "y", "z"]:
			var current = str(TypingHandler.currentKey)
			
			if current == typeList[currentWord][lastTypedIndex]:
				lastTypedIndex += 1
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
