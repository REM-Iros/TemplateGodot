extends Node

## Audio manager which controls the sound effects and music.
## This should allow for multiple sfx to play at once without
## interrupting each other, as well as allowing for variable
## music. It should also hold variables for general volume, which
## settings will edit

#TODO: Need to update this when I have a better understanding of how I'm
#gonna use this

# Nodes for music
@onready var music_base = $MusicPlayer1
@onready var music_layer_2 = $MusicPlayer2
@onready var music_layer_3 = $MusicPlayer3

# Nodes for sfx
@onready var sfx_player = $SFXPlayer

# Play the music
func play_music(music_path: String):
	# Load the music
	var music = load(music_path) as AudioStream
	
	# Set it into the player then play if present
	if music:
		music_base.stream = music
		music_base.play()

# Stops the music
func stop_music():
	if music_base.playing:
		music_base.stop()

# Play the sfx
func play_sfx(sfx_path: String):
	# Load the music
	var sfx = load(sfx_path) as AudioStream
	
	# Set it into the sfx player then play on available
	if sfx:
		sfx_player.stream = sfx
		sfx_player.play()

# Stops the sfx
func stop_sfx():
	if sfx_player.playing:
		sfx_player.stop()
