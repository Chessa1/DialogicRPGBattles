extends Node
class_name RNG_Dialog

var dialogs = []

# Returns the name of a random timeline or null if the list is empty
func _pick_a_dialog(pop_up=false):
	dialogs.shuffle()
	var dialog = dialogs[randi()%dialogs.size()]
	if pop_up and dialogs.size()>0: dialogs.erase(dialog)
	return dialog if dialogs.size()>0 else null

# (Not working, I guess) Set the current timeline and return true or return false if the list is empty
func _set_a_dialog(pop_up=false):
	if dialogs.size()<=0:
		return false
	else:
		dialogs.shuffle()
		var dialog = dialogs[randi()%dialogs.size()]
		if pop_up and dialogs.size()>0: dialogs.erase(dialog)
		Dialogic.start(dialog)
		return true

# Returns a Dialog_Node with a random timeline or null if the list is empty
func _start_a_dialog(pop_up=false):
	if dialogs.size()<=0:
		return null
	else:
		dialogs.shuffle()
		var dialog = dialogs[randi()%dialogs.size()]
		if pop_up and dialogs.size()>0: dialogs.erase(dialog)
		return Dialogic.start(dialog)



