extends Control

class_name MyMain

signal game_save_started()
signal game_save_finished()
signal game_load_started()
signal game_load_finished()

var _saver_loader := SaverLoader.new()

onready var fullscreentogglevalue = OS.is_window_maximized()

const PERSIST_PROPERTIES := []
const PERSIST_OBJ_PROPERTIES := []
const SAVE_PATH = "res://save.json"


func _on_ready():
	load_game(SAVE_PATH)
	var _PERSIST_AS_PROCEDURAL_OBJECT = true
#	if fullscreentogglevalue == true:
#		.get_scene().find_node("FullScreen_Toggle").set(fullscreentogglevalue, true)
	pass

func load_game(SAVE_PATH: String) -> void:
	var save_file := File.new()
# warning-ignore:return_value_discarded
	save_file.open(SAVE_PATH, File.READ)
	emit_signal("game_load_started")
	_saver_loader.load_game(save_file, get_tree())
	yield(_saver_loader, "finished")
	emit_signal("game_load_finished")
	pass
	

func save_game(SAVE_PATH: String) -> void:
	var save_file := File.new()
# warning-ignore:return_value_discarded
	save_file.open(SAVE_PATH, File.WRITE)
	emit_signal("game_save_started")
	_saver_loader.save_game(save_file, get_tree())
	yield(_saver_loader, "finished")
	emit_signal("game_save_finished")
	print("Game saved")
	pass
	

func _on_FullScreen_Toggle_toggled(_button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
	print("Window Fullscreen Toggled")
	pass 

func _on_Save_Button_pressed():
	print("Save button was pressed!")
	save_game(SAVE_PATH)
	pass 


func _on_Load_Button_pressed():
	load_game(SAVE_PATH)
	pass # Replace with function body.
