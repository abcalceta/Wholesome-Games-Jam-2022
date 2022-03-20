extends Node2D

export(Array, String) var typeList = [
	"Hello there",
	"World",
	"test"
]
var currentWord = 0
var lastTypedIndex = 0
var checkpoint = 0
var nextScene = ""
var punctuation = [".", ",", "!", "'", ";", "...", "?"]
signal finishedWord

func _ready():
	pass 

func _process(delta):
	if currentWord >= typeList.size():
		$ToType.visible = false
		#change to next level
		Transition.transition(nextScene)
		pass
	else:
		if not $ToType.visible:
			$AnimationPlayer.play("show")
			$ToType.visible = true
		if Input.is_action_just_pressed("alphabet"):
			typeLetter()
		if Input.is_action_just_pressed("ui_accept"):
			if lastTypedIndex >= typeList[currentWord].length():
				if $NextWordTimer.is_stopped():
					$AnimationPlayer.play("hide")
					$NextWordTimer.start()
		decorateType()
		
func typeLetter():
	if lastTypedIndex < typeList[currentWord].length():
		# make sure it's not a shift or another character
		if (TypingHandler.currentKey != null) and not (TypingHandler.currentKey in punctuation):
			var current = str(TypingHandler.currentKey).to_lower()
			
			#spaces are checkpoints
			#if typeList[currentWord][lastTypedIndex] == " ":
			#	checkpoint = lastTypedIndex
				
			if current == typeList[currentWord][lastTypedIndex].to_lower():
				lastTypedIndex += 1
				checkpoint = lastTypedIndex
			else:
				if lastTypedIndex != 0 and current == typeList[currentWord][lastTypedIndex-1].to_lower():
					# add some forgiveness for accidentally doubled last character
					pass
				if lastTypedIndex != typeList[currentWord].length() and typeList[currentWord][lastTypedIndex] == " " and current == typeList[currentWord][lastTypedIndex+1].to_lower():
					# make spaces optional
					lastTypedIndex += 2
					
			print(str(TypingHandler.currentKey), lastTypedIndex)
			
			if lastTypedIndex < typeList[currentWord].length() and typeList[currentWord][lastTypedIndex] in punctuation:
				#check if ellipsis
				if lastTypedIndex+2 < typeList[currentWord].length() and typeList[currentWord][lastTypedIndex+1] == "." and typeList[currentWord][lastTypedIndex+2] == ".":
					lastTypedIndex += 3
				else:
					# skip punctuation
					lastTypedIndex += 1

func decorateType() -> void:
	var colorStart = "[color=#AAAAAA]"
	var colorEnd =  "[/color]"
	$ToType.bbcode_text = "[center][color=#000000]"+typeList[currentWord].substr(0, lastTypedIndex)+colorEnd+colorStart+typeList[currentWord].substr(lastTypedIndex, -1)+colorEnd+"[/center]"


func _on_NextWordTimer_timeout():
	# when the timer times out, reset the indexes
	lastTypedIndex = 0
	currentWord += 1
	emit_signal("finishedWord")
	$AnimationPlayer.play("show")
	pass # Replace with function body.


func _on_TypingBase_finishedWord():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hide":
		$ToType.hide()
	pass # Replace with function body.
