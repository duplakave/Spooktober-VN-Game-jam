extends Control

signal text_animation_done
signal choice_selected

#preload the button schene
const ChoiceButtonsSchene = preload("res://Schenes/player_choice.tscn")

@onready var speaker_name = %speaker_name
@onready var dialog_line = %dialog_lines
@onready var choice_list = %ChoiceList

const ANIMATION_SPEED: int = 30
var animate_text: bool = false
var current_visible_characters: int = 0

func _ready():
	#hide the ChoiceList untill its needed
	choice_list.hide()


func _process(delta):
	if animate_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0/dialog_line.text.lenght()) * (ANIMATION_SPEED*delta)
			current_visible_characters = dialog_line.visible_characters
	else:
		animate_text = false
		text_animation_done.emit()


func change_line(speaker: String, line:String): 
	speaker_name.text = speaker
	current_visible_characters = 0
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true


	#display choices
func display_choices(choices: Array): 
	#clear any existing choice buttons
	for child in choice_list.get_children():
		child.queue_free()
	#create a button for each choice
	for choice in choices:
		var choice_button = ChoiceButtonsSchene.instantiate()
		choice_button.text = choice["text"]
		#attach "pressed" signal to button
		choice_button.pressed.connect(_on_choice_button_pressed.bind(anchor["goto"]))
		#add it to the ChoiceList
		choice_list.add_child(choice_button)

	#Show ChoiceList
	choice_list.show() 


func _on_choice_button_pressed(anchor: String):
	choice_selected.emit(anchor)
	choice_list.hide()


func skip_text_animation():
	dialog_line.visible_ration = 1
