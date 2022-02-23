extends CanvasLayer

var coins = 0


func _ready(): #ready is a meathod
	$Coins.text = String(coins)  # text lable is now happy that we turned an integer to a string 

func _physics_process(_delta):
	if coins == 8:
		get_tree().change_scene("res://ending_cutscene.tscn")

func _on_coin_collected():
	coins = coins + 1 #adds 1 to itself, then stores itself into itself
	_ready() #calls it over to update it, since the coin coint on the HUD doesnt always check itself
