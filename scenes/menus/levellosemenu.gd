extends Control


func _on_try_again_btn_pressed():
	Global.load_level()


func _on_main_menu_btn_pressed():
	Global.load_main_menu()

func _ready():
	Global.save()
