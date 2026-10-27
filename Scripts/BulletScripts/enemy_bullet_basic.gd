extends Bullet

var PlayerTarget = null
var Homing : bool = false

@onready var HuntdownTimer : Timer = $Timer

func _physics_process(delta):
	if Fired:
		if (PlayerTarget && Homing):
			direction = global_position.direction_to(PlayerTarget.global_position)
			direction.normalized()
		velocity = direction * speed
		global_position += velocity * delta

func spawn(start_position: Vector2, travel_direction: Vector2, NewBulletStats : Array, target : PlayerShip = null) -> bool:
	#start_position should be a 2dMarker just in front of player char, travel direction should just be Vector2.UP
	global_position = start_position
	Fired = true
	direction = travel_direction.normalized()
	damage = NewBulletStats[StatsKey.Damage]
	speed = NewBulletStats[StatsKey.Speed]
	scale = NewBulletStats[StatsKey.Scale]
	modulate = NewBulletStats[StatsKey.Modulate]
	if target:
		Homing = NewBulletStats[StatsKey.Homing]
		PlayerTarget = target
		HuntdownTimer.start(.75)
	rotation = (direction.angle() + PI/2)
	
	return true

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


func _on_timer_timeout():
	Homing = false
