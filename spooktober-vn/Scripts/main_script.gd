extends Node2D


@onready var dialog_ui = %Dialog_UI
@onready var character_sprite = %CharacterSprite

var dialog_index: int = 0
var dialog_lines: Array = []

func _ready():
	#load dialog
	dialog_lines = load_dialog("res://Dialogues/chapter1.json")
	
	#connect signals
	dialog_ui.text_animation_done.connect(_on_text_animation_done)
	dialog_ui.choice_selected.connect(_on_choice_selected)
	#process the 1st line
	dialog_index = 0
	process_current_line()


	#get to the next dialog line
func _input(event):
	var line = dialog_lines[dialog_index]
	var has_choices = line.has("choises")	
	if event.is_action_pressed("next_line") and not has_choices:
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		if dialog_index < len(dialog_lines) - 1:
			dialog_index += 1
			process_current_line()


	#puts the name and dialog into their own text boxes
func process_current_line():
	var line = dialog_lines[dialog_index]
	#check for special lines (choices)
	if line.has("goto"):
		dialog_index = get_to_anchor_position(line["goto"])
		process_current_line()
		return
	
	#Lines containig anchors WILL be skipped.
	if line.has("anchor"):
		dialog_index += 1
		process_current_line()
		return
	
	if line.has("choices"):
		#Display choices
		dialog_ui.display_choices(line["choises"])
	else:
		#read the dialog
		var character_name = Character.get_enum_from_string(line["speaker"])
		dialog_ui.change_line(character_name, line["text"])
#		character_sprite.change_character(character_name)


func get_to_anchor_position(anchor: String):
	#find the specific anchor (the thing that marks where a choice takes the player in terms of dialog_index)
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
	
	#anchor was not found (check for typos)
	printerr("couldnt find andchor: '" +  anchor + "'")
	return null


func load_dialog(file_path):
	if FileAccess.file_exists(file_path):
		printerr("the file does not exist ", file_path)
		return null
	
	#open file
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Failed to open file ", file_path)
		return null
	
	#read the content of the Json
	var content = file.get_as_text()
	
	#parse the content
	var json_content = JSON.parse_string(content)
	
	if json_content == null:
		printerr("Failed to parse the content of ", file_path)
		return null
	
	return json_content


func _on_choice_selected(anchor: String):
	dialog_index = get_to_anchor_position(anchor)
	process_current_line()


func _on_text_animation_done():
	#character_sprite.play_idle_animation()
	pass
