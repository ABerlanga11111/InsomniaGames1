extends CharacterBody2D

class_name PlayerShip

signal PlayerShipPass(Player : Node)

@export var Stats : PlayerStats

@onready var CurrentHealth : float = Stats.MaxHealth
@onready var BulletStats : Array = [Stats.BulletDamage, Stats.BulletSpeed, Stats.BulletScale, Stats.BulletModulate]

var StartPos = Vector2.ZERO
var is_shooting : bool = false

func _ready():
	StartPos = position
	emit_signal("PlayerShipPass", self)
	

func _physics_process(delta):
	
	var x_direction : float = Input.get_axis("MoveLeft","MoveRight")
	var y_direction : float = Input.get_axis("MoveUp","MoveDown")
	
	velocity = Vector2(x_direction,y_direction).normalized()
	velocity = velocity * Stats.Speed
	move_and_slide()
	

func _input(event):
	if event.is_action_pressed("Shoot") && !is_shooting:
		is_shooting = true
		var bullet : Node = PoolManager.get_object("res://Scenes/player_bullet.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.UP,BulletStats,self)
		await get_tree().create_timer(.05).timeout
		bullet = PoolManager.get_object("res://Scenes/player_bullet.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.UP,BulletStats,self)
		await get_tree().create_timer(.05).timeout
		bullet = PoolManager.get_object("res://Scenes/player_bullet.tscn")
		bullet.spawn($Marker2D.global_position,Vector2.UP,BulletStats,self)
		await get_tree().create_timer(.35).timeout
		is_shooting = false

func get_start_pos() -> Vector2:
	return position

func take_damage(damage : float) -> void:
	CurrentHealth -= damage
