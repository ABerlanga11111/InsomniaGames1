extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
const GAME_SCENE = "res://Scenes/GameScene.tscn"
const SETTINGS_SCENE = "res://Scenes/settings_menu.tscn"


func _ready():
	make_menu()


func make_menu():
	var background = ColorRect.new()
	background.color = Color("#080d24")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var center = CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var layout = VBoxContainer.new()
	layout.custom_minimum_size = Vector2(340, 0)
	layout.add_theme_constant_override("separation", 18)
	center.add_child(layout)

	var title = Label.new()
	title.text = "GALAGA"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 54)
	title.add_theme_color_override("font_color", Color("#55eaff"))
	layout.add_child(title)

	var play_button = Button.new()
	play_button.text = "PLAY"
	play_button.custom_minimum_size.y = 50
	play_button.pressed.connect(play_game)
	layout.add_child(play_button)

	var settings_button = Button.new()
	settings_button.text = "SETTINGS"
	settings_button.custom_minimum_size.y = 50
	settings_button.pressed.connect(open_settings)
	layout.add_child(settings_button)

	var quit_button = Button.new()
	quit_button.text = "QUIT"
	quit_button.custom_minimum_size.y = 50
	quit_button.pressed.connect(quit_game)
	layout.add_child(quit_button)


func play_game():
	get_tree().change_scene_to_file(GAME_SCENE)


func open_settings():
	var settings_scene = load(SETTINGS_SCENE).instantiate()
	get_tree().root.add_child(settings_scene)


func quit_game():
	get_tree().quit()
