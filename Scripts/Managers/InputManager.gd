extends Node

## This script is an input manager. It will handle all input controls, we will
## be ignoring the input actions because they don't allow for easy remapping,
## and it will be simpler in the long run to build it here and now. If Godot
## gets better remapping, then I will consider it, but until then, oof.

## Will be building this like the input maps from Unity becuz I like them.

# preload input map enum
const InputMaps = preload("res://Scripts/Utils/Enums/input_map_enum.gd")

# deadzone value
var deadzone = 0.5

# Menu map for when the player is interacting with main menu, and pause menu
var menu_actions = {
	"move_up": [
		{"key": KEY_W, "is_axis": false, "axis_direction": 0}, 
		{"key": JOY_AXIS_LEFT_Y, "is_axis": true, "axis_direction": -1}
	],
	"move_down": [
		{"key": KEY_S, "is_axis": false, "axis_direction": 0}, 
		{"key": JOY_AXIS_LEFT_Y, "is_axis": true, "axis_direction": 1}
	],
	"move_left": [
		{"key": KEY_A, "is_axis": false, "axis_direction": 0}, 
		{"key": JOY_AXIS_LEFT_X, "is_axis": true, "axis_direction": -1}
	],
	"move_right": [
		{"key": KEY_D, "is_axis": false, "axis_direction": 0}, 
		{"key": JOY_AXIS_LEFT_X, "is_axis": true, "axis_direction": 1}
	],
	"submit": [
		{"key": KEY_J, "is_axis": false, "axis_direction": 0}, 
		{"key": JOY_BUTTON_A, "is_axis": false, "axis_direction": 0}
		],
	"cancel": [
		{"key": KEY_K, "is_axis": false, "axis_direction": 0}, 
		{"key": JOY_BUTTON_B, "is_axis": false, "axis_direction": 0}
	]
}

var game_actions = {
	#Build out your other action maps here
	
}

# Create a method that handles when actions are pressed
# Proper use calling this in a method is if menu_action_pressed(action):
func action_pressed(action_name: String, action_map: GameInputMap):
	# We use this case statement to determine which input map we are using
	var map = _get_map(action_map)
	var inputs = map.get(action_name, [])
	
	# Check all of the inputs that are mapped
	for input in inputs:
		# Check if the input is from a joystick
		if input["is_axis"]:
			# Check if the proper axis is working and if we have
			# passed the deadzone
			var axis = Input.get_joy_axis(0, input["key"])
			if input["axis_direction"] > 0 and axis > deadzone:
				return true
			elif input["axis_direction"] < 0 and axis < -deadzone:
				return true
		# Otherwise, input is from a key on the keyboard
		else:
			# Check if the key is pressed
			if Input.is_key_pressed(input["key"]):
				return true
	
	return false

# Remap function for rebinding the key if we need to
# NOTE: Can't remap the movement for a gamepad specifically, don't want to mess
# with that hornet's nest
func remap(action_name: String, action_map: GameInputMap, new_key: int, is_gamepad: bool):
	# Get the map and then the associated input
	var map = _get_map(action_map)
	var inputs = map.get(action_name, [])
	
	# Bool evals to 0 or 1 (0 is keyboard, 1 gamepad)
	# We then set the key to be the new value
	inputs[is_gamepad]["key"] = new_key

# Quick method to return the proper action map for the computer to use
func _get_map(action_map: GameInputMap):
	# This gets called any time we need to perform some action on a different
	# map, and so we simply return which one in the enum is being used
	match action_map:
		InputMaps.InputMapType.MENU:
			return menu_actions
		InputMaps.InputMapType.GAME:
			return game_actions
