class_name Character
extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

#This stores the name of every character in the game
enum Name{
	TEST
}

#this stores the details of every character
const CHARACTER_DETAILS = {
	Name.TEST:{
		"name": "Test",
		"sprite_frames": null
	}
}


static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Invalid character name: " + string_value)
		return -1

#plays the talking animation when a character talks
func change_character(character_name: Character.Name, is_talking : bool = true):
	var sprite_frames = Character.CHARACTER_DETAILS[character_name]["sprite_frames"]
	if sprite_frames:
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.play("talking") if is_talking else animated_sprite.play("idle")
	else:
		animated_sprite.play("idle")

func play_idle_animation():
	animated_sprite.play("idle")
