extends CharacterBody2D

@export var speed: float

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	var x_dir := Input.get_axis("move-left", "move-right")
	var y_dir := Input.get_axis("move-up", "move-down")

	if x_dir < 0:
		$AnimatedSprite2D.animation = "walk-left"
		$AnimatedSprite2D.play()
	if x_dir > 0:
		$AnimatedSprite2D.animation = "walk-right"
		$AnimatedSprite2D.play()
	if x_dir == 0:
		$AnimatedSprite2D.stop()
	
	velocity = Vector2(x_dir, y_dir).normalized() * speed

	move_and_slide()
