extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Shoot"):
		var bullet := PoolManager.get_object("res://Scenes/Bullet.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.UP)
		#Debug code to verify pool manager functionality by using a burst fire mode
		print(bullet.name)
		await get_tree().create_timer(.05).timeout
		bullet = PoolManager.get_object("res://Scenes/Bullet.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.UP)
		print(bullet.name)
		await get_tree().create_timer(.05).timeout
		bullet = PoolManager.get_object("res://Scenes/Bullet.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.UP)
		print(bullet.name)
