class_name Player extends RigidBody3D

signal up_date_value(maxvalue,currentValue)

var is_trasitioning = false
#var num:int = 42
@export var energy:int =1000
@export var currentEnergy:int =1000
var local_up:Vector3
## 有多大的垂直推力
@export_range(750.0,3000.0 ) var thrust:float = 1000#推力
## 旋转力
@export_range(50.0,200.0) var rotateForce:float = 100

@onready var audio_stream_player_3d: AudioStreamPlayer = $gameFault
@onready var succeed: AudioStreamPlayer = $succeed
@onready var ss:AudioStreamPlayer3D = get_node("fireAcecss")
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles


func _ready() -> void:
	print("hello word")
	#print(num)
	
	
	
func _process(delta: float) -> void:
	emit_signal("up_date_value",energy,currentEnergy)
	local_up = self.basis.y
	if Input.is_action_pressed("boot"):#空格在按下时触发
		var isrun = energy_manager(true,delta)
		if isrun:
			ss.play()
			apply_central_force(basis.y*delta * thrust)#增加向上的力
			booster_particles.emitting=true
		
		
		#self.position.y = position.y+delta
		#print(local_up)
	else:
		booster_particles.emitting=false
		energy_manager(false,delta)
		ss.stop()
	if Input.is_action_pressed("turnLeft"):
		
		apply_torque(Vector3(0.0,0.0,rotateForce*delta))#增加旋转力
		
	if Input.is_action_pressed("turnRight"):
		apply_torque(Vector3(0.0,0.0,-rotateForce*delta))
		
		apply_central_impulse(Vector3.RIGHT*delta)
	#if Input.is_action_just_pressed("ui_cancel"):
		#get_tree().paused = true
	#apply_central_force()
	pass


func crashed_reset_game() -> void :
	print("kaboon")
	explosion_particles.emitting=true
	booster_particles.emitting=false
	set_process(false)
	is_trasitioning=true
	audio_stream_player_3d.play()
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	#重新加载场景
	pass
	
func complete_level(next_level_file: String)->void: #通关进入下一关
	success_particles.emitting=true
	var tween = create_tween()
	set_process(false)
	is_trasitioning=true
	succeed.play()#播放成功音效
	tween.tween_interval(2.5)#等待2.5秒
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
	#get_tree().change_scene_to_file(next_level_file)#加载场景
	

func _on_body_entered(body: Node) -> void:
	#if body.name == "downfloor":    这里检测碰撞体的名字
		#print("game win")
	if is_trasitioning == false:
		if "Goal" in body.get_groups():
			print("level complete")
			call_deferred("complete_level",body.next_Scene)#延迟加载场景
		
		
		if "hazard" in body.get_groups(): #
			crashed_reset_game()
			#print("you lost")
	pass # Replace with function body.
	
	
func energy_manager(state: bool,delta:float) -> bool:
	if state :
		currentEnergy-=1*delta
		print(currentEnergy)
		if currentEnergy>0:
			return true
		else:
			return false
	else:
		if currentEnergy < energy :
			currentEnergy+=1
			print(currentEnergy)
		return true	
	pass
	
