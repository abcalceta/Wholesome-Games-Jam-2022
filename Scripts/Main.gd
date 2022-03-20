extends Node

var test = Dialogic.start("Test")

var typeList = [
	"Test",
	"One",
	"Two",
	"Three"
]
var currentWord = 0
var lastTypedIndex = 0
var nextScene = ""

signal finishedWord

func _ready():
	$Control.visible = false
	if get_node_or_null("DialogNode") == null:
		test.connect("dialogic_signal", self, "dialog_listener")
		add_child(test)

func _process(delta):
	if currentWord >= typeList.size():
		#change to next level
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
	$Control/RichTextLabel.bbcode_text = "[center]"+typeList[currentWord].substr(0, lastTypedIndex)+colorStart+typeList[currentWord].substr(lastTypedIndex, -1)+colorEnd+"[/center]"


func dialog_listener(string):
	match string:
		"text_visable":
			$Control.visible = true
			pass


func _on_Main_finishedWord():
	lastTypedIndex = 0
	if currentWord < 3:
		currentWord += 1
	else:
		currentWord = 0
	pass # Replace with function body.
