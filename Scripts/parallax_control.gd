extends Control




@export var FBLScale := 50.0
@export var BLScale := 10.0
@export var TopScale := 25.0

@export var FBL_scroll_speed := 2.0
@export var BL_scroll_speed := 10.0
@export var Top_scroll_speed := 25.0

var FurthestBackLayer : TextureRect
var BackLayer : TextureRect
var MiddleLayer : TextureRect
var TopLayer : TextureRect

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
		FurthestBackLayer.set_position(Vector2(((PlayerLocation.x-PlayerStart.x)/FBLScale)-115.0, ((PlayerLocation.y-PlayerStart.y)/FBLScale)-84.0))
		BackLayer.set_position(Vector2(((PlayerLocation.x-PlayerStart.x)/BLScale)+63.0, ((PlayerLocation.y-PlayerStart.y)/BLScale)+35.0))
		TopLayer.set_position(Vector2(((PlayerLocation.x-PlayerStart.x)/TopScale)-384.0, ((PlayerLocation.y-PlayerStart.y)/TopScale)-216.0))
	else:
		pass
	

func _process(delta: float) ->void:
	if PlayerShip:
		var atlas_tex_top := TopLayer.texture as AtlasTexture
		var atlas_tex_FBL := FurthestBackLayer.texture as AtlasTexture
		var atlas_tex_BL := BackLayer.texture as AtlasTexture
		if atlas_tex_top and atlas_tex_top.atlas:
			var tex_size := atlas_tex_top.atlas.get_size()
			atlas_tex_top.region.position.y -= Top_scroll_speed * delta
			atlas_tex_top.region.position.y = fposmod(atlas_tex_top.region.position.y, tex_size.y)
		if atlas_tex_FBL and atlas_tex_FBL.atlas:
			var tex_size := atlas_tex_FBL.atlas.get_size()
			atlas_tex_FBL.region.position.y -= FBL_scroll_speed * delta
			atlas_tex_FBL.region.position.y = fposmod(atlas_tex_FBL.region.position.y, tex_size.y)
		if atlas_tex_BL and atlas_tex_BL.atlas:
			var tex_size := atlas_tex_BL.atlas.get_size()
			atlas_tex_BL.region.position.y -= BL_scroll_speed * delta
			atlas_tex_BL.region.position.y = fposmod(atlas_tex_BL.region.position.y, tex_size.y)


func _on_player_ship_player_ship_pass(Player: Node) -> void:
	PlayerStart = Player.get_start_pos()
	PlayerShip = Player


func _on_child_entered_tree(node: Node) -> void:
	if node.name == "FurthestBackLayer":
		FurthestBackLayer = node
	elif node.name == "BackLayer":
		BackLayer = node
	elif node.name == "MiddleLayer":
		MiddleLayer = node
	elif node.name == "TopLayer":
		TopLayer = node
