extends Node2D


func _on_EndingAnimation_animation_finished(anim_name):
	get_tree().change_scene("res://GameWin.tscn")
