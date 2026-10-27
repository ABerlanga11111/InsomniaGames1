extends Bullet


func return_to_pool() -> void:
	if _pool_manager:
		#avoid returning during physics; defer for safety
		_pool_manager.return_object(self, "res://Scenes/enemy_bullet_basic.tscn")
	else:
		queue_free()

func _on_body_entered(body):
	if body is PlayerShip:
		body.take_damage(damage)
	return_to_pool()

func _on_visible_on_screen_enabler_2d_screen_exited():
	return_to_pool()
