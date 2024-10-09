extends Node

## Giant data manager that interfaces with a Save Manager to store data
## and pass it back and forth. Data manager will be updated during gameplay

@export var save_manager: Node
var json = JSON.new

var game_data = {}

# This is called by the save manager when we create a new game
# Sets the data to the initial values
func init_data(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	game_data = json.parse_string(file.get_as_text())

# Called by save manager on loading, sets the game_data to be this value
func set_data(content):
	game_data = content
	
# Called by game to register new data to be held
func add_data(data_id: String, init_value):
	if not game_data.has(data_id):
		game_data[data_id] = init_value
	else:
		printerr("Data already exists, mod with update data")
	
# Called by game to update the data stored currently
func update_data(data_id: String, value):
	if game_data.has(data_id):
		game_data[data_id] = value
	else:
		printerr("No data with that id found")
		
func get_data_by_key(data_id: String):
	if game_data.has(data_id):
		return game_data[data_id]
	else:
		printerr("Key not found:", data_id)
	
# This returns the current data we have 
func get_data():
	return game_data
