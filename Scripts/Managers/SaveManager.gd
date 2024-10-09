extends Node

## Save manager script that handles basic saving and loading. It will
## need to be integrated with the data manager to read the data from the
## game, save it to a file, and then load from that data file into the
## data manager to load states of the game. For now though, the template will
## work fine with this.

## Tutorial from Andrew Hoffman https://www.youtube.com/watch?v=rDGyw9z6Le8

# Store the path and a json variable for use
var json = JSON.new
var path = "user://save_game.dat"

@export var data_manager: Node

# Basic save function, saves data to a user file
func write_save():
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(data_manager.get_data()))
	file.close()
	file = null

# Basic loading function, pulls from a save_game file and returns the values
func load_game():
	var file = FileAccess.open(path, FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	data_manager.set_data(content)

# This script is called when we need to create a new save
func create_new_save():
	data_manager.init_data("res://Scripts/Utils/default_save.json")
