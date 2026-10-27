extends Node



@export var scene_templates: Dictionary = {} # Key: scene path, Value: PackedScene
@export var initial_pool_sizes: Dictionary = {} # Key: scene path, Value: initial count



var pools: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for scene_path in scene_templates:
		var scene: PackedScene = scene_templates[scene_path]
		var size: int = initial_pool_sizes.get(scene_path, 10)
		pools[scene_path] = []
		for i in size:
			var obj := scene.instantiate()
			if obj.has_method("set_pool_manager"):
				obj.set_pool_manager(self)
			add_child(obj)
			_deactivate(obj)
			pools[scene_path].append(obj)

func get_object(scene_path: String) -> Node:
	#If the pool is empty, create one on the spot (fallback plus warning)
	if not pools.has(scene_path) or pools[scene_path].is_empty():
		printerr("Pool '%s' is empty. Creating a new one (the size may be too small)" % scene_path)
		var new_obj := (scene_templates[scene_path] as PackedScene).instantiate()
		if new_obj.has_method("set_pool_manager"):
			new_obj.set_pool_manager(self)
		add_child(new_obj)
		return new_obj
	var obj: Node = pools[scene_path].pop_back()
	_activate(obj)
	return obj

func return_object(obj: Node, scene_path: String) -> void:
	if obj in pools.get(scene_path, []): #prevent double returns
		return
	_deactivate(obj) #Stop it before returning it
	pools[scene_path].append(obj)

func _activate(obj: Node) -> void:
	obj.show()
	obj.process_mode = Node.PROCESS_MODE_INHERIT # Resume processing
	_set_collisions_disabled(obj, false)
	

func _deactivate(obj: Node) -> void:
	obj.hide()
	obj.process_mode = Node.PROCESS_MODE_DISABLED	#Stop all processing
	_set_collisions_disabled(obj, true)
	if obj.has_method("reset"):
		obj.reset()		#Return state to its initial value
		

#Enable/disable all descendant CollisionShapes at once
func _set_collisions_disabled(node: Node, disabled: bool) -> void:
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionShape3D:
			child.set_deferred("disabled", disabled) #Deferred for safety during physics
		_set_collisions_disabled(child,disabled)
