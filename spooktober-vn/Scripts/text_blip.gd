extends AudioStreamPlayer2D

const sounds: Dictionary = {
	"placeholder": preload("res://Assets/Characters/text_blips/placeholder.wav")
}

# MAKE AN OPTION IN THE MENU TO MUTE THE TEXT BLIP, BC IT WILL BE COOL

func play_sound(character_details: Dictionary):
	var character_blip_type = character_details["blip"]
	stream = sounds[character_blip_type]
	play()
	
