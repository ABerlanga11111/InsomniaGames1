extends Area2D


const SPEED = 250.0
var direction := Vector2.UP
var _pool_manager: Node

var velocity : Vector2 = Vector2.ZERO

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D


func _ready() -> void:
	pass
	#return to the pool when leaving screen (_ready() runs once, so connecting here is fine)
	#notifier.screen_exited.connect(return_to_pool) # Should leave screen when it hits something so this'll work for our purposes

func set_pool_manager(manager: Node) -> void:
	_pool_manager = manager

#Initialization instead of _ready(), call when pulled out of pool manager
func spawn(start_position: Vector2, travel_direction: Vector2) -> void:
	#start_position should be a 2dMarker just in front of player char, travel direction should just be Vector2.UP
	global_position = start_position
	direction = travel_direction.normalized()
	rotation = (direction.angle() + PI/2)
	

func reset() -> void:
	velocity = Vector2.ZERO

func _physics_process(delta):
	velocity = direction * SPEED
	global_position += velocity * delta

func return_to_pool() -> void:
	if _pool_manager:
		#avoid returning during physics; defer for safety
		_pool_manager.return_object(self, "res://Scenes/Bullet.tscn")
	else:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	return_to_pool()
