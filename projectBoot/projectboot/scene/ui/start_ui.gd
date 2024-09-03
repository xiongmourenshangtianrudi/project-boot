extends Control

@onready var button: Button = $Button
@export_file("*.tscn") var next_Scene
# Called when the node enters the scene tree for the first time.
func _on_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_Scene))
	pass # Replace with function body. 


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
