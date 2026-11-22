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
func temporary_invincibility() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, false)
	modulate=Color("#6082B6")
	await get_tree().create_timer(5.0).timeout
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)
	modulate=Color(1,1,1)
