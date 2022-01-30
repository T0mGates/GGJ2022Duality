extends Area2D
var pulling = false
var t = 0.0
var object_array = Array()

export var min_x_pull = 5.0
export var max_x_pull = 8.0
export var min_y_pull = 5.0
export var max_y_pull = 22.0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(get_parent().get_rotation_degrees() == -90 or get_parent().get_rotation_degrees() == 90):
		min_x_pull = 2500
		max_x_pull = 3500
	if(get_parent().get_rotation_degrees() == 0 or get_parent().get_rotation_degrees() == 180):
		min_y_pull = 700
		max_y_pull = 1400
	

func _create(pos):
	get_parent().global_position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(pulling):
		for obj in object_array:
			var forces = Vector2.ZERO
			#obj.get_node("Boulder").t += delta * 0.4
			#t += delta * 0.4
			#obj.position = obj.position.linear_interpolate($Vacuum.position, obj.get_node("Boulder").t)
			
	#my own 'custom' ways for scaling velocity based on how close object is to vacuum... lmk if u think of something better
			if(obj.get_position().x > get_parent().get_position().x):
				forces.x -= lerp(min_x_pull, max_x_pull, get_parent().get_position().x/obj.get_position().x)
			else:
				forces.x += lerp(min_x_pull, max_x_pull, get_parent().get_position().x/obj.get_position().x)
			if(obj.get_position().y > get_parent().get_position().y):
				forces.y -= lerp(min_y_pull, max_y_pull, get_parent().get_position().y/obj.get_position().y)
			else:
				forces.y += lerp(min_y_pull, max_y_pull, get_parent().get_position().y/obj.get_position().y)
			#simply adding to velocity will make it possible to still move when getting pulled! (i think)
			obj.set_applied_force(obj.get_applied_force() + (forces * delta))


func _on_Area2D_body_entered(body):
	if body.is_in_group("pullable"):
		pulling = true
		object_array.insert(object_array.size(), body)
	#body.get_node("Boulder").t = 0.0
	
func scene_load():
	print("ok")
	queue_free()

func _on_Area2D_body_exited(body):
	if(body.get_applied_force().x > 10):
		body.set_applied_force(Vector2(10, body.get_applied_force().y))
	if(body.get_applied_force().x < 10):
		body.set_applied_force(Vector2(-10, body.get_applied_force().y))
	if(body.get_applied_force().y > 10):
		body.set_applied_force(Vector2(body.get_applied_force().x, 10))
	if(body.get_applied_force().y < 10):
		body.set_applied_force(Vector2(body.get_applied_force().x, -10))
	object_array.remove(object_array.find(body, 0))
	if(object_array.size() == 0):
		pulling = false

