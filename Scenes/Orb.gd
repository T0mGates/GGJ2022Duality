extends RigidBody2D

var hasHit = false
var isRepel = false
var rot = 90
var velocity = Vector2()
export var speed = 10
export (PackedScene) var repel 
export (PackedScene) var vacuum 
var ready = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.play()
	
	
func _physics_process(delta):
	position += Vector2(1*speed,1*speed)


func create(repel, pos):
	isRepel = repel
	self.global_position = pos
	var start_pos = self.global_position
	var direction = (get_global_mouse_position() - start_pos)
	self.linear_velocity = direction * speed
	


func _on_orb_body_entered(body):
	var rotation_needed = 0
	if body.is_in_group("terrain") and ready:
		hasHit = true
		if(body.is_in_group("up")):
			rotation_needed = 180
		elif(body.is_in_group("down")):
			rotation_needed = 0
		elif(body.is_in_group("right")):
			rotation_needed = -90
		elif(body.is_in_group("left")):
			rotation_needed = 90
		if isRepel == true:
			var re = repel.instance()
			re.get_child(0)._create(self.global_position)
			re.set_rotation_degrees(rotation_needed)
			get_parent().get_parent().add_child(re)
		else:
			var va = vacuum.instance()
			va.get_child(0)._create(self.global_position)
			va.set_rotation_degrees(rotation_needed)
			get_parent().get_parent().add_child(va)
		queue_free() #destroy its self


func _on_viable_timeout():
	ready = true


func _on_DeathTimer_timeout(): #if its been active for a full "time" it gets removed
	queue_free()
