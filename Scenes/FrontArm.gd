extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	#if(abs(self.get_rotation_degrees()) > 90 ):
		#self.set_flip_v(true)
		#$Weapon.set_flip_v(true)
	#else:
		#$Weapon.set_flip_v(false)
		#self.set_flip_v(false)

