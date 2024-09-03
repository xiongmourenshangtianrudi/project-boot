extends MeshInstance3D
@export var move:Vector3 =Vector3(0,0,0)
@export var duration:float =1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"global_position",
	global_position+move,duration)
	tween.tween_property(self,"global_position",
	global_position,duration)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
