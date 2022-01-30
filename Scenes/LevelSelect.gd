extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level1_pressed():
	$haha.play()
	get_tree().change_scene("res://Scenes/level1.tscn")


func _on_Level2_pressed():
	$haha.play()
	get_tree().change_scene("res://Scenes/level2 (1).tscn")


func _on_Level3_pressed():
	$haha.play()
	get_tree().change_scene("res://Scenes/level3.tscn")


func _on_Level4_pressed():
	$haha.play()
	get_tree().change_scene("res://Scenes/level4.tscn")


func _on_Level5_pressed():
	$haha.play()
	get_tree().change_scene("res://Scenes/level5.tscn")


func _on_Level6_pressed():
	$haha.play()
	get_tree().change_scene("res://Scenes/level6.tscn")


func _on_haha_tree_exited():
	$haha.play()
