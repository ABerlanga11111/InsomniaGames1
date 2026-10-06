extends Control




@export var FBLScale := 50.0
@export var BLScale := 10.0

var FurthestBackLayer : TextureRect
var BackLayer
var PlayerShip : Node
var PlayerStart : Vector2
var ViewPortSize : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if PlayerShip:
		var PlayerLocation : Vector2 = PlayerShip.get_global_position()
		FurthestBackLayer.set_position(Vector2((PlayerLocation.x-PlayerStart.x)/FBLScale, (PlayerLocation.y-PlayerStart.y)/FBLScale))
		BackLayer.set_position(Vector2((PlayerLocation.x-PlayerStart.x)/BLScale, (PlayerLocation.y-PlayerStart.y)/BLScale))
	else:
		pass
	pass


func _on_player_ship_player_ship_pass(Player: Node) -> void:
	PlayerStart = Player.get_start_pos()
	PlayerShip = Player


func _on_child_entered_tree(node: Node) -> void:
	if node.name == "FurthestBackLayer":
		FurthestBackLayer = node
	elif node.name == "BackLayer":
		BackLayer = node
