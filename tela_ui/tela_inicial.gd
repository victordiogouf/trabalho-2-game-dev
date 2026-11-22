extends Control

@onready var fundo = $ColorRect

func _ready() -> void:
	var tween = create_tween().set_loops()
	# Muda para vinho em 2 segundos
	tween.tween_property(fundo, "color", Color("#4a0e1e"), 2.0)
	# Muda para roxo escuro em 2 segundos
	tween.tween_property(fundo, "color", Color("#1e0a36"), 2.0)
