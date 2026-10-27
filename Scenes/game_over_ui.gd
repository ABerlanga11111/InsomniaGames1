
extends CanvasLayer

# Hide the Game Over screen when the game starts
func _ready() -> void:
	hide()

# Show the Game Over screen when the player dies
func show_game_over() -> void:
	show()

# Press K to simulate the player dying
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo and event.keycode == KEY_K:
			show_game_over()

# Restart the game when the button is pressed
func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
