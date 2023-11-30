extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.passe
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tutorial_pressed():
	Global.upd_gf("res://Levels/tutorial.tscn")


func _on_level_1_pressed():
	Global.upd_gf("res://Levels/level1.tscn")


func _on_level_2_pressed():
	Global.upd_gf("res://Levels/level2.tscn")


func _on_level_3_pressed():
	Global.upd_gf("res://Levels/level3.tscn")


func _on_level_4_pressed():
	Global.upd_gf("res://Levels/level4.tscn")


func _on_level_5_pressed():
	Global.upd_gf("res://Levels/level5.tscn")

func _on_level_6_pressed():
	Global.upd_gf("res://Levels/level6.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file(Global.gamefile)
