extends KinematicBody2D


var velocity = Vector2(0,0)
var coins = 0
var health = 3

const SPEED = 180
const ACCEL = 100
const GRAVITY = 30  #40
const JUMPFORCE = -900 #-950

# $ = access another node? another scene?

func _physics_process(delta): #runs 60x per second all the time
	#inputs for walking 
	if Input.is_action_pressed("right"):
		velocity.x = SPEED + ACCEL
		if is_on_floor():
			$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED - ACCEL
		if is_on_floor():
			$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else: 
		$AnimatedSprite.play("idle")

	if not is_on_floor():
		$AnimatedSprite.play("air")
		
	#if coins == 3:
		#get_tree().change_scene("res://Level1.tscn") #get tree is what u use to change scenes


	#the falling, graity kinda
	velocity.y = velocity.y + GRAVITY #assignment oporator, takes whatever value there is and assigns what u add,minus

	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity,Vector2.UP) #what makes our chara move 
	
	#brings velocity back to 0 in incriments, slows down till halt
	velocity.x = lerp(velocity.x,0,0.1) #linear interpelation: to make small changes over time between 2 different numbers


func _on_Fall_Zone_body_entered(body):
	get_tree().change_scene("res://GameOver.tscn")


func bounce():
	velocity.y = JUMPFORCE * 0.7

func ouch(var enemyposx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5
	
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
	
	Input.action_release("left")
	Input.action_release("right")
	
	health -= 1
	get_parent().find_node("HUD").find_node("HealthSprite").frame -= 1
	$Timer.start()


#func add_coin():
	#coins = coins + 1
	#print("Whoa! I now have this many scrap pieces: ", coins)


func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	if health <= 0:
		get_tree().change_scene("res://GameOver.tscn")
	
	#get_tree().change_scene("res://Level1.tscn")
