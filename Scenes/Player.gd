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
	pass # Replace with function body.


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
			apply_impulse(Vector2(), Vector2(0, -jump_speed))


func _on_Area2D_body_entered(touching):
	if touching.get_name() == "Platform":
		touch_ground = true


func _on_Area2D_body_exited(just_left):
	if just_left.get_name() == "Platform":
		touch_ground = false
		
func _unhandled_input(event):
	if event is InputEventMouseButton and canFire:
		if event.button_index == BUTTON_LEFT: #shoot repel shot
			if event.pressed:
				shoot(true)
		elif event.button_index == BUTTON_RIGHT: #shoot repel shot
			if event.pressed:
				shoot(false)
		var timer = $FireRate
		timer.wait_time = 0.15
		timer.start()
		canFire = false
					
	
		
func shoot(repel):
	var hole = orb.instance()
	get_parent().add_child(hole)
	if hole.has_method("create"):
		hole.create(repel, self.global_position)
		


func _on_FireRate_timeout():
	canFire = true
