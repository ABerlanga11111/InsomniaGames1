extends CharacterBody2D

class_name Enemy

@export var EnemyStats : Resource

@onready var CurrentHealth = EnemyStats.MaxHealth
@onready var BulletStats : Array = [EnemyStats.BulletDamage, EnemyStats.BulletSpeed, EnemyStats.BulletScale]

var _pool_manager

func set_pool_manager(manager: Node) -> void:
	_pool_manager = manager

func Spawn(DifficultyScalar : float = 1.0) -> void:
	CurrentHealth = EnemyStats.MaxHealth * DifficultyScalar

func reset() -> void:
	velocity = Vector2.ZERO

func FireShot(target : Node = null, Homing : bool = false) -> void:
	if target && Homing:
		pass
	else:
		var bullet : Node = PoolManager.get_object("res://Scenes/enemy_bullet_basic.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.DOWN, BulletStats)

func take_damage(Damage : int) -> void:
	CurrentHealth -= Damage
	if CurrentHealth <= 0.0:
		return_to_pool()
	

func return_to_pool() -> void:
	if _pool_manager:
		_pool_manager.return_object(self, "res://Scenes/enemy_basic_template.tscn")
	else:
		queue_free()

func _on_timer_timeout():
	FireShot()
