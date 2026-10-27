extends Path2D

@export var Waves : Array

var WaveCount : int = 0
var WaveActive : bool = false
var PlayerNode : PlayerShip = null

@onready var SpawnPoint = $"Spawn Position"
@onready var CurrentWave : WaveTemplate = Waves[WaveCount]
@onready var WaveSpawnTimer = $WaveSpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	WaveSpawnTimer.start(2.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func WaveCounter():
	WaveCount += 1

func getWaveCount():
	return WaveCount

func SpawnWaveEnemy():
	SpawnPoint.set_progress_ratio(randf_range(0.0,1.0))
	
	var selectedEnemy : float = randf_range(0.0, 1.0)
	var selectedEnemyName : EnemyStats
	var spawnedEnemy : Enemy = PoolManager.get_object("res://Scenes/enemy_basic_template.tscn")
	
	if selectedEnemy <= CurrentWave.EnemyCounts[0]:
		selectedEnemyName = CurrentWave.EnemyTypes[0]
	else:
		selectedEnemyName = CurrentWave.EnemyTypes[1]
	spawnedEnemy.set_EnemyStats(selectedEnemyName)
	
	if PlayerNode:
		spawnedEnemy.Spawn(SpawnPoint.get_global_position(), PlayerNode)
	else:
		spawnedEnemy.Spawn(SpawnPoint.get_global_position())



func StopSpawning():
	WaveActive = false
	WaveSpawnTimer.set_paused(true)


func _on_wave_lifespan_timer_timeout():
	StopSpawning()

func _on_wave_spawn_timer_timeout():
	SpawnWaveEnemy()

func _on_player_ship_player_ship_pass(Player):
	PlayerNode = Player
