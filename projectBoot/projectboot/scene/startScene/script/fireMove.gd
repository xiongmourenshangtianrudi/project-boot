extends PathFollow3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.progress_ratio+= delta*0.1
	pass
