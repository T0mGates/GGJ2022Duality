extends Area2D
var pulling = false
var t = 0.0
var object_array = Array()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(pulling):
		for obj in object_array:
			var velocity = Vector2.ZERO
			#obj.get_node("Boulder").t += delta * 0.4
			#t += delta * 0.4
			#obj.position = obj.position.linear_interpolate($Vacuum.position, obj.get_node("Boulder").t)
			
	#my own 'custom' ways for scaling velocity based on how close object is to vacuum... lmk if u think of something better
			if(obj.get_position().x > get_parent().get_position().x):
				#velocity.x -= (obj.get_position().x/get_parent().get_position().x)
				velocity.x -= lerp(1, 8, get_parent().get_position().x/obj.get_position().x)
			else:
				#velocity.x += (obj.get_position().x/get_parent().get_position().x)
				velocity.x += lerp(1, 8, get_parent().get_position().x/obj.get_position().x)
			if(obj.get_position().y > get_parent().get_position().y):
				velocity.y -= lerp(1, 22, get_parent().get_position().y/obj.get_position().y)
			else:
				velocity.y += lerp(1, 22, get_parent().get_position().y/obj.get_position().y)
			velocity = velocity * 3
			#simply adding to velocity will make it possible to still move when getting pulled! (i think)
			obj.linear_velocity += velocity * delta


func _on_Area2D_body_entered(body):
	if body.is_in_group("pullable"):
		pulling = true
		object_array.insert(object_array.size(), body)
	#body.get_node("Boulder").t = 0.0
	


func _on_Area2D_body_exited(body):
	object_array.remove(object_array.find(body, 0))
	if(object_array.size() == 0):
		pulling = false
