extends Control



var ispaused:bool = false
@onready var progress_bar: ProgressBar = $"../GUI/ProgressBar"

func _ready() -> void:
	get_node("../../Player").connect("up_date_value",self._on_update_values)
	#链接信号
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		self.show()
		ispaused = !ispaused

func _on_yes_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_no_pressed() -> void:
	self.hide()
	ispaused = !ispaused

	pass # Replace with function body.

func _on_update_values(maxvalue,currentValue):
	progress_bar.max_value = maxvalue
	progress_bar.value = currentValue
	pass
	
