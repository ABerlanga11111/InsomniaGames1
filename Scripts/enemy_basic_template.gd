extends CharacterBody2D

class_name Enemy

@export var EnemyStats : Resource

@onready var CurrentHealth = EnemyStats.MaxHealth
@onready var FireCD = $ShootCDTimer
@onready var BulletStats : Array = [EnemyStats.BulletDamage, EnemyStats.BulletSpeed, EnemyStats.BulletScale, EnemyStats.BulletModulate]

var _pool_manager
var ableToFire : bool = false

func set_pool_manager(manager: Node) -> void:
	_pool_manager = manager

func Spawn(SpawnPosition : Vector2, DifficultyScalar : float = 1.0) -> void:
	CurrentHealth = EnemyStats.MaxHealth * DifficultyScalar
	global_position = SpawnPosition
	FireCD.start(1.5)
	moveUp()

func reset() -> void:
	velocity = Vector2.ZERO

func FireShot(target : Node = null, Homing : bool = false) -> void:
	if CurrentHealth >= 0.0 && ableToFire:
		if target && Homing:
			pass
		else:
			var bullet : Node = PoolManager.get_object("res://Scenes/enemy_bullet_basic.tscn")
			bullet.spawn($Marker2D.global_position,Vector2.DOWN, BulletStats, self)

func take_damage(Damage : int) -> void:
	CurrentHealth -= Damage
	if CurrentHealth <= 0.0:
		FireCD.stop()
		return_to_pool()
	

func moveUp():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC)
	
	tween.tween_property(self, "global_position:y", 150.0, 1.0)
	await get_tree().create_timer(1.0).timeout
	tween.kill()
	ableToFire = true

func return_to_pool() -> void:
	if _pool_manager:
		_pool_manager.return_object(self, "res://Scenes/enemy_basic_template.tscn")
	else:
		queue_free()

func _on_shoot_cd_timer_timeout():
	FireShot()
