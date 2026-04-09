extends Area2D

var time
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var player = body
	player.isDead = true
	var animationPlayer = player.get_node("AnimatedSprite2D")
	animationPlayer.play("ghost_walk")
	
	await get_tree().create_timer(5.0).timeout
	
	player.isDead = false
	pass 
