extends Node2D

var pressed = false
var pressing = false
var realesing = false
export (PackedScene) var plat
export var location = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pressed:
		pass
	if pressing:
		$AnimationPlayer.play("press")
	if realesing:
		$AnimationPlayer.play_backwards("press")
		realesing = false


func _on_Pad_area_entered(area):
	if area.is_in_group("feet") or area.get_name() == "bold":
		pressing = true
		realesing = false
	


func _on_Pad_area_exited(area):
	if area.is_in_group("feet") or area.get_name() == "bold":
		pressing = false
		realesing = true


func _on_AnimationPlayer_animation_finished(anim_name): #pad only activates when realesed
	pressed = true
	pressing = false
	print("bruh")
	var pl = plat.instance()
	pl.create(location)
	get_parent().get_parent().add_child(pl)



