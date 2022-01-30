extends Node2D


var hasHit = false
var isRepel = false
var velocity = Vector2()
export var speed = 4
var repel = "res://Scenes/Repel.tscn"
var vacuum = "res://Scenes/Vacuum.tscn"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while hasHit == false:
		$AnimatedSprite.play()
	
	
func _physics_process(delta):
	$RigidBody2D.linear_velocity.x += speed * delta
	$RigidBody2D.linear_velocity.y += speed * delta

func _on_Orb_body_entered(body):
	if body.is_in_group("terrain"):
		hasHit = true
		if isRepel == true:
			var r = load(repel)
			var re = r.instance()
			add_child_below_node(get_tree().get_root().get_node("Camera2D"), re)
		else:
			var v = load(vacuum)
			var va = v.instance()
			add_child_below_node(get_tree().get_root().get_node("Camera2D"), va)
		queue_free() #destroy its self

func create(repel, des, spawn):
	isRepel = repel
	look_at(des) #point towords mouse
	self.position = spawn + Vector2(3,1)
	
