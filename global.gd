extends Node

var stopwatch_time: float = 0
var save_path = "save.dat"

var levels = ["res://scenes/levels/level0.tscn", "res://scenes/levels/level1.tscn",
 "res://scenes/levels/level2.tscn"]
var level_ind: int = 0
func game_beaten() -> bool:
	return level_ind >= len(levels)

func load_level():
	print("level_ind ", level_ind)
	var path = levels[level_ind]
	get_tree().change_scene_to_file(path)

func load_same_level():
	load_level()

func load_next_level():
	if game_beaten():
		load_win_menu()
	else:
		load_level()

func load_main_menu():
	get_tree().change_scene_to_file("res://scenes/menus/mainmenu.tscn")
	
func load_win_menu():
	get_tree().change_scene_to_file("res://scenes/menus/levelendmenu.tscn")
	
func load_lose_menu():
	get_tree().change_scene_to_file("res://scenes/menus/levellosemenu.tscn")
	
func load_win():
	print("You beat the game, congrats")

func save():
	var content = str(level_ind) + " " + str(Global.stopwatch_time)
	util_save(content)
	print("Saved ", content)
	
func load_save():
	var save_text = util_load()
	print("Loading ", save_text)
	var args = save_text.split(" ")
	level_ind = int(args[0])
	stopwatch_time = float(args[1])
	
func util_save(content):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(content)

func util_load() -> String:
	var file = FileAccess.open(save_path, FileAccess.READ)
	var content = file.get_as_text()
	return content
