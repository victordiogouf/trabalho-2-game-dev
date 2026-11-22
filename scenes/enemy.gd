extends CharacterBody2D

signal collision_with_player

enum EnemyType {
	oni,
	banshee,
	medusa
}

var speed := 20.0
var min_rect: Vector2
var max_rect: Vector2
var type: EnemyType
var min_level: int
var max_level: int

var direction: Vector2

var data: GameState.Enemy

func _ready() -> void:
	direction.x = randf()
	direction.y = randf()
	direction = direction.normalized()
	position = Vector2(randf_range(min_rect.x, max_rect.x), randf_range(min_rect.y, max_rect.y))
	
	match type:
		EnemyType.oni: 
			data = GameState.create_oni(min_level, max_level)
			$AnimatedSprite2D.animation = "boss-overworld-oni"
		EnemyType.banshee: 
			data = GameState.create_banshee(min_level, max_level)
			$AnimatedSprite2D.animation = "boss-vagao-banshee"
		EnemyType.medusa: 
			data = GameState.create_medusa(min_level, max_level)
			$AnimatedSprite2D.animation = "inimigo-medusa"
	
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	if position.x < min_rect.x:
		direction.x = abs(direction.x)
	if position.x > max_rect.x:
		direction.x = -abs(direction.x)
		
	if position.y < min_rect.y:
		direction.y = abs(direction.y)
	if position.y > max_rect.y:
		direction.y = -abs(direction.y)
	
	velocity = direction * speed

	move_and_slide()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#Enemy collided with player
		modulate = Color(1, 0, 0)
		collision_with_player.emit(self)
