extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
export var multiplier = 1     #multiplier for velocity
var speed = 100   #speed of player
var jump_speed = 175
var touch_ground = true
export (PackedScene) var orb 
var canFire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if linear_velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "stand"
		$AnimatedSprite.stop()
	
	if linear_velocity.x != 0 and touch_ground == true:
		$AnimatedSprite.animation = "move"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = linear_velocity.x < 0
	elif linear_velocity.y != 0:
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.flip_h = linear_velocity.x < 0
		
	
	pass
	
func _integrate_forces(state):
	linear_velocity.x = 0
	if Input.is_action_pressed("ui_left"):  #for moving left
		linear_velocity.x -= multiplier * speed
	if Input.is_action_pressed("ui_right"):  #for moving right
		linear_velocity.x += multiplier * speed
	if Input.is_action_just_pressed("ui_up"):  #for jumping
		if touch_ground == true:
			$jump.play()
			apply_central_impulse(Vector2(0, -jump_speed))
			#add_force(Vector2.ZERO, Vector2(0, -10))


func _on_Area2D_body_entered(touching):
	if touching.get_name() == "Platform" or touching.is_in_group("Platform"):
		touch_ground = true
	if touching.is_in_group("deathbox"):
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")


func _on_Area2D_body_exited(just_left):
	if just_left.get_name() == "Platform" or just_left.is_in_group("Platform"):
		touch_ground = false
		
func _unhandled_input(event):
	if event is InputEventMouseButton and canFire:
		if event.button_index == BUTTON_LEFT: #shoot repel shot
			if event.pressed:
				shoot(true)
				$shoot.play()
		elif event.button_index == BUTTON_RIGHT: #shoot repel shot
			if event.pressed:
				shoot(false)
				$shoot.play()
		var timer = $FireRate
		timer.wait_time = 0.15
		timer.start()
		canFire = false
					
	
		
func shoot(repel):
	var hole = orb.instance()
	get_parent().add_child(hole)
	if hole.has_method("create"):
		var new_hole = hole.create(repel, self.global_position)

func _on_FireRate_timeout():
	canFire = true
	
func getallnodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			print("["+N.get_name()+"]")
			getallnodes(N)
		else:
			# Do something
			print("- "+N.get_name())	

func _on_Player_body_entered(body):
	if body.get_name() == "Laser":
		get_tree().call_group("delete","scene_load")
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")
		$death.play()
	if body.is_in_group("levelend"):
		get_tree().call_group("delete","scene_load")
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")
		$death.play()
	if body.is_in_group("deathbox"):
		get_tree().call_group("delete","scene_load")
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")
		$death.play()
