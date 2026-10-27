extends Control

func _ready():
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")

func _on_statsistics_button_pressed() -> void: 
	get_tree().change_scene_to_file("res://Scenes/statistics_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_achievements_button_pressed() -> void:
	print("ACHIEVEMENTS BUTTON WAS CLICKED!")
	get_tree().change_scene_to_file("res://Scenes/achievements_menu.tscn")
