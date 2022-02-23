extends Area2D

signal coin_collected #custom signal, must connect to another func or meathod to make it work
	#coin in here doesnt know whats on the scene, to link a signal, must go to each individual piece of a level

func _on_scrap_body_entered(body):
	
	$AnimationPlayer.play("bounce")
	#queue_free() #clears the queue, ie insta deletes it
	#body.add_coin() if any other body were to colide with this, the game would crash, hence the importance for layers
	emit_signal("coin_collected")
	set_collision_mask_bit(0,false) #turns collision mask off right after player has entered in a coin

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
