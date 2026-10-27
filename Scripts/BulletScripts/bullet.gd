extends Area2D

class_name Bullet

enum StatsKey { Damage, Speed, Scale, Modulate, Homing }
var speed : float
var damage : float

var direction := Vector2.UP
var _pool_manager: Node
var Fired : bool = false

var velocity : Vector2 = Vector2.ZERO

#@onready var notifier: VisibleOnScreenNotifier2D = $"./VisibleOnScreenNotifier2D"


func _ready() -> void:
	pass
	#return to the pool when leaving screen (_ready() runs once, so connecting here is fine)
	#notifier.screen_exited.connect(return_to_pool) # Should leave screen when it hits something so this'll work for our purposes

func set_pool_manager(manager: Node) -> void:
	_pool_manager = manager

#Initialization instead of _ready(), call when pulled out of pool manager
func spawn(start_position: Vector2, travel_direction: Vector2, NewBulletStats : Array) -> bool:
	#start_position should be a 2dMarker just in front of player char, travel direction should just be Vector2.UP
	global_position = start_position
	Fired = true
	direction = travel_direction.normalized()
	damage = NewBulletStats[StatsKey.Damage]
	speed = NewBulletStats[StatsKey.Speed]
	scale = NewBulletStats[StatsKey.Scale]
	modulate = NewBulletStats[StatsKey.Modulate]
	rotation = (direction.angle() + PI/2)
	
	return true
	

func reset() -> void:
	velocity = Vector2.ZERO
	

func _physics_process(delta):
	if Fired:
		velocity = direction * speed
		global_position += velocity * delta

func return_to_pool() -> void:
	if _pool_manager:
		#avoid returning during physics; defer for safety
		_pool_manager.return_object(self, "res://Scenes/Bullet.tscn")
	else:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	return_to_pool()


func _on_body_entered(body):
	pass
