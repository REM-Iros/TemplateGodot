extends Node

## Scene manager script, handles which scene we are currently running at the
## time. Should be callable in the current scene, and allow the scene to choose
## which scene to move to next.

## Some things to consider going forward ---
## - might need a few different load scenes to pass in different vars
## - fade-in/out?
## - more to come

# Store a direct ref to the parent node because I don't think I'll
# ever end up not using it anyways
@export var parent_node: Node

# Store a string for the main menu scene, this could be a problem
# if the scene path changes but should be fine for now
@export var main_menu_path: String

# When game first loads up, boot up the main menu
func _ready():
	load_scene(main_menu_path)

# Called when something wants to change scenes
# Checks to ensure the scene is proper, if it works,
# then we load it in and unload a scene
func load_scene(scene_path: String):
	# Define var for the scene, check if it exists
	var new_scene = load(scene_path).instantiate()
	if !new_scene:
		print_debug("Scene not found, bad path")
		return
	
	# If we have no children, just add it to the parent
	if parent_node.get_child_count() == 0:
		parent_node.add_child(new_scene)
	# If we have a child, then we need to unload the child and
	# load the new scene
	else:
		unload_scene()
		parent_node.add_child(new_scene)
	
# Does what it advertises, just unloads a scene
func unload_scene():
	parent_node.get_child(0).queue_free()
	pass
