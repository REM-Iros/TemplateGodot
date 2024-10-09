extends Node

## Basic event manager that allows for signals to be passed
## and triggered with listeners to cause events to occur. 

# Event dictionary for storing all events
var event_dict = {}

# This will register a new signal for use
func register_event(event_name: String):
	if not event_dict.has(event_name):
		event_dict[event_name] = Signal()

# Connects an event with a target and a method
func connect_event(event_name: String, target: Object, method: String):
	if event_dict.has(event_name):
		event_dict[event_name].connect(target, method)
	else:
		printerr("Event not found: ", event_name)

# Call an event
func emit_event(event_name: String, data = null):
	if event_dict.has(event_name):
		event_dict[event_name].emit(data)
	else:
		printerr("Event not found: ", event_name)

# Removes an event from the dict
func remove_event(event_name: String):
	if event_dict.has(event_name):
		event_dict.erase(event_name)
	else:
		printerr("Event not found: ", event_name)
