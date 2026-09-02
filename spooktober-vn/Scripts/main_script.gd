extends Node2D


@onready var dialog_ui = %Dialog_UI

var dialog_index: int = 0

func _ready():
	dialog_index = 0
	process_current_line()
	
func _input(event):
	if event.is_action_pressed("next_line"):
		if dialog_index < len(dialog_lines) - 1:
			dialog_index += 1
			process_current_line()


func parse_line(line: String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2)
	return{
		"speaker_name": line_info[0],
		"dialog_line": line_info[1],
	}
	
func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	dialog_ui.speaker_name.text = line_info["speaker_name"]
	dialog_ui.dialog_line.text = line_info["dialog_line"]
	
