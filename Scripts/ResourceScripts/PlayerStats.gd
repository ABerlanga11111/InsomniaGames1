extends Resource

class_name PlayerStats

@export_category("Basic Stats")
@export var MaxHealth : float = 5.0
@export var Speed : float = 300.0

@export_category("Bullet Stats")
@export var BulletDamage : float = 1.0
@export var BulletSpeed : float = 250.0
@export var BulletScale : Vector2 = Vector2(1.0,1.0)
#Potential future values for different bullet firing patterns
#@export_enum("Straight", "Sinusoidal", "Homing") 
