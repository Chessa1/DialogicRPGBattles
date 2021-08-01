extends Node2D

var RNG_OnDefend: RNG_Dialog
var RNG_AtAttack: RNG_Dialog

func _ready():
	randomize()
	# Two RNG_Dialogs to make two different lists
	RNG_OnDefend = RNG_Dialog.new()
	RNG_AtAttack = RNG_Dialog.new()
	add_child(RNG_OnDefend)
	add_child(RNG_AtAttack)

	# set the dialog list from each of them
	RNG_OnDefend.dialogs = [
		"Timeline2",
		"Timeline3",
	]
	RNG_AtAttack.dialogs = [
		"Timeline4",
		"Timeline5",
	]

	# start a default timeline until begin the loop
	var dialog = Dialogic.start("Timeline1")
	add_child(dialog)
	dialog.connect("dialogic_signal",self,"dialogic_signal")

func _on_Reload_pressed():
	get_tree().reload_current_scene()

# Signal emitted from Dialogic
func dialogic_signal(argument):
	# Just to make sure that the argument is one that was setted
	if argument!="defend" and argument!="attack":return
	# variable to store the dialogic_node
	var dialog

	var variables= {}
	for var_ in["Slimehealth", "Playerhealth", "Battle"]:
		variables[var_] = Dialogic.get_variable(var_)

	# if the argument is 'defend', get a timeline from the defending list
	if argument == "defend":
		dialog = RNG_OnDefend._start_a_dialog($CanvasLayer/VBoxContainer/CheckButton.pressed)
	# if the argument is 'attack', get a timeline from the attacking list
	elif argument == "attack":
		dialog = RNG_AtAttack._start_a_dialog($CanvasLayer/VBoxContainer/CheckButton.pressed)

	# if occured any error and was not possible to get a dialogic_node, return
	if dialog==null:return
	add_child(dialog)
	# add the dialogic_node and connect the signal that is trigged from it to this function, making a loop
	dialog.connect("dialogic_signal",self,"dialogic_signal")

	for i in variables:
		Dialogic.set_variable(i,variables[i])
