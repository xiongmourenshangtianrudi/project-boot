extends Node
@onready var progress_bar: ProgressBar = $Sprite3D/SubViewport/ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = progress_bar.value+1
	print($Sprite3D/SubViewport/ProgressBar.value)
