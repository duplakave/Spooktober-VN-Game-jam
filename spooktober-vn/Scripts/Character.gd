class_name Character

extends Node

enum Name {
	CASHIER_GIRL,
	SPLIT_MOUTH_WOMAN,
	MYSTERIOUS_WOMAN,
	PLAYER
}

const CHARACTER_DETAILS: Dictionary = {
	Name.CASHIER_GIRL: {
		"name": "Cashier girl",
		"sprite_frames": preload("res://Assets/Characters/cashier_girl.tres"),
		"blip": "placeholder"
	},
	Name.SPLIT_MOUTH_WOMAN: {
		"name": "Kuchisake-onna",
		"sprite_frames": preload("res://Assets/Characters/split_mouth_woman.tres"),
		"blip": "placeholder"
	},
	Name.MYSTERIOUS_WOMAN: {
		"name": "Mysterious woman",
		"sprite_frames": preload("res://Assets/Characters/split_mouth_woman.tres"),
		"blip": "placeholder"
	},
	Name.PLAYER: {
		"name": "Player",
		"sprite_frames": null,
		"blip": "placeholder"
		
	}
}

static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Invalid character name: " + string_value)
		return 1
	
