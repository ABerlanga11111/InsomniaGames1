extends Bullet


func _on_body_entered(body):
	if body is PlayerShip:
		body.take_damage(damage)
	else:
		pass
