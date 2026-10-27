extends Resource

class_name WaveTemplate

#Structure 
#EnemyCounts[0] = Probability to spawn type [0] enemies to spawn
#Should always be in increasing amounts, example 20% to spawn type [0], 40% type [1], 40% type [2]
# [.2,.6,1.0]
#EnemyTypes[0] = Type of enemy to spawn

@export var EnemyCounts : Array
@export var EnemyTypes : Array
