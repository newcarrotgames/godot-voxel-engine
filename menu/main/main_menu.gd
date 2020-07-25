extends Control

onready var tree = get_tree()

onready var title = $TitleScreen
onready var start = $StartGame
onready var options = $Options


func _on_Start_pressed():
	start.visible = true
	title.visible = false


func _on_Options_pressed():
	options.prev_menu = title
	options.visible = true
	title.visible = false


func _on_Exit_pressed():
	tree.quit()


func _on_RandomBlocks_pressed():
	Settings.world_type = 0
	start_World()


func _on_SimpleNoise_pressed():
	Settings.world_type = 1
	start_World()


func _on_BackToTitle_pressed():
	title.visible = true
	start.visible = false


func start_World():
	tree.change_scene("res://world/world.tscn")
