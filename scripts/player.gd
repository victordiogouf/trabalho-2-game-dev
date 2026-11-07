extends CharacterBody2D

@export var speed: float

func _physics_process(delta: float) -> void:
	var x_dir := Input.get_axis("move-left", "move-right")
	var y_dir := Input.get_axis("move-up", "move-down")
	
	########################### TODO
	if x_dir < 0:
		pass # use left sprite
	if x_dir > 0:
		pass # use right sprite
	###########################
	
	velocity = Vector2(x_dir, y_dir).normalized() * speed

	move_and_slide()
